/*
### Mostrando toda a hierarquia de categorias ###

Esse query busca mostrar toda hierarquia de categorias da database de
maneira útil para leitura humana e para máquinas.

A relação completa de 3 níveis é exibida para leitura humana, e o id
da categoria de menor nível é exibida na primeira coluna para leitura
de máquina.

Essa coluna, id_cat, foi útil em outros queries justamente por revelar
o menor nível sem necessidade de lógica extra em queries que consultem
este por meio de uma view.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_categorias_completas AS

/*
Listando as categorias raizes primeiro.

LEFT JOIN não gera linha sem matches caso já exista algum match. Ou seja
caso exista uma certa combinação de pai, filho e neto, não existirá
linha com apenas pai e filho, ou apenas pai.

Esse comportamente exclui categorias que não possuem descendentes, como
"Outros". Por isso a listagem de raizes: para prevenir que essa, e outras
categorias que possam vir a existir, sejam excluídas.
*/

SELECT
	id AS id_cat,
	id AS id_pai,
	NULL::SMALLINT as id_filho, -- Type casting por segurança
	NULL::SMALLINT as id_neto, -- Type casting por segurança
	nome AS pai,
	NULL::TEXT AS filho, -- Type casting por segurança
	NULL::TEXT AS neto -- Type casting por segurança
FROM cat_mov
WHERE id_pai IS NULL -- Apenas categorias raizes

UNION

-- Restante da hierarquia.
SELECT
	CASE
		WHEN cm3.id IS NOT NULL THEN cm3.id
		WHEN cm2.id IS NOT NULL THEN cm2.id
		ELSE cm1.id END
	AS id_cat, -- Lógica que exibe o id do nível mais baixo da relação.
	cm1.id AS id_pai,
	cm2.id AS id_filho,
	cm3.id AS id_neto,
	cm1.nome AS pai,
	cm2.nome AS filho,
	cm3.nome AS neto
FROM cat_mov cm1 -- Pais
LEFT JOIN cat_mov cm2 ON cm1.id = cm2.id_pai -- Filhos
LEFT JOIN cat_mov cm3 ON cm2.id = cm3.id_pai -- Netos
WHERE cm1.id_pai IS NULL; -- Impedindo que filhos e netos apareçam como pais

COMMIT;

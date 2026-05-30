/*
### CONTROLE DE DÍVIDAS DE CARTÕES ###

Esse query busca todos os cartões, agrega suas dívidas, o quanto
foi amortizado, o quando foi estornado, o quando foi provisionado
globalmente, calcula a dívida restante e calcula a diferença entre
não amortizado e provisionado.

OBS I: Criei CTEs escalares para diminuir ao máximo a quantidade
de dados que necessitam de um join sem join field. CROSS JOINs se
tornam caros muito rapidamente e desejo a maior agilidade o possível
mesmo em máquinas mais simples.

OBS II : Usei ids hardcodes por não ter nenhum benefício em
priorizar o hardcoding de nomes por subqueries que procurem seus ids.
Mais lentidão sem nenhum benfício fora legibilidade. De qualquer
maneira, adicionei comentários para facilitar a leitura.

OBS III: Futuramente tenho planos para estratificar as dívidas para um
controle mes a mes das faturas. Suponho que precise de capacidades que fogem
do que o SQL pode oferecer, uma vez que precisa criar compromissos novos caso
algum parcelamento esteja em um mês ainda não registrado. Além disso, isso é
inviável de se manter manualmente, então mantive essa escolha de design
onde o controle é unificado.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_controle_dividas_cartoes AS

WITH divida AS ( -- Dividas totais
	SELECT SUM(m.valor) divida
	FROM movimentacoes m
	INNER JOIN compromissos c ON m.id_compromisso = c.id
	WHERE
		(m.conta_origem IS NULL AND m.conta_destino IS NULL) AND
		m.id_compromisso IS NOT NULL AND
		c.id_natureza = 1 AND
		m.id_cat != 3 -- Estorno de dívida (Pai: 4, Amortização)
), amortizado AS ( -- Valor já amortizado
	SELECT SUM(m.valor) AS amortizado
	FROM movimentacoes m
	INNER JOIN compromissos c ON m.id_compromisso = c.id
	WHERE
		(m.conta_origem IS NOT NULL AND m.conta_destino IS NULL) AND
		m.id_compromisso IS NOT NULL AND
		c.id_natureza = 1 AND
		m.id_cat = 19 -- Pagamento (Pai: 4, Amortização)
), estornado AS ( -- Valor estornado à fatura
	SELECT SUM(m.valor) AS estornado
	FROM movimentacoes m
	INNER JOIN compromissos c ON m.id_compromisso = c.id
	WHERE
		(m.conta_origem IS NULL AND m.conta_destino IS NULL) AND
		m.id_compromisso IS NOT NULL AND
		c.id_natureza = 1 AND
		m.id_cat = 3 -- Estorno de dívida (Pai: 4, Amortização)
), provisionado AS ( -- Quanto ja foi provisionado para cobrir as dívidas restantes
	-- TODO: conta 9 (provisão de cartões) é um ID temporário. Substituir por lookup
	--       dinâmico quando contas forem padronizadas entre instâncias.
	SELECT
		(SUM(CASE WHEN conta_destino = 9 THEN valor ELSE 0 END) - SUM(CASE WHEN conta_origem = 9 THEN valor ELSE 0 END)) AS provisionado
	FROM movimentacoes
)
SELECT
	d.divida,
	a.amortizado,
	e.estornado,
	p.provisionado,
	d.divida - (a.amortizado + e.estornado) AS nao_amortizado,
	(d.divida - (a.amortizado + e.estornado)) - p.provisionado AS divida_nao_provisionada
FROM divida d
-- Cross joins entre escalares não escalam cartesianamente
CROSS JOIN amortizado a
CROSS JOIN estornado e
CROSS JOIN provisionado p;

COMMIT;

/*
### SALDOS DE TODAS CONTAS ###

Esse query busca retornar os saldos de todas contas sem incluir nenhum
valor hardcoded, sendo completamente dinâmico. Calcula as entradas all
time de cada conta, as saídas all time de cada conta e calcula a diferença
para encontrar o saldo atual.

OBS I: Para filtrar por tempo basta adicionar o DATE_TRUNC no WHERE dos
CTEs. Então, infelizmente, não pode ser filtrada por uma view. Mas posso
buscar futuramente um método para fazer isso.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_saldo_contas AS

-- CTEs com entradas e saídas agrupadas por contas
WITH
	entradas AS (
		SELECT
			conta_destino,
			SUM(valor) AS entrada
		FROM movimentacoes
		WHERE conta_destino IS NOT NULL
		GROUP BY conta_destino
	),
	saidas AS (
		SELECT
			conta_origem,
			SUM(valor) AS saida
		FROM movimentacoes
		WHERE conta_origem IS NOT NULL
		GROUP BY conta_origem
	)
SELECT
	c.id,
	c.nome,
	c.id_bem,
	( (COALESCE(e.entrada, 0)) - (COALESCE(s.saida, 0)) ) AS resultado
FROM contas c -- Contas como âncora é útil para entregar ids sem transações
/*
JOINs sempre com c.id para prevenir exclusões de dados que são clássicas
em joins em cadeia
*/
LEFT JOIN entradas e ON c.id = e.conta_destino
LEFT JOIN saidas s ON c.id = s.conta_origem
WHERE encerrado_em IS NULL
ORDER BY id;

COMMIT;

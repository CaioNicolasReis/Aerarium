-- DRE DE FLUXO DE CAIXA
-- Demonstração do Resultado do Exercício que INCLUI aquisições como gastos

BEGIN;

CREATE OR REPLACE VIEW public.vw_dre_fluxo_de_caixa AS

WITH
	meses_reais AS (
		SELECT
			DATE_TRUNC('month', GENERATE_SERIES(
				GREATEST( -- Seleciona o mais recente entre os dois. Ou a primeira movimentação registrada, ou 5 anos atrás. Isso é uma trava para evitar problemas com o CROSS JOIN mais a frente.
					(SELECT MIN(data_evento) FROM movimentacoes),
					CURRENT_DATE - INTERVAL '5 years'
				),
				CURRENT_DATE,
				INTERVAL '1 month'
			)) AS mes
	)
SELECT
	cc.id_cat, cc.pai, cc.filho, cc.neto,
	mr.mes,
	CASE
		WHEN cc.pai = 'Receita' THEN 'Entrada'
		WHEN cc.filho = 'Empréstimo tomado' THEN 'Entrada'
		WHEN cc.pai = 'Venda de bem' THEN 'Entrada'
		WHEN cc.pai IN ('Gasto', 'Manutenção de bem') THEN 'Saída'
		WHEN cc.filho = 'Empréstimo concedido' THEN 'Saída'
		WHEN cc.pai = 'Aquisição de bem' THEN 'Saída'
		WHEN cc.pai = 'Imposto' THEN 'Saída'
	END AS direcao,
	COALESCE(SUM(m.valor), 0) AS valor
FROM meses_reais mr
CROSS JOIN vw_categorias_completas cc
LEFT JOIN movimentacoes m ON
	cc.id_cat = m.id_cat AND
	mr.mes = DATE_TRUNC('month', m.data_liquidacao)
WHERE
	cc.pai IN ('Receita', 'Gasto', 'Crédito', 'Manutenção de bem', 'Aquisição de bem', 'Venda de bem', 'Imposto') AND
	cc.filho != 'Depreciação'
GROUP BY cc.id_cat, cc.pai, cc.filho, cc.neto, mr.mes
ORDER BY direcao, pai, filho, neto, mes;

COMMIT;

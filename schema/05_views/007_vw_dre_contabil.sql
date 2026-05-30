/*
### DRE CONTÁBIL ###

Demonstração do Resultado do Exercício que não inclui aquisições como gastos.
Inclui todas entradas e saídas que afetem o patrimônio líquido. Transferências,
Aquisições e Vendas de Bens não alteram o patrimônio líquido.

Primeiro é criado uma lista de meses com GENERATE_SERIES. Essa lista começa na
primeira movimentação registrada na database; todavia, caso essa data esteja a
mais que 5 anos de distância de hoje, a data inicial será de 5 anos atrás do
dia atual. Isso evita extrapolar a quantidade de linhas geradas pelo CROSS JOIN
feito posteriormente sobre o anchor pattern feito por essa lista de meses.

Isso cria uma tabela com todas combinações entre categoria e mês.

OBS I: Tomei a decisão de incluir categorias raizes também para permitir maior
flexibilidade no uso da view.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_dre_contabil AS

WITH
	meses_reais AS (
		SELECT
			DATE_TRUNC('month', GENERATE_SERIES(
				GREATEST(
					(SELECT MIN(data_evento) FROM movimentacoes),
					CURRENT_DATE - INTERVAL '5 years'
				),
				CURRENT_DATE + INTERVAL '1 month',
				INTERVAL '1 month'
			)) AS mes
	)
SELECT
	cc.id_cat, cc.pai, cc.filho, cc.neto,
	mr.mes, -- Timestamp permite truncar ou modificar data na saída da view
	-- Lógica que define claramente se a categoria representa entrada ou saídas sem ter que alterar a coluna de valor
	CASE
		WHEN cc.pai = 'Receita' THEN 'Entrada'
		WHEN cc.filho = 'Empréstimo tomado' THEN 'Entrada'
		WHEN cc.pai IN ('Gasto', 'Manutenção de bem', 'Imposto') THEN 'Saída'
		WHEN cc.filho = 'Empréstimo concedido' THEN 'Saída'
	END AS direcao,
	COALESCE(SUM(m.valor), 0) AS valor
FROM meses_reais mr
CROSS JOIN vw_categorias_completas cc -- Produto cartesiano relevante. Capado na série máxima de 5 anos.
LEFT JOIN movimentacoes m ON
	cc.id_cat = m.id_cat AND -- Alinhando tabelas por categoria
	mr.mes = DATE_TRUNC('month', m.data_liquidacao) -- Alinhando tabelas por mês
WHERE cc.pai IN ('Receita', 'Gasto', 'Crédito', 'Manutenção de bem', 'Imposto')
GROUP BY cc.id_cat, cc.pai, cc.filho, cc.neto, mr.mes
ORDER BY pai, filho, neto, mes; -- Desperdício numa view, mas presente para faciltiar manutenção

COMMIT;

/*
### CONTROLE DE DEPRECIAÇÕES ###

Calcula sobre o valor contábil, valor residual esperado e o tempo de vida útil
a depreciação mensal. Procura a provisão e a diferença com o valor de depreciação
acumulada desde a aquisição do bem.

Por agora, a depreciação é exclusivamente linear. Futuramente, possivelmente na 2.0
ou em preparação para a mesma, irei adicionar outros tipos de depreciação ajustáveis
que melhor atendam a realidade de cada tipo de bem. Imagino que cada tipo de bem possa
ter seu cálculo automáticamente selecionado, mas com a possibilidade de selecionar
outro tipo.

O cálculo se baseia em:

(valor contabil - (valor contabil * valor residual)) / vida util meses
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_controle_depreciacoes AS

WITH
	aquisicoes AS ( -- Definindo valor de aquisição e o valor contábil de cada bem
		SELECT
			m.id_bem,
			SUM(CASE WHEN m.id_cat IN(26, 27, 28, 29, 30, 31, 83, 112) THEN valor ELSE 0 END) AS valor_aquisicoes,
			SUM(CASE WHEN m.id_cat IN(10, 26, 27, 28, 29, 30, 31, 83, 112) THEN valor ELSE 0 END) -
			SUM(CASE WHEN m.id_cat = 11 THEN m.valor ELSE 0 END) AS valor_contabil
		FROM movimentacoes m
		INNER JOIN bens b ON m.id_bem = b.id
		WHERE
			m.id_bem IS NOT NULL AND
			m.id_cat IN(10, 11, 26, 27, 28, 29, 30, 31, 83, 112) AND -- 11 = reajuste negativo; 10 = reajuste positivo
			b.encerrado_em IS NULL
		GROUP BY id_bem
	), provisionado AS ( -- Procurando por provisionado [agrupado] por bem
		SELECT
			id_bem,
			SUM(resultado) AS provisionado
		FROM vw_saldo_contas
		WHERE id_bem IS NOT NULL
		GROUP BY id_bem
	), calculos AS ( -- Cálculos repetidos mais de uma vez. Comprimindo tamanho do query
		SELECT
			b.id AS id_bem,
			b.nome AS bem,
			b.data_aquisicao,
			b.valor_residual,
			b.vida_util_meses,
			a.valor_aquisicoes,
			a.valor_contabil,
			(a.valor_contabil - (a.valor_contabil * b.valor_residual)) / b.vida_util_meses
				AS depreciacao_mensal, -- Depreciação linear mensalizada
			DATE_PART('year', AGE(CURRENT_DATE, b.data_aquisicao)) * 12 +
			DATE_PART('month', AGE(CURRENT_DATE, b.data_aquisicao))
				AS meses_decorridos, -- Contando meses decorridos nos anos e meses passados
			a.valor_contabil - (a.valor_contabil * b.valor_residual)
				AS valor_depreciavel, -- Valor que sera tomado pela depreciação
			LEAST( -- Impedindo que depreciação acumulada seja menor que o valor residual
				((a.valor_contabil - (a.valor_contabil * b.valor_residual)) / b.vida_util_meses) *
				(DATE_PART('year', AGE(CURRENT_DATE, b.data_aquisicao)) * 12 +
				DATE_PART('month', AGE(CURRENT_DATE, b.data_aquisicao))), -- Valor acumulado desde o início do bem
				a.valor_contabil - (a.valor_contabil * b.valor_residual)) -- Valor depreciável
			AS depreciacao_acumulada -- Quanto já foi depreciado
		FROM bens b
		LEFT JOIN aquisicoes a ON b.id = a.id_bem
		WHERE
			b.encerrado_em IS NULL AND
			b.valor_residual IS NOT NULL AND
			b.vida_util_meses IS NOT NULL
	)
SELECT
	c.id_bem,
	c.bem,
	c.valor_aquisicoes,
	c.valor_contabil,
	ROUND(c.valor_depreciavel, 2) AS valor_depreciavel,
	ROUND(c.depreciacao_mensal, 2) AS depreciacao_mensal,
	c.meses_decorridos,
	ROUND(c.depreciacao_acumulada::numeric, 2) AS depreciacao_acumulada, -- Type casting para ROUND
	ROUND(c.valor_contabil - c.depreciacao_acumulada::numeric, 2) AS valor_atual,
	COALESCE(p.provisionado, 0.00) AS provisionado,
	COALESCE(ROUND(COALESCE(p.provisionado, 0) - c.depreciacao_acumulada::numeric, 2), 0.00)  -- Type casting para ROUND
		AS diferenca -- Diferença entre provisionado e a depreciação acumulada linearmente
FROM calculos c
LEFT JOIN provisionado p ON c.id_bem = p.id_bem;

COMMIT;

/*
### RESULTADOS MÊS A MÊS ###

Evolução de cada conta registrada pelos meses desde a primeira movimentação
da database. Essa é a única forma de manter a consistência entre o valor
real da conta e o valor registrado; caso ignore alguns meses, o valor estará,
necessáriamente, incorreto. Isso pode se tornar problemático conforme a
database crescer já que essa query apresenta um CROSS JOIN. Essa é uma limitação
conhecida que deve ser atacada em atualizações futuras.

Esse query cria uma série de meses e não inclui meses que ainda não aconteceram,
calcula as entradas em cada conta em cada mês, calcula as saídas em cada conta
e em cada mês, e entrega a diferença entre entrada e saída de todos meses que
já aconteceram do ano atual, inclusive os vazios.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_evolucao_contas AS

WITH
	-- Gerando série do começo até o dia atual em passos de 1 mes
	meses AS (
		SELECT -- FROM não necessário, dados gerados agora
			DATE_TRUNC('month', generate_series( -- Gerando série com generate_series
				(SELECT MIN(data_evento) FROM movimentacoes), -- Iniciando na primeira movimentação da DB
				CURRENT_DATE, -- Terminando no dia atual
				INTERVAL '1 month' -- Passos de 1 mês
			)) AS mes
	),
	entradas AS ( -- Valor de entrada por mês por conta
		SELECT
			conta_destino,
			SUM(valor) AS entrada,
			DATE_TRUNC('month', data_liquidacao) mes
		FROM movimentacoes
		WHERE conta_destino IS NOT NULL --
		GROUP BY conta_destino, mes
	),
	saidas AS ( -- Valor de saída por mês por conta
		SELECT
			conta_origem,
			SUM(valor) AS saida,
			DATE_TRUNC('month', data_liquidacao) mes
		FROM movimentacoes
		WHERE conta_origem IS NOT NULL
		GROUP BY conta_origem, mes
	)
SELECT
	c.id,
	c.nome,
	m.mes,
	SUM((COALESCE(e.entrada, 0)) - (COALESCE(s.saida, 0))) OVER (
		PARTITION BY c.id
		ORDER BY m.mes
	) saldo_acumulado,
	( (COALESCE(e.entrada, 0)) - (COALESCE(s.saida, 0)) ) AS resultado_mes
FROM meses m -- Anchaor pattern com âncora nos meses
CROSS JOIN contas c -- Todas combinações possíveis de conta e mes
/*
Join em m.mes para manter valores nulos em meses sem movimentações
e em c.id para alinhar os valores com as contas corretas.
*/
LEFT JOIN entradas e ON c.id = e.conta_destino AND m.mes = e.mes
LEFT JOIN saidas s ON c.id = s.conta_origem AND m.mes = s.mes;

COMMIT;

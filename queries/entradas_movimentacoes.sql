SELECT
	id,
	data_evento,
	data_liquidacao,
	valor,
	operacao,
	conta_origem,
	conta_destino,
	id_cat,
	id_compromisso,
	id_bem,
	id_status,
	obs
FROM movimentacoes
ORDER BY data_evento DESC, id 
/*
MOVIMENTAÇÕES COMPLETAS

Tabela completa com todas relações de movimentacoes explicitadas, incluindo
surrogate keys e os dados que essas representam. Útil para visualizações
de relações sem a necessidade de declarar joins por meio de views.

Além dos dados diretamente relacionados por meio de chaves estrangeiras,
algumas hierarquias completas, como as de categorias, também são explicitadas
nesse query.

Não obstante, relações entre as demais tabelas também estão sendo
exibidas. Como por exemplo: movimentacoes > contas > entidades; e
movimentacoes > compromissos > natureza_compromissos.
*/

BEGIN;

CREATE OR REPLACE VIEW public.vw_movimentacoes AS

SELECT
    -- movimentacoes
    m.id,
    m.data_evento,
    m.data_liquidacao,
    m.valor,
    m.operacao,
    m.obs,

    -- status
    m.id_status,
    st.nome AS status,

    -- categorias (utilizando view da hierarquia completa de categorias)
	m.id_cat,
	cc.id_pai,
	cc.id_filho,
	cc.id_neto,
	cc.pai,
	cc.filho,
	cc.neto,
	CONCAT(
		cc.pai,
		CASE WHEN cc.filho IS NOT NULL THEN ' > ' || cc.filho ELSE '' END,
		CASE WHEN cc.neto IS NOT NULL THEN ' > ' || cc.neto ELSE '' END
	) AS cat_completa,

    -- conta origem
    m.conta_origem AS id_conta_origem,
    con_orig.nome AS conta_origem,
    m.conta_destino AS id_conta_destino,
    con_dest.nome AS conta_destino,

    -- entidade origem e destino via contas
    con_orig.id_entidade AS id_entidade_origem,
    ent_orig.nome AS entidade_origem,
    con_dest.id_entidade AS id_entidade_destino,
    ent_dest.nome AS entidade_destino,

    -- compromisso
    m.id_compromisso,
    com.nome,
    com.data_vencimento AS compromisso_vencimento,
    com.id_natureza AS id_natureza_compromisso,
    nc.nome AS natureza_compromisso,

    -- bem
    m.id_bem,
    b.nome AS bem,
    b.id_tipo AS id_tipo_bem,
    tb.nome AS tipo_bem

FROM movimentacoes m
LEFT JOIN status st ON m.id_status = st.id
LEFT JOIN vw_categorias_completas cc ON m.id_cat = cc.id_cat
LEFT JOIN contas con_orig ON m.conta_origem = con_orig.id
LEFT JOIN contas con_dest ON m.conta_destino = con_dest.id
LEFT JOIN entidades ent_orig ON con_orig.id_entidade = ent_orig.id
LEFT JOIN entidades ent_dest ON con_dest.id_entidade = ent_dest.id
LEFT JOIN compromissos com ON m.id_compromisso = com.id
LEFT JOIN naturezas_compromissos nc ON com.id_natureza = nc.id
LEFT JOIN bens b ON m.id_bem = b.id
LEFT JOIN tipos_bens tb ON b.id_tipo = tb.id
ORDER BY m.data_evento DESC, m.id DESC;

COMMIT;

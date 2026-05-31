/*
## CHEAT SHEET

Todas tabelas e views relevantes em uma lista simples para consulta.

Todos queries já estão ordenados de maneira lógica, mas sem filtros — fora os de ordem.

Organizados por tipo: Tabelas de Dados, Tabelas de Referências e Views de Controle. 

- As tabelas de dados são completamente mutaveis e seus ids devem não devem 
  estar hardcodados em views (trabalho em progresso).
- As tabelas de referência são fixas, apesar de poderem ser adaptadas. Podem ids
  ser aplicadps em outras views sem prejudicar o funcionamento.
- As Views são queries úteis e padronizados que utilizam as categorias anterioes.
*/

-- TABELAS DE DADOS
SELECT * FROM entidades ORDER BY id;

SELECT * FROM contas ORDER BY id;

SELECT * FROM bens ORDER BY id;

SELECT * FROM movimentacoes ORDER BY id;

SELECT * FROM compromissos ORDER BY id;

SELECT * FROM cotacoes ORDER BY id;

-- TABELAS DE REFERÊNCIAS
SELECT * FROM cat_mov ORDER BY nome;

SELECT * FROM naturezas_compromissos ORDER by  id;

SELECT * FROM tipos_entidades ORDER BY id;

SELECT * FROM tipos_bens ORDER BY id;

SELECT * FROM moedas ORDER BY id;

SELECT * FROM status ORDER BY id;

-- VIEWS DE CONTROLE
SELECT * FROM vw_movimentacoes ORDER BY data_evento DESC, data_liquidacao DESC, id DESC;

SELECT * FROM vw_categorias_completas ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;

SELECT * FROM vw_saldo_contas ORDER BY id;

SELECT * FROM vw_evolucao_contas ORDER BY id, mes DESC;

SELECT * FROM vw_controle_dividas_cartoes;

SELECT * FROM vw_controle_depreciacoes ORDER BY id_bem;
 
SELECT * FROM vw_dre_contabil ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;

SELECT * FROM vw_dre_fluxo_de_caixa ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;
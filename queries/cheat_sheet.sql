/*
## CHEAT SHEET

Todas tabelas e views relevantes em uma lista simples para consulta.

Todos queries já estão ordenados de maneira lógica, mas sem filtros fora de ordem.

Organizados por tipo: Tabelas de Dados, Tabelas de Referências e Views. 

- As tabelas de dados são completamente mutaveis e seus ids devem não devem 
  estar hardcodados em views.
- As tabelas de referência são fixas, apesar de poderem ser adaptadas. Podem ids
  ser aplicadps em outras views sem prejudicar o funcionamento.
- As Views são queries úteis e padronizados que utilizam as categorias anterioes.
*/

-- TABELAS DE DADOS
SELECT * FROM entidades ORDER BY id;

SELECT * FROM contas ORDER BY id;

SELECT * FROM bens ORDER BY id;

select * from movimentacoes order by id;

select * from compromissos order by id;

select * from cotacoes order by id;

-- TABELAS DE REFERÊNCIAS
select * from cat_mov order by nome;

select * from naturezas_compromissos order by id;

SELECT * FROM tipos_entidades ORDER BY id;

SELECT * FROM tipos_bens ORDER BY id;

SELECT * FROM moedas ORDER BY id;

select * from status order by id;

-- VIEWS
SELECT * FROM vw_movimentacoes ORDER BY data_evento DESC, data_liquidacao DESC, id DESC;

SELECT * FROM vw_categorias_completas ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;

SELECT * FROM vw_saldo_contas ORDER BY id;

SELECT * FROM vw_evolucao_contas ORDER BY id, mes DESC;

SELECT * FROM vw_controle_dividas_cartoes;

SELECT * FROM vw_controle_depreciacoes ORDER BY id_bem;
 
SELECT * FROM vw_dre_contabil ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;

SELECT * FROM vw_dre_fluxo_de_caixa ORDER BY pai, filho NULLS FIRST, neto NULLS FIRST;


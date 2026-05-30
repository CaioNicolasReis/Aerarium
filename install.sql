-- ============================================================================
-- install.sql — Recria a database inteira a partir dos fragmentos.
-- ============================================================================
--
-- Uso:
--   createdb financas_pessoais
--   psql -d financas_pessoais -f install.sql
--
-- A ordem dos passos respeita as dependencias entre objetos:
--
--   1. Tabelas        Nada existe sem elas (inclui sequences, NOT NULL, CHECK).
--   2. Constraints    Primary keys e uniques — precisam existir ANTES das FKs,
--                     pois toda foreign key aponta para uma PK ou UNIQUE.
--   3. Referencias     Dados fixos de referencia (categorias, tipos, status...).
--                     Carregados AQUI, antes das FKs: assim a FK auto-referencial
--                     de cat_mov/tipos_bens (id_pai) nao e validada durante a
--                     carga e a ordem dos INSERTs deixa de importar.
--   4. Foreign keys   Agora os alvos (PKs) e os dados ja existem; as FKs validam.
--   5. Indices        Criados sobre tabelas ja populadas.
--   6. Views          Dependem de tudo acima. A numeracao 001..008 ja esta em
--                     ordem topologica (ex.: 006 usa 001; 005 usa 002).
-- ============================================================================

\set ON_ERROR_STOP on

\echo '→ 1/6  Tabelas, sequences e checks...'
\ir schema/01_tables.sql

\echo '→ 2/6  Primary keys e unique constraints...'
\ir schema/02_constraints.sql

\echo '→ 3/6  Dados de referencia...'
\ir dados/referencias/categorias_movimentacao.sql
\ir dados/referencias/moedas.sql
\ir dados/referencias/naturezas_compromissos.sql
\ir dados/referencias/status.sql
\ir dados/referencias/tipos_bens.sql
\ir dados/referencias/tipos_contas.sql
\ir dados/referencias/tipos_entidades.sql

\echo '→ 4/6  Foreign keys...'
\ir schema/03_foreign_keys.sql

\echo '→ 5/6  Indices...'
\ir schema/04_indexes.sql

\echo '→ 6/6  Views...'
-- Os fragmentos 01-04 vem do pg_dump com search_path vazio (tudo qualificado
-- com public.). As views sao curadas a mao e referenciam as tabelas sem
-- qualificar (FROM cat_mov), entao restauramos o search_path aqui.
SET search_path TO public;
\ir schema/05_views/001_vw_categorias_completas.sql
\ir schema/05_views/002_vw_saldo_contas.sql
\ir schema/05_views/003_vw_evolucao_contas.sql
\ir schema/05_views/004_vw_controle_dividas_cartoes.sql
\ir schema/05_views/005_vw_controle_depreciacoes.sql
\ir schema/05_views/006_vw_movimentacoes.sql
\ir schema/05_views/007_vw_dre_contabil.sql
\ir schema/05_views/008_vw_dre_fluxo_de_caixa.sql

\echo '✓ Database criada com sucesso.'

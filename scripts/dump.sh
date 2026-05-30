#!/bin/bash
# ============================================================================
# dump.sh — Gera os dumps granulares e limpos do schema para o repo.
# ============================================================================
#
# Uso (de qualquer diretorio):
#   scripts/dump.sh [alvo...]            Gera os alvos indicados.
#   scripts/dump.sh                      Sem alvo = gera tudo.
#   DB_USER=role scripts/dump.sh tables     Sobrescreve o role do PostgreSQL.
#   scripts/dump.sh -d outro_banco fks   Sobrescreve o banco.
#
# Alvos:
#   tables       schema/01_tables.sql              Tabelas, sequences, NOT NULL, CHECK
#   constraints  schema/02_constraints.sql         Primary keys e unique constraints
#   fks          schema/03_foreign_keys.sql        Foreign keys
#   indexes      schema/04_indexes.sql             Indices
#   referencias  dados/referencias/<tabela>.sql    Dados de referencia (7 arquivos)
#   all          (todos os acima)                  Padrao quando nenhum alvo e dado
#
# Exemplos:
#   dump.sh tables          Mudou um nome de coluna? regenera so o 01.
#   dump.sh fks indexes     Mexeu em FK e indice? regenera 03 e 04.
#   dump.sh referencias     Alterou uma categoria? regenera so os dados de referencia.
#
# O que NAO toca:
#   schema/05_views/   Views sao curadas a mao (comentarios didaticos). O
#                      pg_dump as capturaria sem comentarios, por isso ficam
#                      fora de qualquer alvo (excluidas via --exclude-table).
#
# Notas de design:
#   --no-owner / --no-privileges  Remove identidade (OWNER, GRANT/REVOKE).
#   sed                           Remove os tokens \restrict/\unrestrict do
#                                 pg_dump 17+, que nao tem flag para desabilitar.
#   Sem --disable-triggers        As referencias sao carregadas ANTES das FKs
#                                 (ver install.sql), entao a FK auto-referencial
#                                 de cat_mov/tipos_bens (id_pai) nunca e validada
#                                 durante a carga. Dispensa superuser.
# ============================================================================

set -euo pipefail

# ---- Configuracao -----------------------------------------------------------
DB="financas_pessoais"
DB_USER="${DB_USER:-$(whoami)}"
# O script vive em scripts/, uma camada abaixo da raiz do projeto.
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Flags comuns a todas as chamadas de pg_dump (definidas UMA vez).
PGD=(pg_dump --no-owner --no-privileges -U "$DB_USER")
STRIP='/^\\restrict /d; /^\\unrestrict /d'

# Mapa tabela → nome do arquivo de saida (em dados/referencias/).
declare -A REFERENCIAS=(
  [cat_mov]=categorias_movimentacao
  [moedas]=moedas
  [naturezas_compromissos]=naturezas_compromissos
  [status]=status
  [tipos_bens]=tipos_bens
  [tipos_contas]=tipos_contas
  [tipos_entidades]=tipos_entidades
)

ALL_TARGETS=(tables constraints fks indexes referencias)

# ---- Parsing de argumentos --------------------------------------------------
TARGETS=()
while [ $# -gt 0 ]; do
  case "$1" in
    -d|--database) DB="$2"; shift 2 ;;
    -h|--help)     sed -n '2,35p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    all)           TARGETS=("${ALL_TARGETS[@]}"); shift ;;
    tables|constraints|fks|indexes|referencias) TARGETS+=("$1"); shift ;;
    *) echo "Alvo desconhecido: '$1'. Validos: ${ALL_TARGETS[*]} all" >&2; exit 2 ;;
  esac
done
# Sem alvo explicito = tudo.
[ ${#TARGETS[@]} -eq 0 ] && TARGETS=("${ALL_TARGETS[@]}")

# Verdadeiro se o alvo $1 foi solicitado.
want() {
  local t
  for t in "${TARGETS[@]}"; do [ "$t" = "$1" ] && return 0; done
  return 1
}

# ---- Helpers ----------------------------------------------------------------
# Escreve um cabecalho padrao num fragmento (sobrescreve o arquivo).
write_header() {
  local file="$1" titulo="$2"
  {
    echo "--"
    echo "-- $titulo"
    echo "-- Gerado por dump.sh — nao editar a mao."
    echo "--"
    echo ""
    echo "SET client_encoding = 'UTF8';"
    echo "SET standard_conforming_strings = on;"
    echo "SET client_min_messages = warning;"
    echo "SELECT pg_catalog.set_config('search_path', '', false);"
    echo ""
  } > "$file"
}

# ---- Dumpers ----------------------------------------------------------------
# 01_tables — pre-data, sem as views. Ja vem com cabecalho proprio do pg_dump
# (limpo, sem owner); so removemos os tokens \restrict/\unrestrict.
dump_tables() {
  echo "  → schema/01_tables.sql"
  "${PGD[@]}" --section=pre-data --exclude-table='vw_*' "$DB" \
    | sed "$STRIP" \
    > "$ROOT_DIR/schema/01_tables.sql"
}

# 02/03/04 — fatia o post-data por tipo. O pg_dump emite PK/UNIQUE/FK/INDEX
# juntos no post-data; cada objeto vem precedido por "-- Name: ...; Type: X".
# O awk roteia cada bloco para o arquivo certo. So gera os destinos pedidos:
# os nao solicitados recebem destino vazio e sao ignorados pelo awk.
# (Atencao: "FK CONSTRAINT" contem "CONSTRAINT", entao a FK e testada primeiro.)
dump_postdata() {
  local con="" fk="" idx=""
  if want constraints; then
    con="$ROOT_DIR/schema/02_constraints.sql"
    write_header "$con" "Primary keys e unique constraints"
    echo "  → schema/02_constraints.sql"
  fi
  if want fks; then
    fk="$ROOT_DIR/schema/03_foreign_keys.sql"
    write_header "$fk" "Foreign keys"
    echo "  → schema/03_foreign_keys.sql"
  fi
  if want indexes; then
    idx="$ROOT_DIR/schema/04_indexes.sql"
    write_header "$idx" "Indices"
    echo "  → schema/04_indexes.sql"
  fi

  "${PGD[@]}" --section=post-data "$DB" \
    | sed "$STRIP" \
    | awk -v con="$con" -v fk="$fk" -v idx="$idx" '
        function route(line) {
          if (line ~ /; Type: FK CONSTRAINT;/) return fk
          else if (line ~ /; Type: CONSTRAINT;/) return con
          else if (line ~ /; Type: INDEX;/) return idx
          else return ""
        }
        BEGIN { dest = ""; pending = ""; expect = 0 }
        {
          # Linha "--" sozinha: possivel abertura de bloco; segura no buffer.
          if ($0 == "--") { pending = $0 "\n"; expect = 1; next }
          # Cabecalho de objeto: decide o destino e emite o "--" + esta linha.
          if (expect && $0 ~ /^-- Name: /) {
            dest = route($0)
            if (dest != "") { printf "%s", pending >> dest; print $0 >> dest }
            pending = ""; expect = 0; next
          }
          # O "--" segurado nao abria objeto: descarrega no destino atual.
          if (pending != "") {
            if (dest != "") printf "%s", pending >> dest
            pending = ""; expect = 0
          }
          if (dest != "") print $0 >> dest
        }
      '
}

# Um arquivo por tabela de referencia em dados/referencias/.
dump_referencias() {
  local tabela arquivo
  for tabela in "${!REFERENCIAS[@]}"; do
    arquivo="${REFERENCIAS[$tabela]}"
    echo "  → dados/referencias/${arquivo}.sql"
    "${PGD[@]}" --data-only --inserts --table="$tabela" "$DB" \
      | sed "$STRIP" \
      > "$ROOT_DIR/dados/referencias/${arquivo}.sql"
  done
}

# ---- Execucao ---------------------------------------------------------------
echo "Banco: $DB  (usuario: $DB_USER)"

want tables     && dump_tables
if want constraints || want fks || want indexes; then dump_postdata; fi
want referencias && dump_referencias

echo "Pronto."

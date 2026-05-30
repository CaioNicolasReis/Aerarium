#!/bin/bash
# ============================================================================
# exportar_dados.sh — Exporta os dados transacionais do banco para backup.
# ============================================================================
#
# Uso (de qualquer diretorio):
#   scripts/exportar_dados.sh           Exporta do banco padrao.
#   scripts/exportar_dados.sh -d <db>   Sobrescreve o banco.
#   DB_USER=role scripts/exportar_dados.sh        Sobrescreve o role do PostgreSQL.
#
# O que exporta:
#   Tabelas transacionais (dados do usuario, nao de referencia):
#     entidades, bens, contas, compromissos, cotacoes, movimentacoes
#
# Saida:
#   dados/backups/dados_AAAA-MM-DD_HHMM.sql
#   O arquivo e ignorado pelo git (ver dados/backups/.gitignore).
#
# Como restaurar:
#   1. Montar o banco do zero com install.sql (schema + referencias).
#   2. psql -d <banco> -f dados/backups/dados_<timestamp>.sql
#
# Notas de design:
#   As tabelas transacionais nao tem ciclos de FK entre si — o pg_dump ordena
#   os INSERTs topologicamente sem precisar de --disable-triggers ou superuser.
#   Flags identicas ao dump.sh: --no-owner, --no-privileges, sem identidade.
# ============================================================================

set -euo pipefail

DB="financas_pessoais"
DB_USER="${DB_USER:-$(whoami)}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

PGD=(pg_dump --no-owner --no-privileges -U "$DB_USER")
STRIP='/^\\restrict /d; /^\\unrestrict /d'

TRANSACIONAIS=(entidades bens contas compromissos cotacoes movimentacoes)

while [ $# -gt 0 ]; do
  case "$1" in
    -d|--database) DB="$2"; shift 2 ;;
    -h|--help)     sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Opcao desconhecida: '$1'" >&2; exit 2 ;;
  esac
done

TIMESTAMP="$(date +%Y-%m-%d_%H%M)"
OUTFILE="$ROOT_DIR/dados/backups/dados_${TIMESTAMP}.sql"

TABLE_FLAGS=()
for t in "${TRANSACIONAIS[@]}"; do TABLE_FLAGS+=(--table="$t"); done

echo "Banco: $DB  (usuario: $DB_USER)"
echo "  → dados/backups/dados_${TIMESTAMP}.sql"

"${PGD[@]}" --data-only --inserts "${TABLE_FLAGS[@]}" "$DB" \
  | sed "$STRIP" \
  > "$OUTFILE"

echo "Pronto."

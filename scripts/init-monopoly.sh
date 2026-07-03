#!/usr/bin/env bash
set -euo pipefail

sqlplus -s "${APP_USER}/${APP_USER_PASSWORD}@//localhost:1521/${ORACLE_DATABASE:-XEPDB1}" <<'SQL'
WHENEVER SQLERROR EXIT FAILURE
@/opt/monopoly/monopoly_create.sql
@/opt/monopoly/monopoly_insert.sql
COMMIT;
EXIT;
SQL

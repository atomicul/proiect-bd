FROM gvenzl/oracle-xe:21-slim

ENV ORACLE_RANDOM_PASSWORD=yes

COPY monopoly_create.sql monopoly_insert.sql /opt/monopoly/
COPY --chmod=0755 scripts/init-monopoly.sh /container-entrypoint-initdb.d/01-init-monopoly.sh
COPY scripts/lock-system.sql /container-entrypoint-initdb.d/99-lock-system.sql
COPY --chmod=0755 scripts/print-connection-info.sh /container-entrypoint-startdb.d/99-print-connection-info.sh

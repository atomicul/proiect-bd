#!/usr/bin/env bash
set -euo pipefail

service="${ORACLE_DATABASE:-XEPDB1}"

cat <<BANNER

========================================================================
  proiect-bd connection details
------------------------------------------------------------------------
  Host:          localhost
  Port:          1521
  Service name:  ${service}
  User:          ${APP_USER}
  Password:      (value of APP_USER_PASSWORD from your .env)
  JDBC URL:      jdbc:oracle:thin:@//localhost:1521/${service}
  sqlplus:       sqlplus ${APP_USER}/<password>@//localhost:1521/${service}

  In DataGrip/IntelliJ pick Connection type = "Service", not "SID".
========================================================================

BANNER

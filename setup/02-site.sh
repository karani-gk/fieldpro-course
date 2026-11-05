#!/usr/bin/env bash
# Create the site with ERPNext and fieldpro. bench asks for the MariaDB root password, or set
# DB_ROOT_PASSWORD to skip the question. The Administrator password is `admin`.
set -euo pipefail
source "$(dirname "$0")/common.sh"

start_redis
cd "$BENCH"
bench new-site "$SITE" --admin-password admin --no-mariadb-socket \
	${DB_ROOT_PASSWORD:+--db-root-password "$DB_ROOT_PASSWORD"}
bench --site "$SITE" install-app erpnext
bench --site "$SITE" install-app fieldpro
bench --site "$SITE" set-config developer_mode 1
# A new site refuses run-tests ("Testing is disabled") yet exits 0, so the tests would silently not run.
bench --site "$SITE" set-config allow_tests true
bench use "$SITE"
bench set-config -g serve_default_site true

#!/usr/bin/env bash
# Activate the installation with the access code from your course email, then load the demo data:
# a company, stock, technicians, customers and jobs. Nobody can sign in until this has run.
#   ./setup/03-activate.sh 'UA1.xxxx.yyyy'
set -euo pipefail
source "$(dirname "$0")/common.sh"

if [ $# -ne 1 ]; then
	echo "Usage: $0 '<access code from your course email>'" >&2
	exit 1
fi
start_redis
cd "$BENCH"
bench --site "$SITE" fieldpro-activate "$1"
bench --site "$SITE" fieldpro-demo

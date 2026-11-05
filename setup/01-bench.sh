#!/usr/bin/env bash
# Create the bench in fieldpro-bench/: Frappe v16.23.0 and ERPNext v16.23.1, the versions the
# course uses, on ports 8030 (web), 9030 (socket.io), 11030/13030 (redis) so it runs beside other
# benches. The fieldpro app is linked, not copied: fieldpro-frappe/ is the code the bench runs.
set -euo pipefail
source "$(dirname "$0")/common.sh"

if [ -z "$PYTHON" ]; then
	echo "Python 3.14 was not found. Install it, or run: PYTHON=/path/to/python3.14 $0" >&2
	exit 1
fi
# Cloned without --recurse-submodules: fetch the two apps now.
git -C "$ROOT" submodule update --init

cd "$ROOT"
bench init --python "$PYTHON" --frappe-branch v16.23.0 fieldpro-bench
cd "$BENCH"
bench set-config -g -p webserver_port 8030
bench set-config -g -p socketio_port 9030
bench set-config -g redis_queue "redis://127.0.0.1:11030"
bench set-config -g redis_cache "redis://127.0.0.1:13030"
bench set-config -g redis_socketio "redis://127.0.0.1:13030"
bench set-config -g -p file_watcher_port 6830
bench setup redis
bench setup procfile <<< y
bench get-app --branch v16.23.1 erpnext https://github.com/frappe/erpnext
bench get-app --soft-link "$ROOT/fieldpro-frappe"
bench version

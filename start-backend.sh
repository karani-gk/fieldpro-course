#!/usr/bin/env bash
# Start the backend: Frappe on http://localhost:8030, socket.io on 9030, workers and the scheduler.
# The setup scripts may have left redis running in the background on 11030/13030; bench start
# launches its own, so those are shut down first.
cd "$(dirname "$0")/fieldpro-bench"
redis-cli -p 11030 shutdown nosave >/dev/null 2>&1 || true
redis-cli -p 13030 shutdown nosave >/dev/null 2>&1 || true
exec bench start

# Settings and helpers every setup script reads. Change a setting for one run with an
# environment variable, e.g. SITE=shop.localhost ./setup/02-site.sh

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BENCH="$ROOT/fieldpro-bench"
SITE="${SITE:-fieldpro.localhost}"
PYTHON="${PYTHON:-$(command -v python3.14 || true)}"

# The setup scripts run without `bench start`, but install-app and the demo data need the bench's
# two redis servers. Start them in the background if they are not already up; start-backend.sh
# shuts them down before `bench start` launches its own.
start_redis() {
	cd "$BENCH"
	redis-cli -p 11030 ping >/dev/null 2>&1 || redis-server config/redis_queue.conf --daemonize yes
	redis-cli -p 13030 ping >/dev/null 2>&1 || redis-server config/redis_cache.conf --daemonize yes
}

#!/usr/bin/env bash
# Install the Next.js app's packages and give it its settings (.env.local, kept if it exists).
set -euo pipefail
source "$(dirname "$0")/common.sh"

cd "$ROOT/fieldpro-nextjs"
[ -f .env.local ] || cp .env.example .env.local
npm ci

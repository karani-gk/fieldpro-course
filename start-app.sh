#!/usr/bin/env bash
# Start the Next.js app on http://localhost:3030 (the backend must be running).
cd "$(dirname "$0")/fieldpro-nextjs"
exec npm run dev

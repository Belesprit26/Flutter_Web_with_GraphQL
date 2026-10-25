#!/usr/bin/env bash
# Regenerates the GraphQL types and fails if they differ from what's committed.
# Generated code is committed so a fresh clone runs without build_runner; this
# check is what stops it going stale.
set -euo pipefail

cd "$(dirname "$0")/.."

(cd packages/graphql_api && dart run build_runner build)

if [ -n "$(git status --porcelain -- packages/graphql_api/lib)" ]; then
  echo "Generated GraphQL code is out of date. Run build_runner in"
  echo "packages/graphql_api and commit the result:"
  git status --porcelain -- packages/graphql_api/lib
  exit 1
fi

echo "Generated GraphQL code is up to date."

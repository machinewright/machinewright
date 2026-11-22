#!/usr/bin/env bash
# Publish the GitHub profile README (repo machinewright/machinewright): create the repo if missing, push main, make it public.
set -euo pipefail
cd "$(dirname "$0")/.."
OWNER=${OWNER:-machinewright}; REPO="$OWNER"
[ -z "$(git status --porcelain)" ] || { echo "uncommitted changes; commit first" >&2; exit 1; }
gh repo view "$OWNER/$REPO" >/dev/null 2>&1 || gh repo create "$OWNER/$REPO" --private --description "Profile README" --disable-wiki
git push "https://github.com/$OWNER/$REPO.git" HEAD:main
gh api -X PATCH "repos/$OWNER/$REPO" -f visibility=public --jq .visibility

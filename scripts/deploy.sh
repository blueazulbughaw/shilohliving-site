#!/usr/bin/env bash
# Deploy the committed site to Namecheap (shilohliving.app) and push to GitHub.
#
#   scripts/deploy.sh            push + deploy HEAD
set -euo pipefail

SSH_HOST="shilzikx@server353.web-hosting.com"
SSH_OPTS=(-i "$HOME/.ssh/namecheap_ed25519" -p 21098 -o BatchMode=yes)
WEB_ROOT="public_html"
SITE_URL="https://shilohliving.app/"

cd "$(dirname "$0")/.."

if [ -n "$(git status --porcelain)" ]; then
  echo "Uncommitted changes - commit first so live matches GitHub." >&2
  git status --short >&2
  exit 1
fi

echo "==> Pushing to GitHub"
git push origin HEAD

echo "==> Uploading $(git rev-parse --short HEAD) to $WEB_ROOT"
git archive --format=tar HEAD -- . ':!scripts' ':!.gitignore' ':!.gitattributes' ':!CLAUDE.md' \
  | ssh "${SSH_OPTS[@]}" "$SSH_HOST" "tar xf - -C ~/$WEB_ROOT"

echo "==> Health check"
curl -fsS -m 30 -o /dev/null -w "%{http_code} $SITE_URL\n" "$SITE_URL"

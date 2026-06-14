#!/usr/bin/env bash
# get-depends.sh — reconstitute the FULL Foundry build-dependency cache.
#
# Clones this repo (all source tarballs < 100MB) and then downloads the large
# files (boost / rust > 100MB) that are published as assets on the 'depends-cache'
# GitHub Release, leaving every package together in one directory.
#
# Usage:  ./get-depends.sh [DEST_DIR]      (default: ./foundry-build-tools)
# Public repo + release — no authentication required.
set -euo pipefail

OWNER=MarkS0485
REPO=Foundry-Build-Tools
TAG=depends-cache
DEST="${1:-foundry-build-tools}"

echo "==> cloning $OWNER/$REPO -> $DEST"
git clone --depth 1 "https://github.com/$OWNER/$REPO.git" "$DEST"
cd "$DEST"

echo "==> fetching release assets (>100MB packages) from tag '$TAG'"
api="https://api.github.com/repos/$OWNER/$REPO/releases/tags/$TAG"
urls=$(curl -fsSL "$api" | grep -oE '"browser_download_url"[[:space:]]*:[[:space:]]*"[^"]+"' \
        | sed -E 's/.*"(https[^"]+)"/\1/')
if [ -z "$urls" ]; then
  echo "   (no release assets found at tag '$TAG')"
else
  n=0
  while IFS= read -r url; do
    [ -z "$url" ] && continue
    f=$(basename "$url")
    if [ -s "$f" ]; then echo "   skip $f (present)"; else echo "   get  $f"; curl -fL --retry 3 -o "$f" "$url"; fi
    n=$((n+1))
  done <<< "$urls"
  echo "   $n release asset(s) processed"
fi

echo "==> done. Full depends cache in: $DEST  ($(ls -1 | grep -vc '^README\|^get-depends') files)"

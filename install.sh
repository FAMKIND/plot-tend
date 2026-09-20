#!/bin/sh
set -eu

REPO="$(cd "$(dirname "$0")" && pwd)"

for target in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
  mkdir -p "$target"
  for skill in plot tend; do
    link="$target/$skill"
    if [ -L "$link" ]; then
      rm "$link"
    elif [ -e "$link" ]; then
      backup="$link.backup-$(date +%Y%m%d%H%M%S)"
      mv "$link" "$backup"
      echo "moved existing $link to $backup"
    fi
    ln -s "$REPO/$skill" "$link"
    echo "linked $link -> $REPO/$skill"
  done
done

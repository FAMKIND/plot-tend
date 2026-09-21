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
      backup_dir="${target}-backup"
      mkdir -p "$backup_dir"
      backup="$backup_dir/$skill-$(date +%Y%m%d%H%M%S)"
      mv "$link" "$backup"
      echo "moved existing $link to $backup"
    fi
    ln -s "$REPO/$skill" "$link"
    echo "linked $link -> $REPO/$skill"
  done
done

if [ -d "$REPO/.git" ]; then
  HOOK="$REPO/.git/hooks/pre-commit"
  if [ -L "$HOOK" ]; then
    rm "$HOOK"
  elif [ -e "$HOOK" ]; then
    backup="$REPO/.git/hooks/pre-commit-backup-$(date +%Y%m%d%H%M%S)"
    mv "$HOOK" "$backup"
    echo "moved existing $HOOK to $backup"
  fi
  ln -s "$REPO/check-contract.sh" "$HOOK"
  echo "linked $HOOK -> $REPO/check-contract.sh"
fi

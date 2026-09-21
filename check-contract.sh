#!/bin/sh
set -eu

for f in plot/SKILL.md tend/SKILL.md; do
  n=$(git show ":$f" | grep -c '^|---' || true)
  if [ "$n" -ne 1 ]; then
    echo "check-contract: expected exactly one markdown table in $f, found $n — update this script" >&2
    exit 1
  fi
done

if [ "$(git show :plot/SKILL.md | grep '^|')" != "$(git show :tend/SKILL.md | grep '^|')" ]; then
  echo "check-contract: handoff contract table differs between plot/SKILL.md and tend/SKILL.md" >&2
  exit 1
fi

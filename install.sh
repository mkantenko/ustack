#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
agents="$HOME/.agents/skills"
claude="$HOME/.claude/skills"
mkdir -p "$agents" "$claude"

for dir in "$repo"/skills/*/; do
  name="$(basename "$dir")"
  for target in "$agents/$name" "$claude/$name"; do
    if [[ -e "$target" && ! -L "$target" ]]; then
      echo "skip $target: a real directory is in the way" >&2
      continue 2
    fi
  done
  ln -sfn "$repo/skills/$name" "$agents/$name"
  ln -sfn "$agents/$name" "$claude/$name"
  echo "linked $name"
done

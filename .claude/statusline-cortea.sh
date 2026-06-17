#!/bin/bash
# Cortea statusline: shows the current dir, git branch, and — when inside a cortea
# checkout — that worktree's isolated frontend localhost link (derived from
# compose.override.yaml).

input=$(cat)

cwd=$(printf '%s' "$input" | python3 -c 'import json,sys
try:
    d=json.load(sys.stdin)
    print(d.get("workspace",{}).get("current_dir") or d.get("cwd") or "")
except Exception:
    print("")' 2>/dev/null)
[ -z "$cwd" ] && cwd="$PWD"

# Walk up to the cortea checkout root (dir containing compose.yaml).
root="$cwd"
while [ "$root" != "/" ] && [ ! -f "$root/compose.yaml" ]; do
  root=$(dirname "$root")
done

cortea_seg=""
if [ -f "$root/compose.yaml" ] && [ -f "$root/.env.template" ]; then
  port=3000
  ovr="$root/compose.override.yaml"
  if [ -f "$ovr" ]; then
    p=$(grep -A1 -E '^[[:space:]]*webapp:' "$ovr" | grep -oE '[0-9]+:3000' | head -1 | cut -d: -f1)
    [ -n "$p" ] && port="$p"
  fi
  proj=$(grep -E '^COMPOSE_PROJECT_NAME=' "$root/.env" 2>/dev/null | cut -d= -f2)
  [ -z "$proj" ] && proj=$(basename "$root")
  # Cyan project + frontend link
  cortea_seg=$(printf '\033[38;5;44m%s\033[0m \033[38;5;39mhttp://localhost:%s\033[0m' "$proj" "$port")
fi

branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

out=$(printf '\033[1m%s\033[0m' "$(basename "$cwd")")
[ -n "$branch" ] && out="$out $(printf '\033[38;5;245m⎇ %s\033[0m' "$branch")"
[ -n "$cortea_seg" ] && out="$out │ $cortea_seg"
printf '%s' "$out"

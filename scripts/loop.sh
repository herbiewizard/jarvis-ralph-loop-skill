#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-build}"
MAX="${2:-0}"

if [[ "$MODE" != "plan" && "$MODE" != "build" ]]; then
  echo "Usage: $0 [plan|build] [max_iterations]"
  exit 1
fi

PROMPT_FILE="templates/PROMPT_${MODE}.md"
[[ -f "$PROMPT_FILE" ]] || { echo "Missing $PROMPT_FILE"; exit 1; }

ITER=0
while true; do
  if [[ "$MAX" != "0" && "$ITER" -ge "$MAX" ]]; then
    echo "Reached max iterations: $MAX"
    exit 0
  fi

  echo "--- Ralph loop ($MODE) iteration $ITER ---"
  echo "Run your coding CLI here with the prompt below:"
  echo "---------------------------------------------"
  cat "$PROMPT_FILE"
  echo "---------------------------------------------"
  echo "(Placeholder runner) Integrate codex/claude/opencode command in your environment."

  ITER=$((ITER+1))
  sleep 1
  [[ "$MAX" == "0" ]] && break
 done

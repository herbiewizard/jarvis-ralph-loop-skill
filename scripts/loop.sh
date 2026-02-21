#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-build}"
MAX="${2:-0}" # 0 = unlimited
PROMPT_FILE="templates/PROMPT_${MODE}.md"

if [[ "$MODE" != "plan" && "$MODE" != "build" ]]; then
  echo "Usage: $0 [plan|build] [max_iterations]"
  exit 1
fi

[[ -f "$PROMPT_FILE" ]] || { echo "Missing $PROMPT_FILE"; exit 1; }
[[ "$MAX" =~ ^[0-9]+$ ]] || { echo "max_iterations must be a non-negative integer"; exit 1; }

# Optional: set your coding CLI command here.
# Example:
#   export RALPH_RUNNER='codex exec --full-auto "$(cat ${PROMPT_FILE})"'
#   export RALPH_RUNNER='claude --dangerously-skip-permissions -p "$(cat ${PROMPT_FILE})"'
RUNNER="${RALPH_RUNNER:-}"

ITER=1
while true; do
  if [[ "$MAX" != "0" && "$ITER" -gt "$MAX" ]]; then
    echo "Reached max iterations: $MAX"
    exit 0
  fi

  echo "--- Ralph loop ($MODE) iteration $ITER ---"

  if [[ -n "$RUNNER" ]]; then
    eval "$RUNNER"
  else
    echo "No RALPH_RUNNER configured. Showing prompt only:"
    echo "---------------------------------------------"
    cat "$PROMPT_FILE"
    echo "---------------------------------------------"
    echo "Set RALPH_RUNNER to execute a CLI automatically."
    break
  fi

  ITER=$((ITER+1))
done

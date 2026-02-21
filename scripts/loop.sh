#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-build}"
MAX="${2:-0}" # 0 = unlimited
PROMPT_FILE="templates/PROMPT_${MODE}.md"
SESSION="${RALPH_TMUX_SESSION:-ralph-loop}"
USE_TMUX="${RALPH_USE_TMUX:-0}"
PROGRESS_FILE="${RALPH_PROGRESS_FILE:-RALPH_PROGRESS.md}"

if [[ "$MODE" != "plan" && "$MODE" != "build" ]]; then
  echo "Usage: $0 [plan|build] [max_iterations]"
  exit 1
fi

[[ -f "$PROMPT_FILE" ]] || { echo "Missing $PROMPT_FILE"; exit 1; }
[[ "$MAX" =~ ^[0-9]+$ ]] || { echo "max_iterations must be a non-negative integer"; exit 1; }

# Optional: set your coding CLI command here.
# Examples:
#   export RALPH_RUNNER='codex exec "$(cat templates/PROMPT_build.md)"'
#   export RALPH_RUNNER='claude -p "$(cat templates/PROMPT_build.md)"'
RUNNER="${RALPH_RUNNER:-}"

log_progress() {
  printf -- "- [%s] %s\n" "$(date -u +'%Y-%m-%d %H:%M:%S UTC')" "$1" >> "$PROGRESS_FILE"
}

run_iteration_loop() {
  local ITER=1
  while true; do
    if [[ "$MAX" != "0" && "$ITER" -gt "$MAX" ]]; then
      echo "Reached max iterations: $MAX"
      log_progress "Reached max iterations: $MAX"
      exit 0
    fi

    echo "--- Ralph loop ($MODE) iteration $ITER ---"
    log_progress "Starting $MODE iteration $ITER"

    if [[ -n "$RUNNER" ]]; then
      eval "$RUNNER"
      log_progress "Completed runner for $MODE iteration $ITER"
    else
      echo "No RALPH_RUNNER configured. Showing prompt only:"
      echo "---------------------------------------------"
      cat "$PROMPT_FILE"
      echo "---------------------------------------------"
      echo "Set RALPH_RUNNER to execute a CLI automatically."
      log_progress "Stopped: missing RALPH_RUNNER"
      break
    fi

    ITER=$((ITER+1))
  done
}

if [[ "$USE_TMUX" == "1" ]]; then
  command -v tmux >/dev/null 2>&1 || { echo "RALPH_USE_TMUX=1 but tmux is not installed"; exit 1; }
  log_progress "Launching detached tmux session: $SESSION ($MODE max=$MAX)"
  tmux new-session -d -s "$SESSION" "cd '$(pwd)' && RALPH_USE_TMUX=0 '$0' '$MODE' '$MAX'"
  echo "Started tmux session: $SESSION"
  echo "Attach: tmux attach -t $SESSION"
  echo "Tail progress: tail -f $PROGRESS_FILE"
  exit 0
fi

run_iteration_loop

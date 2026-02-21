---
name: jarvis-ralph-loop
description: Run Ralph-style autonomous software loops with clear phases: (1) requirements/specs, (2) planning-only gap analysis, and (3) build iterations with one-task scope, backpressure (tests/lint/typecheck/build), and commit checkpoints. Use for implementation-plan-driven coding workflows and PLANNING vs BUILDING orchestration across coding CLIs (Claude Code/Codex), especially long-running jobs that should execute in a separate terminal process with checkpoint/resume safety.
metadata:
  {
    "openclaw":
      {
        "emoji": "🔁",
        "requires": { "bins": ["git"] }
      }
  }
---

# Jarvis Ralph Loop Skill

Use this skill to run disciplined autonomous loops without losing control.

## Workflow

1. Create requirements in `specs/*.md`.
2. Run **PLANNING** to generate/update `IMPLEMENTATION_PLAN.md` only.
3. Run **BUILDING** to implement one task per iteration.

## Required artifacts

- `specs/*.md`
- `IMPLEMENTATION_PLAN.md`
- `templates/PROMPT_plan.md`
- `templates/PROMPT_build.md`
- `templates/AGENTS.md`

## Long-running execution (preferred)

For long jobs, do **not** rely on a single sub-agent run.
Run Claude Code or Codex in a separate process (tmux or detached TTY) and persist progress in repo files.

### Runner setup

- Claude Code example:
  - `export RALPH_RUNNER='claude -p "$(cat templates/PROMPT_build.md)"'`
- Codex example:
  - `export RALPH_RUNNER='codex exec "$(cat templates/PROMPT_build.md)"'`

### Process pattern

- Use tmux when available (`tmux new -d ...`) for survivable background execution.
- Alternative: OpenClaw `exec(..., pty:true, background:true)` and monitor via `process`.
- Keep an append-only progress file (for example `RALPH_PROGRESS.md`) with timestamps each iteration.
- Keep checkpoint markers in `IMPLEMENTATION_PLAN.md` (task status + next task).

### Recovery pattern (mandatory)

If run stops unexpectedly:
1. Read latest progress/checkpoint files.
2. Resume from first unfinished highest-priority task.
3. Log interruption + resume event.
4. Continue loop.

## Hard rules

- Planning mode: no code changes, no commits.
- Building mode: one highest-priority task per iteration.
- Run backpressure commands from `AGENTS.md` before commit.
- Update `IMPLEMENTATION_PLAN.md` and progress log every iteration.
- Commit frequently at meaningful checkpoints and push regularly.

## Safety

- Prefer sandboxed execution.
- Use least-privilege credentials.
- Require explicit approval for destructive operations (force-push, deletes, mass rewrites).
- Stop on completion sentinel, max iterations, or manual stop.

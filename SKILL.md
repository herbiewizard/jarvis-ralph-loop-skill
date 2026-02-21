---
name: jarvis-ralph-loop
description: Run Ralph-style autonomous software loops with clear phases: (1) requirements/specs, (2) planning-only gap analysis, and (3) build iterations with one-task scope, backpressure (tests/lint/typecheck/build), and commit checkpoints. Use for implementation-plan-driven coding workflows and PLANNING vs BUILDING orchestration across coding CLIs.
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

## OpenClaw execution pattern

For interactive coding CLIs, use a TTY-backed run:
- `exec(..., pty:true, background:true)`
- monitor with `process poll` / `process log`

Persist loop state in files (`specs`, plan, commits), not chat context.

## Hard rules

- Planning mode: no code changes, no commits.
- Building mode: one highest-priority task per iteration.
- Run backpressure commands from `AGENTS.md` before commit.
- Update `IMPLEMENTATION_PLAN.md` after each iteration.

## Safety

- Prefer sandboxed execution.
- Use least-privilege credentials.
- Require explicit approval for destructive operations (force-push, deletes, mass rewrites).
- Stop on completion sentinel, max iterations, or manual stop.

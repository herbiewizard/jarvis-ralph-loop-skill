---
name: jarvis-ralph-loop
description: Execute Ralph-style iterative software delivery with clear phases: (1) requirements/specs, (2) planning-only gap analysis, and (3) build loops with one task per iteration, backpressure (tests/lint/typecheck), and commit checkpoints. Use when users ask for autonomous coding loops, implementation-plan driven execution, or PLANNING vs BUILDING mode orchestration across coding CLIs.
---

# Jarvis Ralph Loop Skill

Use this skill to run disciplined autonomous loops without losing control.

## Core workflow

1. Requirements: write `specs/*.md` from JTBD/topics.
2. Planning mode: generate/update `IMPLEMENTATION_PLAN.md` only.
3. Building mode: implement one task per iteration, validate, commit.

## Required files

- `specs/*.md`
- `templates/PROMPT_plan.md`
- `templates/PROMPT_build.md`
- `templates/AGENTS.md`
- `IMPLEMENTATION_PLAN.md` (generated in planning)

## Execution pattern (OpenClaw-friendly)

For interactive coding CLIs, run with TTY:
- `exec(..., pty:true, background:true)`
- monitor with `process poll/log`

Use one iteration per fresh context window. Persist state in files, not chat memory.

## Rules

- Planning mode never implements code.
- Building mode picks exactly one highest-priority task.
- Always run backpressure commands from `AGENTS.md` before commit.
- Update `IMPLEMENTATION_PLAN.md` after each iteration.

## Safety

- Prefer sandboxed execution.
- Least-privilege credentials only.
- No destructive actions (force-push/delete/mass rewrites) without explicit user approval.
- Stop conditions: completion sentinel in plan, max iterations, or manual stop.

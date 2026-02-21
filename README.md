# Jarvis Ralph Loop Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

A production-ready OpenClaw skill template for **Ralph-style autonomous coding loops** with strong safety defaults.

## Why this exists

Most Ralph-oriented skills specialize in one dimension (methodology, orchestration, or provider-specific execution).
This repository combines the practical best parts into one clean, reusable baseline.

## What it enables

- **Phase 1 (Requirements):** JTBD decomposition into `specs/*.md`
- **Phase 2 (PLANNING):** gap analysis → `IMPLEMENTATION_PLAN.md` (planning only)
- **Phase 3 (BUILDING):** one-task iterative implementation with validation + commits
- **OpenClaw orchestration:** `exec/process` + `pty:true` for interactive coding CLIs

## Repository structure

```text
.
├── SKILL.md
├── scripts/
│   └── loop.sh
├── templates/
│   ├── AGENTS.md
│   ├── PROMPT_build.md
│   └── PROMPT_plan.md
├── references/
│   └── README-playbook.md
└── LICENSE
```

## Quick start

1. Create specs in `specs/`.
2. Copy templates into your target project.
3. Run planning loop first.
4. Run building loop with bounded iterations.

### Planning (recommended first)

```bash
./scripts/loop.sh plan 3
```

### Building

```bash
./scripts/loop.sh build 10
```

### Optional runner automation

`loop.sh` supports a runner command via `RALPH_RUNNER`:

```bash
export RALPH_RUNNER='codex exec --full-auto "$(cat templates/PROMPT_build.md)"'
./scripts/loop.sh build 5
```

## Safety model

- sandbox-first execution
- least-privilege credentials
- deterministic backpressure (tests/lint/typecheck/build)
- approval gates for destructive actions
- explicit stop/resume checkpoints via plan file + commits

## Architecture (text diagram)

```text
specs/*.md -> PROMPT_plan -> IMPLEMENTATION_PLAN.md
IMPLEMENTATION_PLAN.md + PROMPT_build + AGENTS.md
  -> iterate one task -> validate -> commit -> update plan -> repeat
```

## Publishing to ClawHub

```bash
clawhub publish . \
  --slug jarvis-ralph-loop \
  --name "Jarvis Ralph Loop" \
  --version 1.0.0 \
  --changelog "Initial public release"
```

## License

MIT

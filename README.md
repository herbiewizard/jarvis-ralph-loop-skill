# Jarvis Ralph Loop Skill

A practical OpenClaw-ready skill for running **Ralph-style autonomous coding loops** with structure and safety.

## Why this exists

Existing Ralph skills are useful but fragmented:
- one is methodology-heavy,
- one is orchestration-heavy,
- one is model/tool-specific.

This repo combines the best parts into one clean, presentable template.

## What it enables

- **Phase 1:** requirements decomposition into `specs/*.md`
- **Phase 2 (PLANNING):** gap analysis → `IMPLEMENTATION_PLAN.md`
- **Phase 3 (BUILDING):** one-task iterative implementation with validation + commits
- **OpenClaw orchestration:** `exec/process` with `pty:true` for interactive coding CLIs

## Repo structure

```
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

## Quickstart

1. Create specs in `specs/`.
2. Copy templates into your target project.
3. Run planning loop first.
4. Run building loop with bounded iterations.

### Planning

```bash
./scripts/loop.sh plan 3
```

### Building

```bash
./scripts/loop.sh build 10
```

## Safety model

- sandbox-first
- least privilege tokens
- deterministic backpressure (tests/lint/typecheck)
- approval gates for destructive actions
- clear stop/resume checkpoints via plan file

## Architecture (text diagram)

```
specs/*.md -> PROMPT_plan -> IMPLEMENTATION_PLAN.md
IMPLEMENTATION_PLAN.md + PROMPT_build + AGENTS.md
    -> iteration loop -> validate -> commit -> update plan -> repeat
```

## License

MIT

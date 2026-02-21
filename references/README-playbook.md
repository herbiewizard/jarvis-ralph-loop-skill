# Ralph Playbook (Condensed)

Core idea: persistent state on disk + fresh context each iteration.

Phases:
1. Requirements/specification
2. Planning-only gap analysis
3. Building one task per iteration

Why it works:
- avoids context bloat
- keeps deterministic progress checkpoints
- combines autonomy with backpressure and safety gates

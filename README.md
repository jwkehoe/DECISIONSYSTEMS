# Decision Architecting System

## Purpose

Local-first engineering workbench for improving the quality of engineering decisions through evidence, structured reasoning, reusable artifacts, and deterministic workflows.

## Core Principle

Optimize for better decisions, not more features.

## Phase Map

1. Phase 1 — Decision Systems Workbench
2. Phase 2 — LLM Mega Matrix
3. Phase 3 — Software Archaeology
4. Phase 4 — Decision Systems Architecture
5. Phase 5 — Decision Cell Orchestration

## Repository Conventions

- Preserve existing work unless explicitly directed otherwise.
- Prefer small, reversible changes.
- Extend existing components before creating new ones.
- Separate observations, inferences, recommendations, and decisions.
- Record structural, architectural, or behavioral changes in `FLIGHT_RECORDER.md`.
- Record user-visible changes in `CHANGELOG.md`.

## Session Restart

Start by reading:

1. `SESSION_STATE.md`
2. `records/session_boot/SESSION_BOOT.md`
3. `TODO.md`
4. Recent relevant entries in `FLIGHT_RECORDER.md`

Do not read the entire repository unless the task requires it.

Canonical session-open command:

```bash
./tools/session/open_session.sh
```

## Active Control Files

- Active TODOs: `TODO.md`
- Session continuity: `SESSION_STATE.md`
- Engineering trace: `FLIGHT_RECORDER.md`
- User-facing history: `CHANGELOG.md`
- Session open workflow: `tools/session/SESSION_OPEN_WORKFLOW.md`
- Session close workflow: `tools/session/SESSION_CLOSE_WORKFLOW.md`

## Documentation vs. Records

This repository intentionally separates documentation from operational records.

### `docs/`

The `docs/` hierarchy contains explanatory material intended to help humans and AI understand the system's architecture, design, processes, and rationale.

Example:

- `docs/decisions/` — Documentation describing the decision-making framework, methodology, standards, and process.

### `records/`

The `records/` hierarchy contains the project's operational artifacts generated during execution. These files represent the historical record of the project and should not be treated as explanatory documentation.

Example:

- `records/decisions/` — Actual decision records produced during the project, including the evidence considered, alternatives evaluated, trade-offs, rationale, and final decisions.

**Rule of thumb**

- **`docs/` explains how we work.**
- **`records/` preserves what actually happened.**

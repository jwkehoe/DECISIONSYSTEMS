# Phase 1 Workbench Architecture

## Purpose

Phase 1 establishes a local-first decision workbench that can:

- inventory local LLM assets
- scan repositories
- reconstruct durable engineering artifacts
- record evidence, assumptions, and decisions

The immediate goal is not broad platform scope. The immediate goal is a deterministic CLI foundation that improves engineering decision quality under uncertainty.

## System Boundary

Phase 1 includes:

- repository continuity and restart tooling
- model inventory and benchmark planning surfaces
- repository scan and software archaeology workflow definition
- markdown-first artifact generation
- local storage for scans, evidence, and benchmark results

Phase 1 excludes:

- GUI work
- cloud orchestration
- production multi-agent execution
- vector search
- distributed job execution

## Architectural Style

The intended style is `AI-assisted spec-driven development with docs-as-code, ADR-style decision control, and platform-engineering discipline`.

Operationally that means:

- control files define the current state
- session scripts summarize and refresh repo continuity
- decisions are durable artifacts, not chat residue
- generated outputs should be reproducible from local commands

## Primary Components

## Control Plane

Repository continuity surfaces:

- `SESSION_STATE.md`
- `TODO.md`
- `PROJECT_STATUS.md`
- `FLIGHT_RECORDER.md`
- `CHANGELOG.md`

These files govern restartability, queue state, and visible evidence of change.

## Governance Plane

Governance documents under `governance/` define:

- phase scope
- project principles
- engineering priorities
- architectural constraints

These are the constitutional documents for the repo. They are upstream of implementation choices.

## Documentation Plane

The `docs/` tree explains the intended system:

- architecture
- operations
- requirements
- decisions

This is explanatory material. It should stay concise and durable.

## Records Plane

The `records/` tree preserves what actually happened:

- observations
- inferences
- recommendations
- decisions

This is the operational evidence layer. It should support later reconstruction without relying on chat history.

## Implementation Plane

The future implementation lives under `src/` and should start as a CLI-first Python package. The Phase 1 governing document already narrows the first useful slices to:

- model scanning
- repository scanning
- archaeology artifact export
- local routing support
- local persistence

## Target Runtime Flow

The intended Phase 1 workflow is:

1. Open the repo through `./tools/session/open_session.sh`.
2. Select the active task from `TODO.md`.
3. Run a local scan or continuity command.
4. Produce or update durable artifacts.
5. Record evidence and decisions in repo files.
6. Close out state deterministically.

## Data and Artifact Model

Phase 1 treats Markdown as the primary human-readable output.

Expected durable artifacts include:

- project DNA reports
- reconstructed requirements
- benchmark results
- decision records
- evidence-backed run notes

Local structured storage may evolve behind the CLI, but the repo should remain understandable without a database viewer.

## Module Boundaries

The minimal logical modules for implementation are:

- `models`: scan and catalog local model inventory
- `benchmarks`: execute benchmark suites against candidate models
- `repo_scan`: inspect repository structure and code artifacts
- `archaeology`: reconstruct higher-order documentation from scan outputs
- `routing`: choose best-fit models or teams for a task
- `storage`: persist local state and results
- `templates`: render markdown outputs

These module names come from the governing Phase 1 layout and should be treated as the default starting shape unless implementation pressure proves otherwise.

## Architectural Constraints

- Local-first before cloud-first
- CLI before GUI
- Deterministic artifacts before speculative automation
- Evidence capture before recommendation polish
- Small reversible slices before ambitious platform surface area

## Near-Term Consequence

The next implementation work should produce the smallest useful CLI and artifact flow that exercises this architecture end to end. That is more valuable than adding more scaffolding.

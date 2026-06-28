# Decision Architecting System Bootstrap Prompt v2

Use this prompt with a coding agent when initializing or normalizing a Decision Architecting System repository.

## Objective

Create a simple, local-first project filesystem structure for the Decision Architecting System. The structure must support Git, a flight recorder, universal README, universal TODO, universal session state, documentation, changelog, lessons learned, governing phase documents, and token-efficient agent operation.

## Non-Negotiable Rules

- Keep the structure simple.
- Do not create deep directory hierarchies unless the project proves it needs them.
- Do not overwrite existing files.
- Use idempotent operations.
- Initialize Git only if `.git/` is missing.
- Treat scripts that write Markdown as execution-boundary code.
- Use single-quoted heredocs for Markdown generation.
- Track meaningful changes in `FLIGHT_RECORDER.md`.
- Track user-visible changes in `CHANGELOG.md`.
- Track reusable engineering lessons in root-level `LESSONS_LEARNED.md`.

## Required Layout

```text
/
├── governance/
├── records/
├── artifacts/
├── docs/
├── tools/
├── src/
├── tests/
├── README.md
├── TODO.md
├── CHANGELOG.md
├── SESSION_STATE.md
├── FLIGHT_RECORDER.md
└── LESSONS_LEARNED.md
```

## Required Governance Files

- `governance/PROJECT_INSTRUCTIONS.md`
- `governance/README.md`

## Required Session Files

- `records/session_boot/SESSION_BOOT.md`
- `tools/session/SESSION_OPEN_WORKFLOW.md`
- `tools/session/SESSION_CLOSE_WORKFLOW.md`

## Required Phase Files

- `governance/Decision_Systems_Workbench-Phase_1.md`
- `governance/Decision_Systems_Workbench-Phase_2_LLM_Mega_Matrix.md`
- `governance/Decision_Systems_Workbench-Phase_3_Software_Archaeology.md`
- `governance/Decision_Systems_Workbench-Phase_4_Decision_Systems_Architecture.md`
- `governance/Decision_Systems_Workbench-Phase_5_Decision_Cell_Orchestration.md`

## Token Efficiency Strategy

At the start of each agent session, read only:

1. `records/session_boot/SESSION_BOOT.md`
2. `SESSION_STATE.md`
3. `TODO.md`
4. Recent relevant `FLIGHT_RECORDER.md` entries
5. Directly relevant phase/governance files

Canonical command:

```bash
./tools/session/open_session.sh
```

Do not ingest the whole repository by default.

Restart or compact when context drifts, repeats, crosses phases, or after a bug fix needs clean verification.

## Closeout Requirements

Before ending a session, update:

- `SESSION_STATE.md`
- `TODO.md`
- `FLIGHT_RECORDER.md`
- `CHANGELOG.md` when user-visible behavior changed
- `LESSONS_LEARNED.md` when a reusable engineering lesson was found

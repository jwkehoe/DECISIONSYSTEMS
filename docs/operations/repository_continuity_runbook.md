# Repository Continuity Runbook

## Purpose

This runbook defines the minimum operating procedure for keeping the repository resumable across interrupted sessions.

The standard is simple: another operator should be able to resume work from repo artifacts without reconstructing the prior session from chat.

## Core Commands

Session open:

```bash
./tools/session/open_session.sh
```

Repository validation:

```bash
./tools/validate_repository.sh
```

Repository health check:

```bash
./tools/repository_health_check.sh
```

Session close workflow reference:

```bash
./tools/session/close_session.sh --help
```

## Session Start Procedure

1. Run `./tools/session/open_session.sh`.
2. Read the active items in `TODO.md`.
3. Confirm the current objective in `SESSION_STATE.md`.
4. Read only the most recent relevant entries in `FLIGHT_RECORDER.md`.
5. Validate the repo before broad edits if the control surfaces look stale.

## Session During-Work Rules

- Keep scope tied to the active TODO item.
- Prefer updating durable repo artifacts over explaining status in chat only.
- Record structural, architectural, or behavioral changes in `FLIGHT_RECORDER.md`.
- Avoid broad repo scans when targeted file inspection is enough.

## Session Close Procedure

Before ending meaningful work, update:

- `SESSION_STATE.md`
- `TODO.md`
- `PROJECT_STATUS.md`
- `FLIGHT_RECORDER.md`
- `CHANGELOG.md` for user-visible changes
- `LESSONS_LEARNED.md` when a reusable lesson was discovered

## Healthy State Definition

The repository is in a healthy continuity state when:

- `./tools/validate_repository.sh` passes
- `./tools/repository_health_check.sh` reports `Known drift references: none`
- active TODO items match the current objective
- `SESSION_STATE.md`, `PROJECT_STATUS.md`, and `FLIGHT_RECORDER.md` tell the same story

## Known Acceptable Warnings

Current placeholder-only directories are expected until implementation begins:

- `docs/architecture`
- `docs/operations`
- `docs/requirements`
- `docs/decisions`
- `records/*`
- `src`
- `tests`

Those warnings should disappear as real artifacts are added. They are queue signals, not breakage.

## Failure Handling

If validation fails:

1. Identify missing required files or directories.
2. Repair control-plane drift before broader work.
3. Re-run validation.

If the health check reports drift references:

1. Inspect whether the hit is real or tool self-noise.
2. Fix the underlying stale reference.
3. Re-run the health check until drift is clean.

If control files disagree:

1. Treat `FLIGHT_RECORDER.md` as the most reliable recent reconciliation surface.
2. Promote the corrected state back into `SESSION_STATE.md`, `TODO.md`, and `PROJECT_STATUS.md`.

## Operational Constraint

This repo should prefer boring recoverability over clever workflow. If a new mechanism makes restart harder to understand, it is a regression.

# Session Close Workflow

Use this workflow to update the repository state deterministically at the end of meaningful work.

## Canonical Entry Point

Run `./tools/session/close_session.sh` with explicit flags.

Example:

```bash
./tools/session/close_session.sh \
  --objective "Stabilize session workflows and repo validation" \
  --next-action "Run validation and review the health check output" \
  --restart-point "Read SESSION_STATE.md, TODO.md, and the latest FLIGHT_RECORDER.md entry" \
  --active-file "tools/session/open_session.sh" \
  --active-file "tools/session/close_session.sh" \
  --decision "Use small Bash utilities for repository continuity workflows." \
  --constraint "Preserve existing files and avoid destructive cleanup." \
  --todo-done "Repository continuity tooling implemented." \
  --observation "Session closeout requested after repository workflow work." \
  --action "Updated control files and appended a flight-recorder entry." \
  --result "The repository now has a deterministic restart point."
```

## Required Updates

The workflow updates:

1. `SESSION_STATE.md`
2. `TODO.md`
3. `FLIGHT_RECORDER.md`

When flags are provided, it also updates:

1. `PROJECT_STATUS.md`
2. `CHANGELOG.md`
3. `LESSONS_LEARNED.md`

## Operating Rule

Do not end a session with unstated active files, hidden decisions, or missing next actions. The next restart should be able to continue from artifacts alone.

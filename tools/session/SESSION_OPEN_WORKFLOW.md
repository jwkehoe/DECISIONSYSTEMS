# Session Open Workflow

Use this workflow to recover context without reading the whole repository.

## Canonical Entry Point

Run:

```bash
./tools/session/open_session.sh
```

## Required Inputs

The workflow reads:

1. `SESSION_STATE.md`
2. `PROJECT_STATUS.md`
3. `TODO.md`
4. The most recent entries in `FLIGHT_RECORDER.md`
5. Existing documentation and record counts to identify missing context

## Output Contract

The workflow returns:

- Current project state
- Active work
- Open decisions
- Current risks
- Missing context
- Concise execution plan

## Operating Rule

If the summary shows empty control surfaces or placeholder-only areas, repair the control files before broad implementation work.

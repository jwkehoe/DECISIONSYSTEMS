# Decision Architecting System Setup Documentation v3

## Purpose

This setup creates a simple, local-first repository scaffold for the Decision Architecting System.

The structure intentionally avoids deep hierarchy. The project should grow only when the work proves the need.

## Canonical Layout

```text
/
├── governance/          # Project rules and phase documents
├── records/             # Operational records and session boot files
├── artifacts/           # Prompts, templates, reports, schemas
├── docs/                # Supporting documentation
├── tools/               # Automation scripts
├── src/                 # Implementation
├── tests/               # Tests
├── README.md
├── TODO.md
├── CHANGELOG.md
├── SESSION_STATE.md
├── FLIGHT_RECORDER.md
└── LESSONS_LEARNED.md
```

## Run the Bootstrap Script

```bash
chmod +x tools/bootstrap_decision_system.sh
./tools/bootstrap_decision_system.sh /path/to/project
```

From inside the target repo:

```bash
./tools/bootstrap_decision_system.sh .
```

## Validate the Scaffold

```bash
cd /path/to/project
./tools/validate_repository.sh
```

Expected result:

```text
Repository validation passed.
```

## Design Properties

- Non-destructive: existing files are preserved.
- Idempotent: safe to rerun.
- Git-aware: initializes Git only if `.git/` is missing.
- Simple: no deep directory tree unless future work proves the need.
- Agent-ready: creates session, TODO, changelog, flight recorder, and lessons learned files.

## Agent Session Startup

Read these files first:

1. Run `./tools/session/open_session.sh`
2. `SESSION_STATE.md`
3. `TODO.md`
4. Recent relevant entries in `FLIGHT_RECORDER.md`
5. Directly relevant phase/governance documents

Do not ingest the entire repository by default.

## Closeout Discipline

Before ending meaningful work, update:

- `SESSION_STATE.md`
- `TODO.md`
- `FLIGHT_RECORDER.md`
- `CHANGELOG.md` if user-visible behavior changed
- `LESSONS_LEARNED.md` if a reusable engineering lesson was found

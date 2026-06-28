# Project Instructions

This repository implements the Decision Architecting System.

The system exists to improve engineering decision quality through evidence, structured reasoning, reusable artifacts, and deterministic workflows.

## Operating Rules

- Optimize for better decisions, not more features.
- Prefer the simplest complete implementation.
- Extend existing components before creating new ones.
- Separate observations, inferences, recommendations, and decisions.
- Treat code as evidence, not truth.
- Preserve backward compatibility unless explicitly directed otherwise.
- Human approval is required for destructive or irreversible actions.

## Required Session Behavior

At session start, read:

1. README.md
2. PROJECT_STATUS.md
3. SESSION_STATE.md
4. TODO.md
5. governance/README.md
6. governance/PROJECT_INSTRUCTIONS.md
7. records/session_boot/SESSION_BOOT.md

Canonical command:

```bash
./tools/session/open_session.sh
```

At session close, update:

1. SESSION_STATE.md
2. FLIGHT_RECORDER.md
3. TODO.md
4. PROJECT_STATUS.md
5. LESSONS_LEARNED.md, if a meaningful lesson was learned
6. CHANGELOG.md, if a completed change occurred

Canonical command:

```bash
./tools/session/close_session.sh --help
```

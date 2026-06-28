# Changelog

## Unreleased

### Added

- Initialized repository scaffold for the Decision Architecting System.
- Added universal README, TODO, session state, changelog, and flight recorder structure.
- Added governance, records, artifacts, documentation, source, test, and tooling directories.
- Added session boot, session resume, and session closeout procedures.
- Added canonical session-open and session-close workflow scripts and documentation.
- Added repository validation and repository health-check scripts.
- Added the first substantive Phase 1 documents for architecture, operations, requirements, and repository operating decisions.
- Added the first operational record set for observation, inference, recommendation, and decision capture under `records/`.
- Added a shell-level continuity smoke test for session-open, validation, and repository health-check behavior.
- Added the first repo-native Phase 1 CLI slice for `repo scan` JSON output and reconstructed PRD Markdown export.
- Added a Phase 1 checkpoint commit boundary that groups the current docs, records, routing, tests, and first CLI slice coherently.

### Changed

- Reconciled front-door session guidance to the current canonical tooling and lowercase repository layout.
- Reconciled the bootstrap generator and setup guide with the canonical session, validation, and project-status workflow.
- Updated the model-routing spec to map archaeology work to the current local adam-fleet Qwen3-Next 80B REAM MLX build and to treat coder-next as optional implementation capacity rather than archaeology default.

### Fixed

- Added the previously missing `LESSONS_LEARNED.md` scaffold file to bootstrap output so fresh repositories pass validation.
- Excluded the bootstrap generator from drift scanning so `./tools/repository_health_check.sh` no longer reports a false positive against its own template content.

### Removed

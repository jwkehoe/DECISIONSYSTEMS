# Changelog

## Unreleased

### Added

- Initialized repository scaffold for the Decision Architecting System.
- Added universal README, TODO, session state, changelog, and flight recorder structure.
- Added governance, records, artifacts, documentation, source, test, and tooling directories.
- Added session boot, session resume, and session closeout procedures.
- Added canonical session-open and session-close workflow scripts and documentation.
- Added repository validation and repository health-check scripts.

### Changed

- Reconciled front-door session guidance to the current canonical tooling and lowercase repository layout.
- Reconciled the bootstrap generator and setup guide with the canonical session, validation, and project-status workflow.

### Fixed

- Added the previously missing `LESSONS_LEARNED.md` scaffold file to bootstrap output so fresh repositories pass validation.
- Excluded the bootstrap generator from drift scanning so `./tools/repository_health_check.sh` no longer reports a false positive against its own template content.

### Removed

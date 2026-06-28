# Universal TODO

## Active

- [ ] REPO-007: Expand the CLI beyond the first archaeology slice.
  - Owner: Codex
  - Status: Not started
  - Evidence: `src/dsw` now supports `repo scan` and `repo prd`, but model inventory and richer archaeology outputs are still absent.
  - Next action: Choose the next thin slice after this checkpoint, likely `models scan` or a richer archaeology artifact.
  - Last updated: 2026-06-28

## Next

- [ ] REPO-008: Push the Phase 1 checkpoint commit to GitHub.
  - Owner: Unassigned
  - Status: Not started
  - Evidence: A local checkpoint commit will exist after REPO-006 completes.
  - Next action: Push `main` so the remote matches the local Phase 1 baseline.
  - Last updated: 2026-06-28

## Blocked

## Deferred

## Done

- [x] REPO-000: Assess the repository and identify missing infrastructure.
  - Owner: Codex
  - Status: Complete
  - Evidence: Repository assessment report produced before structural changes.
  - Next action: Build the approved first change set.
  - Last updated: 2026-06-28

- [x] REPO-001: Reconcile bootstrap and setup documentation with the canonical lowercase repository layout.
  - Owner: Codex
  - Status: Complete
  - Evidence: `tools/bootstrap_decision_system.sh`, `tools/Decision_System_Setup_Documentation.md`, fresh bootstrap verification in `/tmp/decisionsystems_bootstrap_check_2`, and passing `./tools/validate_repository.sh` plus `./tools/repository_health_check.sh`
  - Next action: Start replacing placeholder-only docs and records with first substantive Phase 1 artifacts.
  - Last updated: 2026-06-28

- [x] REPO-002: Create the first substantive docs under `docs/architecture`, `docs/operations`, `docs/requirements`, and `docs/decisions`.
  - Owner: Codex
  - Status: Complete
  - Evidence: `docs/architecture/phase_1_workbench_architecture.md`, `docs/operations/repository_continuity_runbook.md`, `docs/requirements/phase_1_workbench_requirements.md`, `docs/decisions/ADR-0001-repository-operating-model.md`, and passing `./tools/repository_health_check.sh`
  - Next action: Create the first operational records that reflect the new operating model and Phase 1 scope.
  - Last updated: 2026-06-28

- [x] REPO-003: Create the first operational records under `records/observations`, `records/inferences`, `records/recommendations`, and `records/decisions`.
  - Owner: Codex
  - Status: Complete
  - Evidence: `records/observations/2026-06-28-phase-1-foundation-observation.md`, `records/inferences/2026-06-28-phase-1-foundation-inference.md`, `records/recommendations/2026-06-28-phase-1-foundation-recommendation.md`, `records/decisions/2026-06-28-phase-1-foundation-decision.md`, and passing `./tools/repository_health_check.sh`
  - Next action: Add lightweight continuity tests, then start the first CLI implementation slice.
  - Last updated: 2026-06-28

- [x] REPO-004: Add lightweight tests for repository continuity tooling.
  - Owner: Codex
  - Status: Complete
  - Evidence: `tests/test_repository_continuity.sh`, `tests/README.md`, passing `./tests/test_repository_continuity.sh`, and health check reporting `Populated: tests (1 non-README files)`
  - Next action: Start `REPO-005`, the first small repo-native Phase 1 CLI slice.
  - Last updated: 2026-06-28

- [x] REPO-005: Choose and implement the first small Phase 1 CLI slice in `src/`.
  - Owner: Codex
  - Status: Complete
  - Evidence: `src/dsw/repo_scan.py`, `src/dsw/prd.py`, `src/dsw/cli.py`, `src/dsw/__main__.py`, passing `./tests/test_repo_prd_cli.sh`, and live `python3 -m src.dsw repo scan --path .`
  - Next action: Checkpoint the accumulated work in Git before widening the Phase 1 implementation surface.
  - Last updated: 2026-06-28

- [x] REPO-006: Stage and commit the accumulated Phase 1 docs, records, routing, and continuity-test work.
  - Owner: Codex
  - Status: Complete
  - Evidence: Local checkpoint commit created after staging docs, records, routing updates, tests, and the first CLI slice.
  - Next action: Choose the next implementation slice and push the checkpoint upstream.
  - Last updated: 2026-06-28

## Task Format

- [ ] TASK-ID: Task description
  - Owner:
  - Status:
  - Evidence:
  - Next action:
  - Last updated:

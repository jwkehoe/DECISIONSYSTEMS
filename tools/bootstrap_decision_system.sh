#!/usr/bin/env bash
set -euo pipefail

# Decision Architecting System repository bootstrapper.
# Creates or normalizes the project filesystem scaffold without overwriting existing files.
# Usage:
#   ./bootstrap_decision_system.sh [target_dir]

TARGET_DIR="${1:-.}"
PROJECT_NAME="Decision Architecting System"
NOW_LOCAL="$(date '+%Y-%m-%d %H:%M %Z')"
CREATED_FILES=()
PRESERVED_FILES=()
CREATED_DIRS=()
ASSUMPTIONS=()
GIT_STATE=""

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"
TARGET_ABS="$(pwd)"

record_created_file() { CREATED_FILES+=("$1"); }
record_preserved_file() { PRESERVED_FILES+=("$1"); }
record_created_dir() { CREATED_DIRS+=("$1"); }

ensure_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
    record_created_dir "$dir/"
  fi
}

write_file_if_missing() {
  local file="$1"
  local dir
  dir="$(dirname "$file")"
  [[ "$dir" == "." ]] || ensure_dir "$dir"

  if [[ -e "$file" ]]; then
    cat >/dev/null
    record_preserved_file "$file"
  else
    cat > "$file"
    record_created_file "$file"
  fi
}

write_file_if_missing "README.md" <<'EOF'
# Decision Architecting System

## Purpose

Local-first engineering workbench for improving the quality of engineering decisions through evidence, structured reasoning, reusable artifacts, and deterministic workflows.

## Core Principle

Optimize for better decisions, not more features.

## Phase Map

1. Phase 1 — Decision Systems Workbench
2. Phase 2 — LLM Mega Matrix
3. Phase 3 — Software Archaeology
4. Phase 4 — Decision Systems Architecture
5. Phase 5 — Decision Cell Orchestration

## Repository Conventions

- Preserve existing work unless explicitly directed otherwise.
- Prefer small, reversible changes.
- Extend existing components before creating new ones.
- Separate observations, inferences, recommendations, and decisions.
- Record structural, architectural, or behavioral changes in `FLIGHT_RECORDER.md`.
- Record user-visible changes in `CHANGELOG.md`.

## Session Restart

Start by reading:

1. `SESSION_STATE.md`
2. `records/session_boot/SESSION_BOOT.md`
3. `TODO.md`
4. Recent relevant entries in `FLIGHT_RECORDER.md`

Do not read the entire repository unless the task requires it.

Canonical session-open command:

```bash
./tools/session/open_session.sh
```

## Active Control Files

- Active TODOs: `TODO.md`
- Session continuity: `SESSION_STATE.md`
- Engineering trace: `FLIGHT_RECORDER.md`
- User-facing history: `CHANGELOG.md`
- Session open workflow: `tools/session/SESSION_OPEN_WORKFLOW.md`
- Session close workflow: `tools/session/SESSION_CLOSE_WORKFLOW.md`

## Documentation vs. Records

This repository intentionally separates documentation from operational records.

### `docs/`

The `docs/` hierarchy contains explanatory material intended to help humans and AI understand the system's architecture, design, processes, and rationale.

Example:

- `docs/decisions/` - Documentation describing the decision-making framework, methodology, standards, and process.

### `records/`

The `records/` hierarchy contains the project's operational artifacts generated during execution. These files represent the historical record of the project and should not be treated as explanatory documentation.

Example:

- `records/decisions/` - Actual decision records produced during the project, including the evidence considered, alternatives evaluated, trade-offs, rationale, and final decisions.

**Rule of thumb**

- **`docs/` explains how we work.**
- **`records/` preserves what actually happened.**
EOF

write_file_if_missing "TODO.md" <<'EOF'
# Universal TODO

## Active

## Next

## Blocked

## Deferred

## Done

## Task Format

- [ ] TASK-ID: Task description
  - Owner:
  - Status:
  - Evidence:
  - Next action:
  - Last updated:
EOF

write_file_if_missing "SESSION_STATE.md" <<EOF
# Universal Session State

## Current Objective

Initialize or normalize the Decision Architecting System repository scaffold and continuity workflow.

## Current Branch / Commit

Unknown until checked by Git.

## Active Files

- README.md
- PROJECT_STATUS.md
- TODO.md
- SESSION_STATE.md
- CHANGELOG.md
- FLIGHT_RECORDER.md
- records/session_boot/SESSION_BOOT.md

## Decisions Made

- Use a local-first, artifact-first project structure.
- Keep session continuity compact and restartable.
- Use the flight recorder for append-only engineering traceability.

## Open Questions

- None recorded during bootstrap.

## Known Constraints

- Do not delete or overwrite user-created content without explicit approval.
- Do not introduce application code during scaffold creation.

## Next Safe Action

Run \`./tools/session/open_session.sh\` and confirm the control files reflect the intended repository state.

## Restart Point

Run \`./tools/session/open_session.sh\`, then inspect \`TODO.md\` Active and the latest \`FLIGHT_RECORDER.md\` entry.

## Last Updated

${NOW_LOCAL}
EOF

write_file_if_missing "PROJECT_STATUS.md" <<'EOF'
# Project Status

## Current Phase

Phase 1: Decision Systems Workbench foundation.

## Current State

The repository skeleton has been created with governance, documentation, records, artifacts, tools, source, and test areas.

## Active Focus

Stabilize the project operating model, session workflow, and base documentation before implementing functional modules.

## Completed

- Repository structure initialized.
- Governance documents placed under governance/.
- Phase documents placed under governance/.
- Bootstrap tooling placed under tools/.
- Root housekeeping files established.
- Lessons learned captured at repository root.

## Open Items

- Reconcile bootstrap and setup documentation with the canonical lowercase repository layout.
- Add first real architecture, operations, requirements, and decisions documents.
- Add first real observations, inferences, recommendations, and decisions records.
- Add lightweight tests for repository continuity tooling.

## Blockers

No code-level blockers are recorded, but the repository still has placeholder-heavy documentation and record surfaces.

## Latest Session Update

### Timestamp

Bootstrap-time placeholder.

### Current State

The repository scaffold has been initialized but not yet validated against the canonical continuity workflow.

### Active Focus

Run the session-open and validation tooling, then reconcile any layout or guidance drift.

### Risks

Generated repositories can drift if the bootstrap script, setup guide, and live control surfaces do not describe the same workflow.
EOF

write_file_if_missing "FLIGHT_RECORDER.md" <<EOF
# Flight Recorder

## ${NOW_LOCAL}

### Observation

Repository scaffold initialization requested for Decision Architecting System.

### Action

Created or preserved project control files, documentation folders, governance folders, records folders, artifacts folders, source/test/tool placeholders, Git ignore rules, and session boot prompts.

### Result

Bootstrap scaffold is available for review.

### Evidence

Run \`git status\` and inspect generated files.

### Next Action

Review scaffold and begin adding phase governing documents.
EOF

write_file_if_missing "CHANGELOG.md" <<'EOF'
# Changelog

## Unreleased

### Added

- Initialized repository scaffold for the Decision Architecting System.
- Added universal README, TODO, session state, changelog, and flight recorder structure.
- Added governance, records, artifacts, documentation, source, test, and tooling directories.
- Added session boot, session resume, and session closeout procedures.

### Changed

### Fixed

### Removed
EOF

write_file_if_missing "LESSONS_LEARNED.md" <<'EOF'
# Lessons Learned

Capture reusable engineering lessons here when the work produces something worth preserving beyond the immediate task.
EOF

write_file_if_missing ".gitignore" <<'EOF'
.DS_Store
.env
.env.*
!.env.example
__pycache__/
*.pyc
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/
node_modules/
dist/
build/
.venv/
venv/
*.log
EOF

write_file_if_missing ".gitattributes" <<'EOF'
* text=auto eol=lf
*.md text eol=lf
*.py text eol=lf
*.json text eol=lf
*.yaml text eol=lf
*.yml text eol=lf
EOF

write_file_if_missing "docs/README.md" <<'EOF'
# Documentation

Project documentation lives here. Prefer concise, durable documents over long conversational notes.
EOF
write_file_if_missing "docs/architecture/README.md" <<'EOF'
# Architecture

Architecture notes, diagrams, constraints, and module boundaries.
EOF
write_file_if_missing "docs/decisions/README.md" <<'EOF'
# Decisions

Architecture decision records and significant engineering decisions.
EOF
write_file_if_missing "docs/requirements/README.md" <<'EOF'
# Requirements

Functional, non-functional, and operational requirements.
EOF
write_file_if_missing "docs/operations/README.md" <<'EOF'
# Operations

Operational procedures, validation commands, runbooks, and recovery notes.
EOF
write_file_if_missing "docs/phase_1_workbench/README.md" <<'EOF'
# Phase 1 — Decision Systems Workbench

Phase 1 governing notes and workbench artifacts.
EOF
write_file_if_missing "docs/phase_2_llm_mega_matrix/README.md" <<'EOF'
# Phase 2 — LLM Mega Matrix

Phase 2 governing notes and model evaluation artifacts.
EOF
write_file_if_missing "docs/phase_3_software_archaeology/README.md" <<'EOF'
# Phase 3 — Software Archaeology

Phase 3 governing notes and archaeology workflow artifacts.
EOF
write_file_if_missing "docs/phase_4_decision_systems_architecture/README.md" <<'EOF'
# Phase 4 — Decision Systems Architecture

Phase 4 governing notes and decision-system architecture artifacts.
EOF
write_file_if_missing "docs/phase_5_decision_cell_orchestration/README.md" <<'EOF'
# Phase 5 — Decision Cell Orchestration

Phase 5 governing notes and orchestration artifacts.
EOF

write_file_if_missing "governance/README.md" <<'EOF'
# Governance

Project principles, engineering priorities, and architectural constraints.
EOF
write_file_if_missing "governance/PROJECT_INSTRUCTIONS.md" <<'EOF'
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
EOF
write_file_if_missing "governance/project_principles.md" <<'EOF'
# Project Principles

- Optimize for better decisions, not more features.
- Prefer the simplest implementation that satisfies requirements.
- Extend existing components before creating new ones.
- Treat code as evidence, not truth.
- Separate observations, inferences, and recommendations.
- Generate durable artifacts rather than conversational output.
- Prefer deterministic, testable behavior.
- Require human approval for destructive or irreversible actions.
EOF
write_file_if_missing "governance/engineering_priorities.md" <<'EOF'
# Engineering Priorities

In descending order:

1. Correctness
2. Simplicity
3. Reuse
4. Maintainability
5. Explainability
6. Performance
7. Extensibility

A lower priority must not override a higher priority without explicit justification.
EOF
write_file_if_missing "governance/architectural_constraints.md" <<'EOF'
# Architectural Constraints

- Do not introduce new architectural layers unless existing modules cannot reasonably support the requirement.
- Prefer integrating with existing project modules:
  - Platform
  - LLM Mega Matrix
  - Software Archaeology
  - Decision Systems
  - Decision Cells
- Avoid duplicate implementations.
- Preserve backward compatibility unless explicitly directed otherwise.
EOF

write_file_if_missing "records/README.md" <<'EOF'
# Records

Evidence records separated into observations, inferences, recommendations, and decisions.
EOF
write_file_if_missing "records/session_boot/README.md" <<'EOF'
# Session Boot

Session boot files and restart procedures for LLM agents.
EOF
write_file_if_missing "records/observations/README.md" <<'EOF'
# Observations

Factual observations captured during engineering work.
EOF
write_file_if_missing "records/inferences/README.md" <<'EOF'
# Inferences

Reasoned conclusions derived from observations.
EOF
write_file_if_missing "records/recommendations/README.md" <<'EOF'
# Recommendations

Recommended actions, trade-offs, and rationale.
EOF
write_file_if_missing "records/decisions/README.md" <<'EOF'
# Decision Records

Approved decisions and their supporting evidence.
EOF
write_file_if_missing "records/session_boot/SESSION_BOOT.md" <<'EOF'
# Session Boot

Read order for any LLM agent resuming this project:

1. Run `./tools/session/open_session.sh`
2. Read `SESSION_STATE.md`
3. Read `TODO.md`
4. Read `FLIGHT_RECORDER.md` — only the most recent relevant entries
5. Read `CHANGELOG.md` — only Unreleased and latest release
6. Read relevant governance or phase documents only when needed

Do not read the entire repository unless the task requires it.

## Operating Rules

- Start from the current objective.
- Inspect only files relevant to the active task.
- Prefer targeted grep/search over full-file reading.
- Summarize findings before editing.
- Update `SESSION_STATE.md` after meaningful work.
- Append to `FLIGHT_RECORDER.md` after every structural, architectural, or behavioral change.
- Update `TODO.md` when task state changes.
- Update `CHANGELOG.md` for user-visible changes.

## Aggressive Impatience Rules

Stop expanding context when you have enough evidence to make the next safe change.

Do not keep reading files looking for perfect certainty when:

- The active task is local and bounded.
- The affected files are identified.
- The expected change is reversible.
- Existing tests or validation steps can confirm the result.

Prefer one small verified change over a broad speculative refactor.

## Recommended Restart Points

Restart the LLM session when any of the following occurs:

- The model begins confusing project phases or module boundaries.
- More than 6 files have been modified in one session.
- The session has shifted objectives more than twice.
- The model cannot summarize the current objective in three sentences.
- The working context includes large pasted logs, stack traces, or generated output.
- The next step requires architectural judgment after a long coding session.
- A test failure has caused more than two unsuccessful repair attempts.

Before restart, update:

1. `SESSION_STATE.md`
2. `TODO.md`
3. `FLIGHT_RECORDER.md`
4. `CHANGELOG.md` if applicable

Then provide the next session with `records/session_boot/SESSION_BOOT.md` and `SESSION_STATE.md` first.

## Canonical Workflow Files

- Session Open: `tools/session/SESSION_OPEN_WORKFLOW.md`
- Session Close: `tools/session/SESSION_CLOSE_WORKFLOW.md`
EOF

write_file_if_missing "artifacts/README.md" <<'EOF'
# Artifacts

Durable generated project artifacts.
EOF
write_file_if_missing "artifacts/prompts/README.md" <<'EOF'
# Prompts

Reusable LLM prompts for project workflows.
EOF
write_file_if_missing "artifacts/templates/README.md" <<'EOF'
# Templates

Reusable templates for project documents and records.
EOF
write_file_if_missing "artifacts/schemas/README.md" <<'EOF'
# Schemas

Machine-readable schemas and contracts.
EOF
write_file_if_missing "artifacts/reports/README.md" <<'EOF'
# Reports

Generated reports and decision support outputs.
EOF
write_file_if_missing "artifacts/prompts/session_resume_prompt.md" <<'EOF'
# Session Resume Prompt

You are resuming work on the Decision Architecting System.

First read:

1. Run `./tools/session/open_session.sh`
2. `SESSION_STATE.md`
3. `records/session_boot/SESSION_BOOT.md`
4. `TODO.md`
5. Latest relevant entries in `FLIGHT_RECORDER.md`

Then respond with:

- Current objective
- Current known state
- Next safe action
- Files you need to inspect next

Do not perform edits until you have identified the next safe action.
EOF
write_file_if_missing "artifacts/prompts/session_closeout_prompt.md" <<'EOF'
# Session Closeout Prompt

Close out the current engineering session.

Update:

1. `SESSION_STATE.md`
2. `TODO.md`
3. `FLIGHT_RECORDER.md`
4. `CHANGELOG.md` if user-visible changes occurred

Then produce a compact handoff containing:

- What changed
- Why it changed
- Evidence or validation
- Remaining risks
- Next safe action
- Recommended restart point
EOF

write_file_if_missing "src/README.md" <<'EOF'
# Source

Application source code will live here when implementation begins.
EOF
write_file_if_missing "tests/README.md" <<'EOF'
# Tests

Automated tests and validation assets will live here.
EOF
write_file_if_missing "tools/README.md" <<'EOF'
# Tools

Project utility scripts and operational tools.

## Canonical Scripts

- `tools/session/open_session.sh` — concise session-open summary
- `tools/session/close_session.sh` — deterministic session-close updater
- `tools/validate_repository.sh` — required file and directory validation
- `tools/repository_health_check.sh` — placeholder, drift, and hygiene scan
EOF
write_file_if_missing "tools/session/README.md" <<'EOF'
# Session Tools

Session continuity and tracking procedures.
EOF
write_file_if_missing "tools/session/SESSION_OPEN_WORKFLOW.md" <<'EOF'
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
EOF
write_file_if_missing "tools/session/SESSION_CLOSE_WORKFLOW.md" <<'EOF'
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
EOF
write_file_if_missing "tools/session/update_session_state.md" <<'EOF'
# Session State Update Procedure

After meaningful work, update these files:

1. `SESSION_STATE.md`
   - Current objective
   - Active files
   - Decisions made
   - Open questions
   - Next safe action
   - Restart point

2. `FLIGHT_RECORDER.md`
   - Append a timestamped entry
   - Include observation, action, result, evidence, and next action

3. `TODO.md`
   - Move completed items to Done
   - Keep Active limited to current work
   - Add blockers explicitly

4. `CHANGELOG.md`
   - Update only for user-visible changes
EOF
write_file_if_missing "tools/session/open_session.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

read_section() {
  local file="$1"
  local heading="$2"
  awk -v heading="$heading" '
    $0 == heading { in_section=1; next }
    in_section && /^## / { exit }
    in_section { print }
  ' "$file" | sed '/^[[:space:]]*$/d'
}

tail_flight_recorder() {
  awk '
    /^## / { block_count++; block[block_count]=$0 ORS; next }
    block_count > 0 { block[block_count]=block[block_count] $0 ORS }
    END {
      start = block_count > 2 ? block_count - 1 : 1
      for (i = start; i <= block_count; i++) {
        if (block[i] != "") {
          printf "%s", block[i]
          if (i < block_count) {
            printf "\n"
          }
        }
      }
    }
  ' "$ROOT_DIR/FLIGHT_RECORDER.md"
}

count_non_readme_files() {
  local dir="$1"
  find "$ROOT_DIR/$dir" -type f ! -name 'README.md' ! -name '.DS_Store' | wc -l | tr -d ' '
}

current_objective="$(read_section "$ROOT_DIR/SESSION_STATE.md" "## Current Objective" | head -n 1)"
project_state="$(read_section "$ROOT_DIR/PROJECT_STATUS.md" "## Current State" | head -n 1)"
active_focus="$(read_section "$ROOT_DIR/PROJECT_STATUS.md" "## Active Focus" | head -n 1)"
active_todos="$(read_section "$ROOT_DIR/TODO.md" "## Active")"
next_action="$(read_section "$ROOT_DIR/SESSION_STATE.md" "## Next Safe Action" | head -n 1)"
open_questions="$(read_section "$ROOT_DIR/SESSION_STATE.md" "## Open Questions")"
blockers="$(read_section "$ROOT_DIR/PROJECT_STATUS.md" "## Blockers")"

architecture_docs_count="$(count_non_readme_files docs/architecture)"
operations_docs_count="$(count_non_readme_files docs/operations)"
requirements_docs_count="$(count_non_readme_files docs/requirements)"
decision_docs_count="$(count_non_readme_files docs/decisions)"
observation_records_count="$(count_non_readme_files records/observations)"
decision_records_count="$(count_non_readme_files records/decisions)"

missing_context=()
[[ "$active_todos" == "" ]] && missing_context+=("TODO Active section is empty.")
[[ "$open_questions" == "" || "$open_questions" == "- None recorded during bootstrap." ]] && missing_context+=("No open questions are recorded.")
(( architecture_docs_count == 0 )) && missing_context+=("No architecture documents exist beyond README placeholders.")
(( operations_docs_count == 0 )) && missing_context+=("No operations runbooks exist beyond README placeholders.")
(( requirements_docs_count == 0 )) && missing_context+=("No requirements documents exist beyond README placeholders.")
(( decision_docs_count == 0 )) && missing_context+=("No ADR or decision documentation exists beyond README placeholders.")
(( observation_records_count == 0 )) && missing_context+=("No observation records have been captured yet.")
(( decision_records_count == 0 )) && missing_context+=("No decision records have been captured yet.")

printf '# Session Open Summary\n\n'
printf '## Current Project State\n\n'
printf -- '- Objective: %s\n' "${current_objective:-Unknown}"
printf -- '- Project state: %s\n' "${project_state:-Unknown}"
printf -- '- Active focus: %s\n\n' "${active_focus:-Unknown}"

printf '## Active Work\n\n'
if [[ -n "$active_todos" ]]; then
  printf '%s\n\n' "$active_todos"
else
  printf -- '- No active TODO items are recorded.\n\n'
fi

printf '## Open Decisions\n\n'
if [[ -n "$open_questions" ]]; then
  printf '%s\n\n' "$open_questions"
else
  printf -- '- No open questions are currently recorded.\n\n'
fi

printf '## Current Risks\n\n'
if [[ -n "$blockers" && "$blockers" != "None currently recorded." ]]; then
  printf '%s\n\n' "$blockers"
else
  printf -- '- Control files remain mostly scaffold-level; repo status can drift if closeout discipline slips.\n'
  printf -- '- Documentation and records are still thin, so decisions may get re-litigated across sessions.\n\n'
fi

printf '## Missing Context\n\n'
if (( ${#missing_context[@]} == 0 )); then
  printf -- '- No obvious context gaps detected from the control files.\n\n'
else
  printf -- '- %s\n' "${missing_context[@]}"
  printf '\n'
fi

printf '## Recent Flight Recorder\n\n```text\n'
tail_flight_recorder
printf '```\n\n'

printf '## Execution Plan\n\n'
printf -- '1. Validate the current control files and tool references before making broad edits.\n'
printf -- '2. Work the items in `TODO.md` Active first, or establish them if the section is empty.\n'
printf -- '3. Use the next safe action as the default immediate step: %s\n' "${next_action:-No next safe action recorded.}"
EOF
write_file_if_missing "tools/session/close_session.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
NOW_LOCAL="$(TZ=America/Chicago date '+%Y-%m-%d %H:%M %Z')"

objective=""
next_action=""
restart_point=""
project_state=""
project_focus=""
observation=""
action=""
result=""
evidence=""
risk=""

active_files=()
decisions=()
open_questions=()
constraints=()
todo_active=()
todo_done=()
todo_blocked=()
changelog_added=()
lessons=()

usage() {
  cat <<'HELP'
Usage:
  close_session.sh --objective TEXT --next-action TEXT --restart-point TEXT
                   [--project-state TEXT] [--project-focus TEXT]
                   [--observation TEXT] [--action TEXT] [--result TEXT]
                   [--evidence TEXT] [--risk TEXT]
                   [--active-file PATH]...
                   [--decision TEXT]...
                   [--open-question TEXT]...
                   [--constraint TEXT]...
                   [--todo-active TEXT]...
                   [--todo-done TEXT]...
                   [--todo-blocked TEXT]...
                   [--changelog-added TEXT]...
                   [--lesson TEXT]...
HELP
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --objective) objective="$2"; shift 2 ;;
    --next-action) next_action="$2"; shift 2 ;;
    --restart-point) restart_point="$2"; shift 2 ;;
    --project-state) project_state="$2"; shift 2 ;;
    --project-focus) project_focus="$2"; shift 2 ;;
    --observation) observation="$2"; shift 2 ;;
    --action) action="$2"; shift 2 ;;
    --result) result="$2"; shift 2 ;;
    --evidence) evidence="$2"; shift 2 ;;
    --risk) risk="$2"; shift 2 ;;
    --active-file) active_files+=("$2"); shift 2 ;;
    --decision) decisions+=("$2"); shift 2 ;;
    --open-question) open_questions+=("$2"); shift 2 ;;
    --constraint) constraints+=("$2"); shift 2 ;;
    --todo-active) todo_active+=("$2"); shift 2 ;;
    --todo-done) todo_done+=("$2"); shift 2 ;;
    --todo-blocked) todo_blocked+=("$2"); shift 2 ;;
    --changelog-added) changelog_added+=("$2"); shift 2 ;;
    --lesson) lessons+=("$2"); shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 1 ;;
  esac
done

if [[ -z "$objective" || -z "$next_action" || -z "$restart_point" ]]; then
  echo "Missing required arguments." >&2
  usage >&2
  exit 1
fi

make_list_file() {
  local tmp
  tmp="$(mktemp)"
  if (( $# == 0 )); then
    printf -- '- None recorded.\n' > "$tmp"
  else
    for item in "$@"; do
      printf -- '- %s\n' "$item" >> "$tmp"
    done
  fi
  printf '%s\n' "$tmp"
}

replace_section() {
  local file="$1"
  local heading="$2"
  local content_file="$3"
  local tmp
  tmp="$(mktemp)"
  awk -v heading="$heading" -v content_file="$content_file" '
    BEGIN {
      while ((getline line < content_file) > 0) {
        replacement = replacement line ORS
      }
    }
    $0 == heading {
      print $0
      print ""
      printf "%s", replacement
      in_section = 1
      next
    }
    in_section && /^## / {
      in_section = 0
    }
    !in_section {
      print
    }
  ' "$file" > "$tmp"
  mv "$tmp" "$file"
}

replace_or_append_project_status_update() {
  local file="$1"
  local content_file="$2"
  if rg -q '^## Latest Session Update$' "$file"; then
    replace_section "$file" "## Latest Session Update" "$content_file"
  else
    {
      printf '\n## Latest Session Update\n\n'
      cat "$content_file"
    } >> "$file"
  fi
}

append_section_items() {
  local file="$1"
  local heading="$2"
  shift 2
  (( $# == 0 )) && return 0

  local content_file tmp
  content_file="$(mktemp)"
  for item in "$@"; do
    printf -- '- [ ] %s\n' "$item" >> "$content_file"
  done

  tmp="$(mktemp)"
  awk -v heading="$heading" -v content_file="$content_file" '
    BEGIN {
      while ((getline line < content_file) > 0) {
        addition = addition line ORS
      }
    }
    $0 == heading && !inserted {
      print
      print ""
      inserted = 1
      next
    }
    inserted && /^## / && !done {
      printf "%s", addition
      done = 1
      inserted = 0
    }
    { print }
    END {
      if (inserted && !done) {
        printf "%s", addition
      }
    }
  ' "$file" > "$tmp"
  mv "$tmp" "$file"
}

append_plain_items() {
  local file="$1"
  shift
  (( $# == 0 )) && return 0
  for item in "$@"; do
    printf '\n- %s' "$item" >> "$file"
  done
  printf '\n' >> "$file"
}

branch_commit="Unknown until checked by Git."
if git -C "$ROOT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch_name="$(git -C "$ROOT_DIR" branch --show-current 2>/dev/null || true)"
  commit_sha="$(git -C "$ROOT_DIR" rev-parse --short HEAD 2>/dev/null || true)"
  branch_commit="${branch_name:-detached} @ ${commit_sha:-unknown}"
fi

objective_file="$(mktemp)"
printf '%s\n' "$objective" > "$objective_file"

branch_file="$(mktemp)"
printf '%s\n' "$branch_commit" > "$branch_file"

active_files_file="$(make_list_file "${active_files[@]}")"
decisions_file="$(make_list_file "${decisions[@]}")"
open_questions_file="$(make_list_file "${open_questions[@]}")"
constraints_file="$(make_list_file "${constraints[@]}")"
next_action_file="$(mktemp)"
printf '%s\n' "$next_action" > "$next_action_file"
restart_point_file="$(mktemp)"
printf '%s\n' "$restart_point" > "$restart_point_file"
timestamp_file="$(mktemp)"
printf '%s\n' "$NOW_LOCAL" > "$timestamp_file"

replace_section "$ROOT_DIR/SESSION_STATE.md" "## Current Objective" "$objective_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Current Branch / Commit" "$branch_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Active Files" "$active_files_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Decisions Made" "$decisions_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Open Questions" "$open_questions_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Known Constraints" "$constraints_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Next Safe Action" "$next_action_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Restart Point" "$restart_point_file"
replace_section "$ROOT_DIR/SESSION_STATE.md" "## Last Updated" "$timestamp_file"

append_section_items "$ROOT_DIR/TODO.md" "## Active" "${todo_active[@]}"
append_section_items "$ROOT_DIR/TODO.md" "## Done" "${todo_done[@]}"
append_section_items "$ROOT_DIR/TODO.md" "## Blocked" "${todo_blocked[@]}"

cat >> "$ROOT_DIR/FLIGHT_RECORDER.md" <<ENTRY

## $NOW_LOCAL

### Observation

${observation:-Session closeout executed.}

### Action

${action:-Updated control files and captured session state.}

### Result

${result:-Session state was refreshed for the next restart.}

### Evidence

${evidence:-Review SESSION_STATE.md, TODO.md, PROJECT_STATUS.md, and repository validation output.}

### Next Action

$next_action
ENTRY

if [[ -n "$project_state" || -n "$project_focus" || -n "$risk" ]]; then
  project_status_file="$(mktemp)"
  cat > "$project_status_file" <<STATUS
### Timestamp

$NOW_LOCAL

### Current State

${project_state:-No project state update provided.}

### Active Focus

${project_focus:-No focus update provided.}

### Risks

${risk:-No new risks recorded.}
STATUS
  replace_or_append_project_status_update "$ROOT_DIR/PROJECT_STATUS.md" "$project_status_file"
fi

if (( ${#changelog_added[@]} > 0 )); then
  append_plain_items "$ROOT_DIR/CHANGELOG.md" "${changelog_added[@]}"
fi

if (( ${#lessons[@]} > 0 )); then
  {
    printf '\n## %s\n\n' "$NOW_LOCAL"
    for lesson in "${lessons[@]}"; do
      printf -- '- %s\n' "$lesson"
    done
  } >> "$ROOT_DIR/LESSONS_LEARNED.md"
fi

printf '# Session Closeout Complete\n\n'
printf -- '- Updated `SESSION_STATE.md`, `TODO.md`, and `FLIGHT_RECORDER.md`.\n'
if [[ -n "$project_state" || -n "$project_focus" || -n "$risk" ]]; then
  printf -- '- Appended a latest-session block to `PROJECT_STATUS.md`.\n'
fi
if (( ${#changelog_added[@]} > 0 )); then
  printf -- '- Added `CHANGELOG.md` entries.\n'
fi
if (( ${#lessons[@]} > 0 )); then
  printf -- '- Added `LESSONS_LEARNED.md` entries.\n'
fi
printf '\n## Resume Summary\n\n'
printf -- '- Objective: %s\n' "$objective"
printf -- '- Next safe action: %s\n' "$next_action"
printf -- '- Restart point: %s\n' "$restart_point"
EOF
write_file_if_missing "tools/validate_repository.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "README.md"
  "PROJECT_STATUS.md"
  "TODO.md"
  "SESSION_STATE.md"
  "FLIGHT_RECORDER.md"
  "CHANGELOG.md"
  "LESSONS_LEARNED.md"
  "governance/README.md"
  "governance/PROJECT_INSTRUCTIONS.md"
  "governance/engineering_priorities.md"
  "governance/architectural_constraints.md"
  "governance/project_principles.md"
  "records/session_boot/SESSION_BOOT.md"
  "tools/session/open_session.sh"
  "tools/session/close_session.sh"
  "tools/validate_repository.sh"
  "tools/repository_health_check.sh"
)

required_dirs=(
  "docs/architecture"
  "docs/operations"
  "docs/requirements"
  "docs/decisions"
  "records/observations"
  "records/inferences"
  "records/recommendations"
  "records/decisions"
  "records/session_boot"
  "artifacts/prompts"
  "artifacts/templates"
  "artifacts/reports"
  "artifacts/schemas"
  "tools/session"
  "src"
  "tests"
)

missing=0

printf '# Repository Validation\n\n'

for path in "${required_files[@]}"; do
  if [[ -f "$ROOT_DIR/$path" ]]; then
    printf -- '- OK file: %s\n' "$path"
  else
    printf -- '- MISSING file: %s\n' "$path"
    missing=1
  fi
done

for path in "${required_dirs[@]}"; do
  if [[ -d "$ROOT_DIR/$path" ]]; then
    printf -- '- OK dir: %s\n' "$path"
  else
    printf -- '- MISSING dir: %s\n' "$path"
    missing=1
  fi
done

if [[ $missing -ne 0 ]]; then
  printf '\nValidation failed.\n'
  exit 1
fi

printf '\nRepository validation passed.\n'
EOF
write_file_if_missing "tools/repository_health_check.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

count_non_readme_files() {
  local dir="$1"
  find "$ROOT_DIR/$dir" -type f ! -name 'README.md' ! -name '.DS_Store' | wc -l | tr -d ' '
}

printf '# Repository Health Check\n\n'

if "$ROOT_DIR/tools/validate_repository.sh" >/dev/null; then
  printf -- '- Validation: pass\n'
else
  printf -- '- Validation: fail\n'
fi

for dir in docs/architecture docs/operations docs/requirements docs/decisions \
           records/observations records/inferences records/recommendations records/decisions \
           artifacts/templates artifacts/reports artifacts/schemas src tests; do
  count="$(count_non_readme_files "$dir")"
  if [[ "$count" == "0" ]]; then
    printf -- '- Placeholder-only: %s\n' "$dir"
  else
    printf -- '- Populated: %s (%s non-README files)\n' "$dir" "$count"
  fi
done

printf -- '- Committed .DS_Store files:\n'
ds_store_found=0
while IFS= read -r path; do
  ds_store_found=1
  printf '  %s\n' "$path"
done < <(find "$ROOT_DIR" -name '.DS_Store' -not -path '*/.git/*' | sed "s#^$ROOT_DIR/##")
if [[ $ds_store_found -eq 0 ]]; then
  printf '  none\n'
fi

printf -- '- Known drift references:\n'
drift_found=0
while IFS= read -r match; do
  drift_found=1
  printf '  %s\n' "$match"
done < <(rg -n --glob '!tools/repository_health_check.sh' --glob '!tools/bootstrap_decision_system.sh' "GOVERNANCE/|PHASES/|BOOT/|bootstrap_decision_system_v3.sh|scripts/validate_project.sh|GOVERNANCE/TOKEN_STRATEGY.md|BOOT/RESTART_GUIDE.md" \
  "$ROOT_DIR/README.md" \
  "$ROOT_DIR/governance" \
  "$ROOT_DIR/records" \
  "$ROOT_DIR/tools" || true)
if [[ $drift_found -eq 0 ]]; then
  printf '  none\n'
fi
EOF

if command -v git >/dev/null 2>&1; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    GIT_STATE="already initialized"
  else
    git init >/dev/null
    GIT_STATE="initialized"
  fi
else
  GIT_STATE="git unavailable"
  ASSUMPTIONS+=("Git was not available on PATH; repository initialization was skipped.")
fi

chmod +x \
  tools/session/open_session.sh \
  tools/session/close_session.sh \
  tools/validate_repository.sh \
  tools/repository_health_check.sh

if (( ${#CREATED_FILES[@]} > 0 )); then
  cat >> FLIGHT_RECORDER.md <<EOF

## ${NOW_LOCAL}

### Observation

Bootstrap script executed in ${TARGET_ABS}.

### Action

Created missing scaffold files and preserved existing files.

### Result

Created ${#CREATED_FILES[@]} files and preserved ${#PRESERVED_FILES[@]} existing files.

### Evidence

Run \`git status --short\` and inspect the bootstrap result output.

### Next Action

Review scaffold files before adding application code.
EOF
fi

if command -v tree >/dev/null 2>&1; then
  TREE_OUTPUT="$(tree -a -L 3 -I '.git')"
else
  TREE_OUTPUT="$(find . -maxdepth 3 -not -path './.git*' | sort | sed 's#^./##')"
fi

if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  GIT_STATUS="$(git status --short)"
  [[ -n "$GIT_STATUS" ]] || GIT_STATUS="Working tree clean."
else
  GIT_STATUS="Git status unavailable."
fi

printf '# Bootstrap Result\n\n'
printf '## Observations\n\n'
printf -- '- Target directory: `%s`\n' "$TARGET_ABS"
printf -- '- Git state: %s\n' "$GIT_STATE"
printf -- '- Existing files were preserved. Missing scaffold files were created.\n\n'

printf '## Actions Taken\n\n'
printf -- '- Created or verified project control files.\n'
printf -- '- Created or verified documentation, governance, records, artifacts, source, test, and tool directories.\n'
printf -- '- Created or verified session boot, resume, closeout, and tracking procedures.\n'
printf -- '- Ran Git initialization check.\n\n'

printf '## Files Created\n\n'
if (( ${#CREATED_FILES[@]} == 0 )); then
  printf -- '- None.\n'
else
  printf -- '- %s\n' "${CREATED_FILES[@]}"
fi
printf '\n'

printf '## Files Preserved\n\n'
if (( ${#PRESERVED_FILES[@]} == 0 )); then
  printf -- '- None.\n'
else
  printf -- '- %s\n' "${PRESERVED_FILES[@]}"
fi
printf '\n'

printf '## Git Status\n\n```text\n%s\n```\n\n' "$GIT_STATUS"
printf '## Directory Tree Depth 3\n\n```text\n%s\n```\n\n' "$TREE_OUTPUT"

printf '## Assumptions\n\n'
if (( ${#ASSUMPTIONS[@]} == 0 )); then
  printf -- '- The current directory or supplied target directory is the intended repository root.\n'
  printf -- '- Existing files are user-created and should be preserved.\n'
else
  printf -- '- %s\n' "${ASSUMPTIONS[@]}"
fi
printf '\n'

printf '## Next Safe Action\n\n'
printf 'Review `SESSION_STATE.md`, `records/session_boot/SESSION_BOOT.md`, and `git status` before adding phase governing documents or application code.\n'

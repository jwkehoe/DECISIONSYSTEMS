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

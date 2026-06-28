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
  cat <<'EOF'
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
EOF
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

cat >> "$ROOT_DIR/FLIGHT_RECORDER.md" <<EOF

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
EOF

if [[ -n "$project_state" || -n "$project_focus" || -n "$risk" ]]; then
  project_status_file="$(mktemp)"
  cat > "$project_status_file" <<EOF
### Timestamp

$NOW_LOCAL

### Current State

${project_state:-No project state update provided.}

### Active Focus

${project_focus:-No focus update provided.}

### Risks

${risk:-No new risks recorded.}
EOF
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

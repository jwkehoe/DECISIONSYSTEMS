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

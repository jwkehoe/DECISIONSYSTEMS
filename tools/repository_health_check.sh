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

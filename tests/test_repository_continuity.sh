#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    fail "$label -- expected to find: $needle"
  fi
}

run_check() {
  local description="$1"
  shift
  local output
  if ! output="$("$@" 2>&1)"; then
    printf '%s\n' "$output" >&2
    fail "$description command failed"
  fi
  printf '%s' "$output"
}

session_output="$(run_check "session open" "$ROOT_DIR/tools/session/open_session.sh")"
assert_contains "$session_output" "# Session Open Summary" "session open header"
assert_contains "$session_output" "## Current Project State" "session open current state section"
assert_contains "$session_output" "## Active Work" "session open active work section"
assert_contains "$session_output" "REPO-004" "session open active repo task"
assert_contains "$session_output" "## Execution Plan" "session open execution plan section"

validation_output="$(run_check "repository validation" "$ROOT_DIR/tools/validate_repository.sh")"
assert_contains "$validation_output" "# Repository Validation" "validation header"
assert_contains "$validation_output" "Repository validation passed." "validation success message"
assert_contains "$validation_output" "OK file: SESSION_STATE.md" "validation checks session state"

health_output="$(run_check "repository health check" "$ROOT_DIR/tools/repository_health_check.sh")"
assert_contains "$health_output" "# Repository Health Check" "health check header"
assert_contains "$health_output" "Validation: pass" "health check validation pass"
assert_contains "$health_output" "Known drift references:" "health check drift section"
assert_contains "$health_output" "none" "health check drift clean result"

printf 'PASS: repository continuity smoke tests\n'

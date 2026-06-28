#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_file_contains() {
  local file="$1"
  local needle="$2"
  local label="$3"
  if ! grep -Fq "$needle" "$file"; then
    fail "$label -- expected to find: $needle"
  fi
}

mkdir -p "$TMP_DIR/src/sample" "$TMP_DIR/tests"
cat > "$TMP_DIR/README.md" <<'EOF'
# Sample Repo

## Purpose

Sample repository used to prove repo scan and reconstructed PRD generation.
EOF
cat > "$TMP_DIR/pyproject.toml" <<'EOF'
[project]
name = "sample-repo"
version = "0.1.0"
EOF
cat > "$TMP_DIR/src/sample/app.py" <<'EOF'
def main():
    return "hello"
EOF
cat > "$TMP_DIR/tests/test_app.py" <<'EOF'
def test_placeholder():
    assert True
EOF

SCAN_OUT="$TMP_DIR/scan.json"
PRD_OUT="$TMP_DIR/RECONSTRUCTED_PRD.md"

python3 -m src.dsw repo scan --path "$TMP_DIR" --out "$SCAN_OUT" >/dev/null
python3 -m src.dsw repo prd --path "$TMP_DIR" --out "$PRD_OUT" >/dev/null

assert_file_contains "$SCAN_OUT" "\"repository_name\": \"" "scan repository name"
assert_file_contains "$SCAN_OUT" "\"config_files\": [" "scan config files"
assert_file_contains "$PRD_OUT" "# Reconstructed PRD" "prd title"
assert_file_contains "$PRD_OUT" "## Functional Requirements" "prd requirements section"
assert_file_contains "$PRD_OUT" "Sample repository used to prove repo scan and reconstructed PRD generation." "prd purpose capture"

printf 'PASS: repo scan and PRD CLI smoke test\n'

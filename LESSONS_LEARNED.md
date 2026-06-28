# Lessons Learned — Decision Architecting System Bootstrap

## Context

A repository bootstrap script was built to implement the Decision Architecting System project structure. The script evolved from a minimal housekeeping initializer into a full project scaffold generator covering Git, governance files, phase documents, session boot files, memory files, documentation, change tracking, and validation scripts.

The work surfaced several practical lessons about shell scripting, LLM-agent workflows, durable project state, and token-efficient engineering operations.

---

## 1. Treat scripts as executable infrastructure, not text artifacts

### Observation

The first script versions looked correct as static text but failed when executed because Markdown content embedded inside Bash strings was interpreted by the shell.

The specific failure mode was Markdown backticks inside double-quoted Bash strings. Bash treated those backticks as command substitution.

### Inference

A script that writes Markdown, prompts, or documentation is not merely storing text. It is crossing an execution boundary. Anything interpreted by the shell can become behavior.

### Rule

Use single-quoted heredocs for static generated content:

```bash
cat > "$file" <<'MARKDOWN_EOF'
Markdown content with `backticks`, $variables, and $(commands)
MARKDOWN_EOF
```

Do not use unquoted heredocs or double-quoted string blocks for Markdown-heavy generated files unless interpolation is explicitly required.

---

## 2. Test by execution, not inspection

### Observation

The script appeared reasonable before execution. The real bugs only appeared when the script was run against a clean test repository.

### Inference

For bootstrap scripts, syntax review is insufficient. The output filesystem is the evidence.

### Rule

Every scaffold script should be tested with at least:

```bash
bash -n script.sh
rm -rf /tmp/test_repo
./script.sh /tmp/test_repo
./script.sh /tmp/test_repo
find /tmp/test_repo -maxdepth 3 -type d | sort
find /tmp/test_repo -maxdepth 3 -type f | sort
```

The second execution matters. It tests idempotency.

---

## 3. Idempotency is not optional

### Observation

The script needed to be safe to rerun without duplicating content, overwriting user edits, or reinitializing Git incorrectly.

### Inference

LLM-assisted projects will rerun setup and repair scripts often. Non-idempotent scripts create uncertainty and erode trust.

### Rule

Project bootstrap scripts must preserve existing files by default and append only when a marker is absent.

Required primitives:

```bash
ensure_dir
write_file_if_missing
append_once
record_created_file
record_preserved_file
```

Avoid unconditional writes except for generated reports explicitly marked as disposable.

---

## 4. Separate human-readable state from machine-readable state

### Observation

The project needs Markdown files for human and LLM continuity, but future automation should not scrape Markdown whenever avoidable.

### Inference

Markdown is good for cognition. JSON/YAML is better for automation.

### Rule

Use both:

Human / LLM state:

```text
README.md
TODO.md
SESSION_STATE.md
FLIGHT_RECORDER.md
CHANGELOG.md
LESSONS_LEARNED.md
```

Machine-readable state:

```text
MEMORY/PROJECT_STATE.json
MEMORY/DECISION_HISTORY.json
MEMORY/MODEL_REGISTRY.json
MEMORY/SESSION_INDEX.json
```

Do not force automation to infer structure from prose if a stable schema can exist.

---

## 5. Governance is not documentation

### Observation

The phase files and project instructions are foundational operating rules, not ordinary documentation.

### Inference

Burying governing documents under `docs/` makes them easier to ignore and harder for agents to locate consistently.

### Rule

Use top-level governance directories:

```text
GOVERNANCE/
PHASES/
BOOT/
```

Use `docs/` for explanatory and reference material, not constitutional project control files.

---

## 6. Session boot must be aggressive and small

### Observation

The user wants token efficiency across any agent or chat session. Reading the whole repository at startup defeats the purpose.

### Inference

A good agent boot sequence should constrain context before work begins.

### Rule

Agents should start by reading only:

1. `BOOT/SESSION_BOOT.md`
2. `SESSION_STATE.md`
3. `TODO.md`
4. Recent relevant entries from `FLIGHT_RECORDER.md`
5. The phase file relevant to the task

Do not read the entire repository unless the task specifically requires broad archaeology.

---

## 7. Restart points should be explicit

### Observation

Long LLM sessions drift. The project needs a formal restart strategy, not an improvised “we should reset soon.”

### Inference

Session control is part of system design.

### Rule

Recommend restart or context compaction when any of these occur:

- The session crosses a major implementation boundary.
- More than three files are materially changed.
- A bug is fixed after multiple failed attempts.
- The agent changes architecture assumptions.
- The conversation starts relying on memory instead of artifacts.
- The next task requires a different phase context.

Before restart, update:

```text
SESSION_STATE.md
TODO.md
FLIGHT_RECORDER.md
CHANGELOG.md, if user-visible behavior changed
LESSONS_LEARNED.md, if a reusable lesson emerged
```

---

## 8. Flight recorder should capture evidence, not narrative fog

### Observation

The project requires automatic tracking, but a verbose log becomes useless quickly.

### Inference

The flight recorder should record decision-grade evidence: what changed, why, and what files were affected.

### Rule

Each flight recorder entry should include:

```text
Timestamp
Actor
Action
Files changed
Reason
Validation performed
Next recommended action
```

Avoid chatty summaries. The flight recorder is an engineering trace, not a diary.

---

## 9. Changelog and flight recorder serve different audiences

### Observation

The user asked for both change tracking and a preferred documentation/change-log structure.

### Inference

A single log cannot serve both engineering traceability and user-facing history well.

### Rule

Use:

```text
FLIGHT_RECORDER.md   # internal engineering trace
CHANGELOG.md         # user-visible/release-level changes
```

Do not put every file creation in the changelog. Do record scaffold creation, validation behavior, and visible operational changes.

---

## 10. Validate the scaffold itself

### Observation

A generated repository can look complete while missing critical directories or control files.

### Inference

The bootstrap script should create validation support as part of the scaffold.

### Rule

Include a validation script such as:

```text
scripts/maintenance/validate_project.sh
```

Validation should check for required directories, required control files, Git state, and expected phase files.

---

## 11. Prefer boring shell over clever shell

### Observation

The script’s job is repository initialization, not shell wizardry.

### Inference

Clever Bash increases failure risk and makes future LLM modification harder.

### Rule

Use simple Bash:

```bash
set -euo pipefail
arrays for path lists
small functions
quoted variables
single-quoted heredocs
explicit status output
```

Avoid complex sed/awk transformations unless there is a strong reason.

---

## 12. Generated scaffolds should encode the architecture

### Observation

The initial script created housekeeping files but did not reflect the full architecture discussed afterward.

### Inference

A bootstrap script is not just convenience. It is executable architecture.

### Rule

The scaffold should encode the project’s conceptual boundaries:

```text
GOVERNANCE/      project rules
PHASES/          governing phase architecture
BOOT/            session startup/shutdown rules
MEMORY/          machine-readable continuity
scripts/         automation
docs/            explanatory documentation
design/          design work
artifacts/       durable outputs
schemas/         structured contracts
prompts/         reusable agent prompts
evaluations/     tests and evaluation outputs
decisions/       decision records
records/         operational records
src/             implementation
tests/           test code
tools/           local utilities
```

If the scaffold does not express the architecture, agents will invent inconsistent structure later.

---

## 13. Non-destructive behavior should be the default

### Observation

The user explicitly values human approval for destructive or irreversible actions.

### Inference

Bootstrap and maintenance scripts must default to preservation.

### Rule

Never overwrite existing files unless a flag explicitly says to do so.

Potential future flags:

```bash
--force
--backup-then-overwrite
--dry-run
--no-git
--quiet
```

Default behavior should be safe enough to run inside a live repository.

---

## 14. The repo needs a current-truth file

### Observation

The user wants continuity across agents and sessions.

### Inference

Without a short current-state file, every new session burns tokens rediscovering the same context.

### Rule

`SESSION_STATE.md` should be treated as the current truth for the next agent. It should be compact, current, and aggressively updated.

It should answer:

```text
What is the current objective?
What changed recently?
What files matter right now?
What is blocked?
What should the next agent do first?
What should the next agent avoid doing?
```

---

## 15. Add lessons learned to the standard structure

### Observation

The current scaffold did not explicitly include a lessons-learned artifact.

### Inference

Lessons learned are a reusable decision-quality asset and should not be buried in chat history.

### Recommendation

Add:

```text
LESSONS_LEARNED.md
records/lessons_learned/
```

For larger projects, promote recurring lessons into governance rules after review.

---

## Recommended Script Changes

Update `bootstrap_decision_system_v2.sh` to add:

```text
LESSONS_LEARNED.md
records/lessons_learned/
```

Update `README.md` active control files section to include:

```text
- Lessons learned: `LESSONS_LEARNED.md`
```

Update `BOOT/SESSION_SHUTDOWN.md` to require recording lessons when:

- A bug was discovered and fixed.
- A wrong assumption was corrected.
- A design decision was reversed.
- A reusable pattern emerged.

---

## Compact Operating Rule

For future agents:

> Do not trust generated scripts until executed twice: once on a clean target and once on the same target. Preserve existing files. Quote heredocs. Record evidence. Update session state. Restart before context drift turns into architectural drift.

## 2026-06-28 13:17 CDT

- Health checks should scan active guidance, not archival lessons, or they will report historical references as live drift.

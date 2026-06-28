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

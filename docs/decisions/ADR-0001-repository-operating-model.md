# ADR-0001: Repository Operating Model

## Status

Accepted

## Date

2026-06-28

## Context

The repository needed an operating model before implementation work could start safely.

Without an explicit model, the likely failure modes were:

- session state drifting across interruptions
- decisions living in chat instead of the repo
- setup guidance, bootstrap output, and validation rules diverging
- implementation starting before the project had reliable restart surfaces

The project also has an unusually strong requirement for evidence-backed reasoning and recoverability across LLM sessions.

## Decision

Adopt a local-first repository operating model with these characteristics:

- docs-as-code control surfaces
- append-oriented flight-recorder history
- Bash-based session continuity tooling
- ADR-style decision capture
- CLI-first implementation bias
- small reversible changes over broad speculative build-out

The repository control plane is:

- `SESSION_STATE.md`
- `TODO.md`
- `PROJECT_STATUS.md`
- `FLIGHT_RECORDER.md`
- `CHANGELOG.md`
- `LESSONS_LEARNED.md`

## Consequences

## Positive

- interrupted sessions are easier to resume
- repo state is inspectable without hidden tooling
- future implementation has a clear operational frame
- validation and health checks can detect control-plane drift early

## Negative

- more discipline is required to keep state files current
- some work feels slower at the start because the repo records what happened
- the project can accumulate documentation before code if scope is not controlled

## Rejected Alternatives

## Chat-Only Working Memory

Rejected because it creates unrecoverable state and forces each session to rediscover prior decisions.

## Code-First Without Continuity Layer

Rejected because this project’s core value is decision quality under uncertainty, and hidden state directly undermines that.

## GUI-First Project Shell

Rejected because it would expand scope before the CLI, artifact flow, and evidence model are proven.

## Follow-On Implications

- The next useful work should be substantive docs and records, then the first CLI slice.
- Significant changes to operating behavior should be reflected in both ADRs and control files.
- Tooling that produces repo noise or false health signals should be treated as a defect.

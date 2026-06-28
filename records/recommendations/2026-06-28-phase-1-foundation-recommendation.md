# Phase 1 Foundation Recommendation

## Date

2026-06-28

## Recommendation

Build the smallest useful Phase 1 CLI slice next, and keep it tied to one artifact-producing path from scan to markdown output.

## Preferred Sequence

1. Add lightweight tests for repository continuity tooling.
2. Choose one first implementation slice:
   - model inventory scan, or
   - repository scan plus one markdown exporter
3. Implement the slice in `src/`.
4. Add tests that exercise the slice end to end.

## Rationale

- The repo now has enough operating structure to support real implementation work.
- A small executable slice will test whether the continuity model, docs, and requirements are actually useful.
- Starting with one bounded path controls scope and avoids platform theater.

## Trade-Offs

- Moving to code now reduces further ambiguity but will surface real technical decisions sooner.
- Adding tests first slows visible feature progress slightly, but it lowers the chance that continuity tooling regresses while implementation begins.

## Not Recommended

- Expanding documentation broadly without an implementation decision
- Starting multiple Phase 1 feature tracks at once
- Introducing GUI or cloud-first work before the CLI foundation is proven

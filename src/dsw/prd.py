from __future__ import annotations

from pathlib import Path

from .repo_scan import scan_repository


def _list_or_none(items: list[str], limit: int = 8) -> str:
    if not items:
        return "- None observed from the current scan."
    return "\n".join(f"- `{item}`" for item in items[:limit])


def render_prd_markdown(repo_path: str | Path) -> str:
    scan = scan_repository(repo_path)
    languages = ", ".join(scan["languages"].keys()) or "Unknown"
    top_dirs = ", ".join(scan["top_level_dirs"]) or "Unknown"
    commands = scan["command_hints"]
    command_text = _list_or_none(commands, limit=6)

    functional_requirements = [
        "The system must scan a target repository and capture structural evidence including files, language mix, configuration surfaces, and documentation surfaces.",
        "The system must generate durable Markdown artifacts from repository evidence rather than chat-only summaries.",
        "The system must preserve explicit current state, active work, and change evidence to support interrupted-session recovery.",
    ]
    if commands:
        functional_requirements.append(
            "The system must expose a local CLI for repository scan and archaeology artifact generation."
        )

    acceptance_criteria = [
        "A local operator can point the tool at a repository directory and receive a reproducible evidence summary.",
        "A local operator can export a Markdown PRD draft grounded in repository files rather than unsupported narrative.",
        "The repository continuity layer remains inspectable and restartable from repo artifacts alone.",
    ]

    return f"""# Reconstructed PRD

## Source

- Repository path: `{scan["repository_path"]}`
- Repository name: `{scan["repository_name"]}`
- File count observed: {scan["file_count"]}

## Vision

Build a local-first engineering workbench that turns an as-built repository into durable decision artifacts rather than one-off analysis.

## Product Goal

{scan["product_purpose_hint"] or "No explicit purpose section was detected, so this goal is inferred from repository structure and naming."}

## Users

- Engineers trying to understand an existing codebase
- Architects reconstructing intent from implementation
- Operators who need deterministic restart surfaces across interrupted sessions

## Core Workflows

- Scan a repository and inventory its structural evidence
- Recover likely purpose, architecture, and requirements from as-built artifacts
- Export durable Markdown outputs such as PRD drafts and project DNA reports
- Resume interrupted analysis work from repository state rather than hidden context

## Functional Requirements

{chr(10).join(f"{index}. {item}" for index, item in enumerate(functional_requirements, start=1))}

## Non-Functional Requirements

- Local-first operation with no required cloud dependency
- Reproducible outputs from the same repository inputs
- Inspectable evidence trail in repository artifacts
- Reversible implementation slices with low blast radius

## Acceptance Criteria

{chr(10).join(f"- {item}" for item in acceptance_criteria)}

## Constraints

- Primary implementation surface appears to be organized under: {top_dirs}
- Language mix observed: {languages}
- Config surfaces observed:
{_list_or_none(scan["config_files"])}

## Assumptions

- The current repository structure is meaningful evidence of intended system boundaries.
- Markdown documents and governance files represent higher-confidence intent than file naming alone.
- Missing implementation files indicate unfinished scope rather than hidden runtime behavior.

## Evidence

### Documentation Surfaces

{_list_or_none(scan["documentation_files"])}

### Test Surfaces

{_list_or_none(scan["test_files"])}

### CLI or Command Hints

{command_text}

## Confidence

- Overall PRD confidence: 0.55
- Reason: the draft is grounded in repository structure and explicit documents, but it remains an as-built inference rather than an original authored PRD.

## Alternative Explanations

- The repository may currently over-represent operating-model and documentation work because implementation is intentionally staged later.
- Some intended product behavior may exist only in future plans and not yet in source code.

## Risk If Wrong

- Product scope may appear narrower than intended if future implementation plans are not yet represented in code.
- Early-phase scaffolding can overweight process requirements relative to user-facing capability.
"""

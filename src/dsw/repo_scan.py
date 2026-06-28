from __future__ import annotations

import json
from collections import Counter
from pathlib import Path
from typing import Any


EXTENSION_LANGUAGE_MAP = {
    ".py": "Python",
    ".js": "JavaScript",
    ".ts": "TypeScript",
    ".tsx": "TypeScript",
    ".jsx": "JavaScript",
    ".rs": "Rust",
    ".go": "Go",
    ".java": "Java",
    ".rb": "Ruby",
    ".php": "PHP",
    ".sh": "Shell",
    ".zsh": "Shell",
    ".bash": "Shell",
    ".sql": "SQL",
    ".html": "HTML",
    ".css": "CSS",
    ".md": "Markdown",
    ".json": "JSON",
    ".yaml": "YAML",
    ".yml": "YAML",
    ".toml": "TOML",
}

CONFIG_NAMES = {
    "pyproject.toml",
    "package.json",
    "package-lock.json",
    "requirements.txt",
    "poetry.lock",
    "Cargo.toml",
    "Cargo.lock",
    "go.mod",
    "go.sum",
    "Dockerfile",
    "docker-compose.yml",
    "docker-compose.yaml",
    "Makefile",
    "Procfile",
}

DOC_NAMES = {
    "README.md",
    "CHANGELOG.md",
    "SESSION_STATE.md",
    "PROJECT_STATUS.md",
    "TODO.md",
}


def _is_hidden_path(path: Path) -> bool:
    return any(part.startswith(".") and part != "." for part in path.parts)


def _iter_files(root: Path) -> list[Path]:
    files: list[Path] = []
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        rel = path.relative_to(root)
        if ".git" in rel.parts:
            continue
        if _is_hidden_path(rel) and rel.name != ".env.example":
            continue
        files.append(path)
    return sorted(files)


def _safe_read_text(path: Path, limit: int = 12000) -> str:
    try:
        return path.read_text(encoding="utf-8")[:limit]
    except (UnicodeDecodeError, OSError):
        return ""


def _extract_heading_section(markdown: str, heading: str) -> str:
    lines = markdown.splitlines()
    in_section = False
    collected: list[str] = []
    for line in lines:
        if line.strip() == heading:
            in_section = True
            continue
        if in_section and line.startswith("## "):
            break
        if in_section:
            collected.append(line)
    return "\n".join(collected).strip()


def _top_level_dirs(root: Path, files: list[Path]) -> list[str]:
    counter: Counter[str] = Counter()
    for path in files:
        rel = path.relative_to(root)
        head = rel.parts[0] if len(rel.parts) > 1 else "."
        counter[head] += 1
    return [name for name, _count in counter.most_common(8)]


def scan_repository(path: str | Path) -> dict[str, Any]:
    root = Path(path).expanduser().resolve()
    if not root.exists():
        raise FileNotFoundError(f"Repository path does not exist: {root}")
    if not root.is_dir():
        raise NotADirectoryError(f"Repository path is not a directory: {root}")

    files = _iter_files(root)
    rel_files = [str(file.relative_to(root)) for file in files]
    language_counter: Counter[str] = Counter()
    config_files: list[str] = []
    doc_files: list[str] = []
    test_files: list[str] = []
    ci_files: list[str] = []

    for file in files:
        rel = file.relative_to(root)
        suffix = file.suffix.lower()
        if suffix in EXTENSION_LANGUAGE_MAP:
            language_counter[EXTENSION_LANGUAGE_MAP[suffix]] += 1
        if file.name in CONFIG_NAMES:
            config_files.append(str(rel))
        if file.name in DOC_NAMES or "docs" in rel.parts or rel.suffix.lower() == ".md":
            doc_files.append(str(rel))
        if "tests" in rel.parts or file.name.startswith("test_"):
            test_files.append(str(rel))
        if ".github" in rel.parts or "workflows" in rel.parts:
            ci_files.append(str(rel))

    readme_path = root / "README.md"
    readme_text = _safe_read_text(readme_path)
    purpose_text = _extract_heading_section(readme_text, "## Purpose")
    core_text = _extract_heading_section(readme_text, "## Core Principle")

    governance_hint = ""
    governance_path = root / "governance" / "Decision_Systems_Workbench-Phase_1.md"
    if governance_path.exists():
        governance_hint = _safe_read_text(governance_path, limit=8000)

    repo_name = root.name
    product_purpose = purpose_text or f"Repository-local system centered on {repo_name}."
    domain_guess = "Software engineering decision support"
    if "customer" in readme_text.lower():
        domain_guess = "Customer-facing software platform"
    elif "decision" in (readme_text + governance_hint).lower():
        domain_guess = "Engineering decision systems"

    command_hints: list[str] = []
    for line in governance_hint.splitlines():
        stripped = line.strip()
        if stripped.startswith("dsw "):
            command_hints.append(stripped)

    return {
        "repository_name": repo_name,
        "repository_path": str(root),
        "file_count": len(files),
        "top_level_dirs": _top_level_dirs(root, files),
        "languages": dict(language_counter.most_common()),
        "config_files": config_files,
        "documentation_files": doc_files[:30],
        "test_files": test_files[:30],
        "ci_files": ci_files[:20],
        "command_hints": command_hints[:20],
        "product_purpose_hint": product_purpose,
        "core_principle_hint": core_text,
        "domain_guess": domain_guess,
        "sample_files": rel_files[:40],
    }


def scan_to_json(path: str | Path) -> str:
    return json.dumps(scan_repository(path), indent=2)

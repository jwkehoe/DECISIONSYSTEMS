from __future__ import annotations

import argparse
from pathlib import Path

from .prd import render_prd_markdown
from .repo_scan import scan_to_json


def _write_or_print(content: str, output_path: str | None) -> None:
    if output_path:
        path = Path(output_path).expanduser()
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
        print(path)
    else:
        print(content)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="dsw", description="Decision Systems Workbench Phase 1 CLI")
    subparsers = parser.add_subparsers(dest="command", required=True)

    repo_parser = subparsers.add_parser("repo", help="Repository archaeology commands")
    repo_subparsers = repo_parser.add_subparsers(dest="repo_command", required=True)

    scan_parser = repo_subparsers.add_parser("scan", help="Scan a repository and emit evidence summary JSON")
    scan_parser.add_argument("--path", required=True, help="Path to the target repository")
    scan_parser.add_argument("--out", help="Optional path to write JSON output")

    prd_parser = repo_subparsers.add_parser("prd", help="Generate a reconstructed PRD markdown artifact")
    prd_parser.add_argument("--path", required=True, help="Path to the target repository")
    prd_parser.add_argument("--out", help="Optional path to write Markdown output")

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.command == "repo" and args.repo_command == "scan":
        _write_or_print(scan_to_json(args.path), args.out)
        return 0

    if args.command == "repo" and args.repo_command == "prd":
        _write_or_print(render_prd_markdown(args.path), args.out)
        return 0

    parser.error("Unsupported command")
    return 2

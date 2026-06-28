# Decision Systems Workbench -- Phase 1

## Mission

Decision Systems Workbench is a local-first AI engineering platform for
cataloging LLMs, benchmarking them against real engineering tasks,
routing work to the best model or model team, and reverse engineering
existing codebases into durable engineering artifacts.

The governing principle is:

> The objective is not to generate answers. The objective is to improve
> decision quality under uncertainty.

------------------------------------------------------------------------

# Core Capabilities

## LLM Mega Matrix

Catalog every available model.

Track:

-   Model name
-   Provider
-   Local path
-   Quantization
-   Parameter count
-   Context window
-   Disk footprint
-   RAM / VRAM requirement
-   Speed
-   Strengths
-   Weaknesses
-   Failure modes
-   Preferred prompt style
-   Best-use routing category
-   Benchmark history

## Model Benchmark Harness

Benchmark models against **John Bench** using real engineering tasks.

Initial benchmark categories:

-   Code understanding
-   Repository summarization
-   Bug finding
-   Architecture reconstruction
-   PRD reconstruction
-   SQL reasoning
-   Python repair
-   JSON reliability
-   Security review
-   Technical writing
-   Adversarial critique
-   Long-context degradation

## Routing Engine

Given a task, determine:

-   Best primary model
-   Reviewer model
-   Summarizer
-   JSON validator
-   Local vs. cloud execution
-   Confidence and rationale

## Software Archaeology Engine

Generate:

-   Executive Summary
-   Architecture Reconstruction
-   Business Purpose
-   Domain Model
-   Technology Stack
-   Dependency Map
-   Database Model
-   API Map
-   Security Review
-   Technical Debt Report
-   Missing Documentation
-   Reconstructed PRD
-   Modernization Roadmap
-   Project DNA

## Decision Systems Layer

Every recommendation captures:

-   Evidence
-   Assumptions
-   Alternatives
-   Confidence
-   Uncertainty
-   Conflicting evidence
-   Recommended next action

------------------------------------------------------------------------

# Chief Decision Systems Architect

This role governs the reasoning process rather than implementation.

Responsibilities include:

-   Decision architecture
-   Evidence engineering
-   Causal analysis
-   Decision reconstruction
-   Adversarial review
-   Knowledge integration
-   Software archaeology
-   AI governance
-   Continuous learning

Primary deliverables:

-   Decision Architecture Document
-   Evidence Graph
-   Assumption Register
-   Constraint Register
-   Decision Timeline
-   Project DNA
-   Reconstructed PRD
-   Modernization Roadmap

------------------------------------------------------------------------

# Phase 1 MVP

Deliver a working CLI capable of:

1.  Scanning a local LLM model tree.
2.  Building the LLM Mega Matrix.
3.  Scanning a Git repository.
4.  Producing PROJECT_DNA.md.
5.  Producing RECONSTRUCTED_PRD.md.

No GUI.

CLI first.

------------------------------------------------------------------------

# Repository Layout

``` text
decision-systems-workbench/
├── dsw/
│   ├── cli.py
│   ├── models/
│   ├── repo_scan/
│   ├── archaeology/
│   ├── routing/
│   ├── benchmarks/
│   ├── agents/
│   ├── storage/
│   └── templates/
├── tests/
├── examples/
├── data/
└── runs/
```

------------------------------------------------------------------------

# Initial Database

Tables:

-   models
-   model_capabilities
-   model_benchmarks
-   repo_scans
-   repo_files
-   evidence_items
-   reconstructed_requirements

------------------------------------------------------------------------

# CLI

``` bash
dsw models scan --path <model_root>
dsw models list
dsw models show <model_id>

dsw repo scan --path <repo>
dsw repo dna --run <run_id>

dsw repo prd --run <run_id>

dsw bench run --model <model> --suite <suite>

dsw route "<task>"

dsw agents team software-archaeology --repo ./repo
```

------------------------------------------------------------------------

# Sprint 1

Build:

-   Python package
-   Typer CLI
-   SQLite storage
-   Model scanner
-   Repository scanner
-   Markdown exporters
-   Unit tests

Do **not** build:

-   GUI
-   Cloud orchestration
-   Multi-agent execution
-   Vector search

------------------------------------------------------------------------

# Recommended Stack

-   Python 3.11+
-   Typer
-   Rich
-   SQLite
-   Jinja2
-   pytest

Future:

-   DuckDB
-   PostgreSQL
-   pgvector
-   NetworkX
-   FastAPI
-   Textual

------------------------------------------------------------------------

# Strategic Goal

Create a local-first engineering intelligence platform that can:

-   Recover system intent
-   Preserve engineering decisions
-   Benchmark AI models
-   Route work intelligently
-   Challenge conclusions
-   Generate durable engineering artifacts
-   Improve future engineering decisions

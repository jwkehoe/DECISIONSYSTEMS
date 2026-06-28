# Decision Systems Workbench -- Phase 3

# Software Archaeology

Version: 0.1

## Mission

Software Archaeology reconstructs **intent**, not merely implementation.

Core principle:

> Treat source code as evidence, not truth.

Every conclusion must identify:

  Field                      Required
  -------------------------- ----------
  Evidence                   Yes
  Confidence                 Yes
  Alternative explanations   Yes
  Risk if wrong              Yes

------------------------------------------------------------------------

# Objectives

  Objective                  Description
  -------------------------- ------------------------------------
  Repository Understanding   Recover purpose and architecture
  Project DNA                Produce durable engineering memory
  PRD Reconstruction         Infer original requirements
  ADR Reconstruction         Infer architectural decisions
  Decision Timeline          Recover evolution of the system
  Business Rules             Extract hidden domain logic
  Modernization              Recommend future architecture

------------------------------------------------------------------------

# Archaeology Pipeline

``` text
Repository
    ↓
Inventory
    ↓
Static Analysis
    ↓
Semantic Graph
    ↓
Evidence Graph
    ↓
Inference Engine
    ↓
Decision Systems Review
    ↓
Artifacts
```

------------------------------------------------------------------------

# Repository Discovery

  Stage                  Output
  ---------------------- ----------------------------
  File inventory         All source files
  Language detection     Python, JS, Rust, etc.
  Framework detection    Django, FastAPI, React...
  Dependency graph       Package relationships
  Build discovery        Make, Maven, npm, Cargo...
  Test discovery         Unit/integration tests
  CI/CD discovery        GitHub Actions, Jenkins...
  Deployment discovery   Docker, K8s, Terraform

------------------------------------------------------------------------

# Evidence Types

  Type            Examples
  --------------- --------------------------
  Source Code     Classes, functions
  Configuration   YAML, JSON, TOML
  Build Files     pyproject, package.json
  Tests           Unit/integration
  Git Metadata    Commit history
  Documentation   README, ADRs
  Database        Migrations, schemas
  Runtime         Logs, metrics (optional)

------------------------------------------------------------------------

# Confidence Scale

      Score Meaning
  --------- --------------------
    0.0-0.2 Speculation
    0.2-0.4 Weak inference
    0.4-0.6 Probable
    0.6-0.8 Strong evidence
    0.8-1.0 Directly supported

------------------------------------------------------------------------

# Evidence Record

  Field              Description
  ------------------ --------------------------
  Claim              Inference
  Evidence           Supporting files
  Confidence         Numeric
  Counter Evidence   Conflicting observations
  Reviewer           Human/Model

------------------------------------------------------------------------

# Project DNA Specification

## Required Sections

  Section             Purpose
  ------------------- ---------------------
  Executive Summary   One-page overview
  Product Purpose     Why it exists
  Domain              Business domain
  Architecture        C4 summary
  Components          Major modules
  Data Model          Entities
  APIs                External interfaces
  Build               Build instructions
  Test                Test strategy
  Risks               Known risks
  Technical Debt      Priority list
  Unknowns            Gaps
  Future Work         Opportunities

Output:

    PROJECT_DNA.md

------------------------------------------------------------------------

# PRD Reconstruction

Infer:

  Category                  Deliverable
  ------------------------- -----------------------
  Vision                    Product goal
  Users                     Personas
  Workflows                 Core journeys
  Functional Requirements   Numbered requirements
  Non-functional            Performance, security
  Acceptance Criteria       Testable outcomes
  Constraints               Technical/business
  Assumptions               Hidden assumptions
  Confidence                Per requirement

Output:

    RECONSTRUCTED_PRD.md

------------------------------------------------------------------------

# ADR Reconstruction

Generate inferred Architecture Decision Records.

  ADR Field      Description
  -------------- ---------------------
  Decision       Chosen architecture
  Context        Why needed
  Alternatives   Plausible options
  Consequences   Tradeoffs
  Evidence       Supporting code
  Confidence     Numeric

Output:

    ADR_0001.md
    ADR_0002.md
    ...

------------------------------------------------------------------------

# Decision Timeline

Recover evolution.

  Signal              Meaning
  ------------------- ---------------------
  Deprecated code     Previous design
  Migration scripts   Schema evolution
  TODO clusters       Planned work
  Feature flags       Incremental rollout
  Git commits         Design evolution

Output:

    DECISION_TIMELINE.md

------------------------------------------------------------------------

# Business Rule Recovery

Extract hidden business logic.

Examples:

-   Validation rules
-   State machines
-   Permission rules
-   Pricing rules
-   Workflow sequencing

Each rule includes:

  Field        Required
  ------------ ----------
  Rule         Yes
  Evidence     Yes
  Confidence   Yes

------------------------------------------------------------------------

# Technical Debt Taxonomy

  Category        Examples
  --------------- --------------------
  Architecture    Layer violations
  Code            Duplication
  Testing         Missing coverage
  Security        Hardcoded secrets
  Performance     N+1, blocking IO
  Documentation   Missing README
  Operations      Weak observability

Priority:

Critical / High / Medium / Low

------------------------------------------------------------------------

# Security Archaeology

Recover:

  Area               Deliverable
  ------------------ -------------------
  Authentication     Mechanism
  Authorization      Role model
  Secrets            Secret locations
  Trust Boundaries   External/internal
  Threat Model       Inferred threats

------------------------------------------------------------------------

# Modernization Report

Recommend:

  Area               Recommendation
  ------------------ -----------------------
  Framework          Upgrade/replace
  Database           Improve schema
  API                Versioning
  AI Opportunities   RAG, agents
  Testing            Coverage improvements

Output:

    MODERNIZATION_REPORT.md

------------------------------------------------------------------------

# Agent Roles

  Role                               Responsibility
  ---------------------------------- ---------------------------
  Chief Decision Systems Architect   Governs reasoning
  Software Archaeologist             Repository reconstruction
  Enterprise Architect               Architecture
  Security Architect                 Threat model
  Performance Engineer               Bottlenecks
  Technical Writer                   Final artifacts

------------------------------------------------------------------------

# CLI

``` bash
dsw repo scan --path ./repo

dsw repo dna --run scan001

dsw repo prd --run scan001

dsw repo adr --run scan001

dsw repo timeline --run scan001

dsw repo debt --run scan001

dsw repo modernization --run scan001

dsw repo archaeology --run scan001
```

------------------------------------------------------------------------

# SQLite Tables

  Table
  -----------------------
  repo_scans
  repo_files
  evidence_items
  inferred_requirements
  inferred_adrs
  project_dna
  business_rules
  decision_timeline
  technical_debt
  modernization_items

------------------------------------------------------------------------

# Acceptance Criteria

  Requirement
  ------------------------------------
  Repository scans successfully
  Project DNA generated
  PRD reconstructed
  ADRs reconstructed
  Business rules extracted
  Technical debt categorized
  Confidence included everywhere
  Every inference linked to evidence
  Markdown artifacts generated
  CLI fully functional

------------------------------------------------------------------------

# North Star

The purpose of Software Archaeology is to transform an unfamiliar
repository into an explainable engineering system.

Future humans and AI agents should be able to understand *why* the
system exists---not merely *how* it is implemented.

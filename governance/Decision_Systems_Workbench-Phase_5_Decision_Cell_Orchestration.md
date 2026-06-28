# Decision Systems Workbench -- Phase 5

# Minimum Viable Decision Team (Decision Cell)

Version: 0.1

## Mission

Build the smallest practical, evidence-driven orchestration framework
capable of producing higher-quality engineering decisions than a single
LLM.

This is **not** a general-purpose autonomous agent framework.

It is an engineering collaboration framework.

------------------------------------------------------------------------

# Existing Foundation

Reuse functionality from prior phases.

  -----------------------------------------------------------------------
  Phase                               Reuse
  ----------------------------------- -----------------------------------
  Phase 1                             CLI, configuration, storage,
                                      logging

  Phase 2                             LLM Mega Matrix, routing,
                                      benchmarks, model roles

  Phase 3                             Software Archaeology, Project DNA,
                                      PRD reconstruction, evidence graph

  Phase 4                             Decision Systems Architecture,
                                      Decision DNA, evidence model,
                                      confidence model
  -----------------------------------------------------------------------

Never duplicate these capabilities.

------------------------------------------------------------------------

# Core Principles

  Principle          Requirement
  ------------------ --------------------------------------------
  Small Team         Maximum three active agents
  Stateless          No persistent conversations
  Artifact Driven    Exchange documents, never chat history
  Deterministic      Same inputs should produce similar outputs
  Explainable        Every conclusion references evidence
  Replaceable        Any model can fill a role
  Human Controlled   Human retains authority

------------------------------------------------------------------------

# Decision Cell

A Decision Cell exists only for one task.

Lifecycle:

``` text
Create
   ↓
Assign Roles
   ↓
Analyze
   ↓
Review
   ↓
Decision
   ↓
Archive Artifacts
   ↓
Destroy Cell
```

The intelligence resides in artifacts---not long-lived agents.

------------------------------------------------------------------------

# Team Composition

## Chief Decision Systems Architect

Responsibilities

-   Understand objective
-   Build execution plan
-   Select specialist
-   Select reviewer
-   Resolve disagreements
-   Produce final recommendation

Never writes production code.

------------------------------------------------------------------------

## Specialist

Exactly one specialist.

Possible roles:

-   Software Archaeologist
-   Enterprise Architect
-   Code Reviewer
-   Security Architect
-   Performance Engineer
-   Technical Writer
-   Vision Analyst
-   PRD Reconstruction Specialist

------------------------------------------------------------------------

## Reviewer

Must be a different model family whenever possible.

Responsibilities:

-   Challenge assumptions
-   Find missing evidence
-   Evaluate confidence
-   Identify risks
-   Produce counterarguments

------------------------------------------------------------------------

# Workflow

``` text
TaskBrief.md
      ↓
Evidence.md
      ↓
Analysis.md
      ↓
Review.md
      ↓
Decision.md
```

No hidden communication.

------------------------------------------------------------------------

# Shared Context

Every participant reads:

-   PROJECT_DNA.md
-   DECISION_DNA.md
-   Evidence.md
-   TaskBrief.md
-   Repository Summary
-   LLM Mega Matrix

No conversational memory.

------------------------------------------------------------------------

# Agent Contract

Every participant implements:

``` python
read_task()
read_evidence()
analyze()
produce_artifact()
estimate_confidence()
identify_unknowns()
recommend_next_action()
```

------------------------------------------------------------------------

# Routing

Reuse Phase 2 routing.

``` text
Task
 ↓
Task Classifier
 ↓
Model Router
 ↓
Decision Cell
 ↓
Artifacts
```

------------------------------------------------------------------------

# Conflict Resolution

If Specialist and Reviewer disagree:

1.  Document disagreement.
2.  Present evidence.
3.  Estimate confidence.
4.  Describe remaining uncertainty.
5.  Produce final recommendation.

Never declare a winner without rationale.

------------------------------------------------------------------------

# Artifact Specifications

## TaskBrief.md

-   Objective
-   Constraints
-   Success Criteria
-   Questions
-   Inputs

------------------------------------------------------------------------

## Evidence.md

-   Observations
-   Supporting files
-   Metrics
-   Assumptions
-   Unknowns
-   Confidence

------------------------------------------------------------------------

## Analysis.md

Produced by Specialist.

Contains:

-   Findings
-   Recommendations
-   Risks
-   Confidence
-   Evidence references

------------------------------------------------------------------------

## Review.md

Produced by Reviewer.

Contains:

-   Challenges
-   Missing assumptions
-   Alternative explanations
-   Confidence adjustments

------------------------------------------------------------------------

## Decision.md

Produced by CDSA.

Contains:

-   Final recommendation
-   Evidence summary
-   Alternatives
-   Decision confidence
-   Remaining uncertainty
-   Suggested next action

------------------------------------------------------------------------

# CLI

``` bash
dsw team run repo-analysis ./repo
dsw team run architecture ./repo
dsw team run code-review ./repo
dsw team run security-review ./repo

dsw team explain <run_id>
dsw team export <run_id>
```

------------------------------------------------------------------------

# SQLite Schema

## team_runs

  Field
  -----------------
  run_id
  task
  primary_model
  reviewer_model
  specialist_role
  status
  started
  finished
  confidence

------------------------------------------------------------------------

## team_artifacts

  Field
  ---------------
  artifact_id
  run_id
  role
  model
  artifact_path
  sha256
  timestamp

------------------------------------------------------------------------

# Logging Requirements

Every artifact records:

-   Timestamp
-   Model
-   Model Version
-   Prompt Version
-   Confidence
-   SHA256
-   Run ID

------------------------------------------------------------------------

# Human Approval Policy

The orchestration engine shall not:

-   Commit to Git
-   Deploy software
-   Delete files
-   Execute shell commands
-   Modify production infrastructure

without explicit human approval.

------------------------------------------------------------------------

# Explicit Non-Goals

Do not implement:

-   Recursive agents
-   Self-spawning agents
-   Persistent personalities
-   Browser automation
-   Email
-   Slack
-   Calendar
-   MCP integration
-   Autonomous coding
-   Autonomous deployment

------------------------------------------------------------------------

# Sprint 1

Deliver:

1.  Decision Cell runner
2.  Three-role orchestration
3.  Artifact pipeline
4.  CLI commands
5.  SQLite persistence
6.  Markdown exports

Nothing else.

------------------------------------------------------------------------

# Acceptance Criteria

  Requirement
  ---------------------------------------
  Three-agent Decision Cell operational
  Routing integrated with Phase 2
  Evidence integrated with Phase 3
  Decision process follows Phase 4
  Five artifacts generated
  Human approval preserved
  Runs reproducible

------------------------------------------------------------------------

# North Star

A Decision Cell should provide enough evidence, analysis, and review
that an engineer can make a better-informed decision before changing a
repository.

Success is measured by better engineering decisions---not more
autonomous behavior.

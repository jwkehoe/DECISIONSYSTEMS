# Decision Systems Workbench – Phase 2  
# LLM Mega Matrix: Model Taxonomy and Evaluation Methodology

Version: 0.1  
Status: Build Specification  
Owner Role: Chief Decision Systems Architect  
Primary Purpose: Create a durable, testable, local-first model catalog and evaluation system for routing AI work to the best available model or model team.

---

## 1. Executive Summary

The LLM Mega Matrix is the model intelligence layer of the Decision Systems Workbench.

Its purpose is not merely to list available models. Its purpose is to convert a loose collection of local and cloud models into an operational engineering capability.

The system must answer practical questions:

| Question | Required Answer |
|---|---|
| What models do I have? | Inventory with local path, family, size, quantization, modality, and runtime requirements. |
| What is each model good at? | Capability scores grounded in benchmark evidence and observed use. |
| What does each model fail at? | Failure-mode catalog with severity and mitigation. |
| Which model should perform this task? | Routing recommendation with rationale and confidence. |
| Which model should review the first model? | Reviewer model selection based on complementary strengths. |
| Which model is cheapest, fastest, or safest? | Cost/performance/risk comparison table. |
| Which models should be retired? | Redundancy and low-value analysis. |
| Which models should be acquired next? | Gap analysis against desired capabilities. |

The LLM Mega Matrix becomes the lookup table for all later phases of Decision Systems Workbench, including Software Archaeology, PRD Reconstruction, Project DNA generation, AIVAI-style adversarial review, and local/cloud model routing.

---

## 2. Design Principles

| Principle | Meaning |
|---|---|
| Local-first | The system must work without cloud dependency. |
| Evidence-based | Scores must be tied to benchmarks, observations, or human review. |
| Re-runnable | Benchmarks must be reproducible. |
| Task-centered | Models are evaluated by useful work, not generic leaderboard prestige. |
| Role-aware | Models are assigned jobs: architect, coder, critic, router, summarizer, vision analyst, embedding engine, reranker, etc. |
| Failure-aware | A model's weaknesses are as important as its strengths. |
| Confidence-explicit | Every recommendation must include confidence. |
| Cheap models matter | Small models are valuable for routing, classification, formatting, and guardrail work. |
| Reviewer diversity matters | The best reviewer is often not the same model family as the author. |
| Artifact-first | Every evaluation produces durable artifacts. |

---

## 3. Phase 2 Scope

Phase 2 builds the complete model catalog, scoring system, benchmark methodology, and routing policy.

### In Scope

| Area | Included |
|---|---|
| Model inventory | Scan local model tree and register models. |
| Model taxonomy | Classify by modality, family, size, runtime, and role. |
| Capability scoring | Rate models across engineering, writing, reasoning, retrieval, and multimodal tasks. |
| Benchmark suites | Define repeatable task suites. |
| Failure-mode catalog | Track hallucinations, brittleness, overengineering, format failures, etc. |
| Routing policies | Map task types to primary, reviewer, and validator models. |
| Model cards | Generate a model profile artifact for each model. |
| Matrix export | Export Markdown, CSV, JSON, and SQLite views. |
| Gap analysis | Identify missing model capabilities. |

### Out of Scope for Phase 2

| Area | Deferred To |
|---|---|
| Full repository archaeology execution | Phase 3 |
| Multi-agent orchestration runtime | Phase 5 |
| Web UI | Later |
| Cloud provider billing integration | Later |
| Automated fine-tuning | Later |
| Production API gateway | Later |

---

## 4. Starter Model Inventory From Current Local Tree

The following seed table is derived from the current local model tree. Some values should be validated by the scanner because filenames and directory names are imperfect evidence.

Current local note:

- The archaeology-primary `qwen3-next-80b-a3b` currently maps to the local path `/Users/meat/LLM_Models/models/adam-fleet/Qwen3-Next-80B-A3B-Instruct-REAM-mlx-3bit`.
- This is the current best local match for the `Qwen3-Next-80B` role even though it is a 3-bit REAM MLX build rather than the earlier 4-bit placeholder label in the seed inventory.
- A separate coder-tuned `Qwen3-Coder-Next-REAM` build is optional for implementation-heavy work, but it is not required for repository archaeology when the instruct archaeology-primary is present.

| Model ID | Model / Directory Name | Family | Approx Class | Modality | Runtime Clue | Initial Role |
|---|---|---:|---|---|---|---|
| qwen3-next-80b-a3b | Qwen3-Next-80B-A3B-Instruct-REAM-mlx-3bit | Qwen | 80B MoE/A3B | Text | MLX 3-bit REAM | Chief Architect / Heavy Reasoning |
| qwen3-6-35b-a3b | Qwen3.6-35B-A3B-MLX-4bit | Qwen | 35B MoE/A3B | Text | MLX 4-bit | Senior Architect / General Reasoning |
| qwen3-6-27b-ud | Qwen3.6-27B-UD-MLX-4bit | Qwen | 27B | Text | MLX 4-bit | Daily Driver / Engineering |
| deepseek-r1-32b | DeepSeek-R1-Distill-Qwen-32B-4bit | DeepSeek/Qwen | 32B | Text | 4-bit | Reasoning Critic / Debug Reviewer |
| deepseek-r1-1-5b | deepseek-r1-distill-qwen-1.5b | DeepSeek/Qwen | 1.5B | Text | unknown | Router / Classifier / Cheap Reasoning |
| deepseek-coder-v2-lite | DeepSeek-Coder-V2-Lite-Instruct-8bit | DeepSeek | Coder Lite | Text/Code | 8-bit | Code Specialist |
| qwen2-5-coder-7b | Qwen2.5-Coder-7B-4bit-mlx-dwq-lr1e-7 | Qwen Coder | 7B | Text/Code | MLX 4-bit DWQ | Fast Code Generator |
| llama-3-3-70b | Llama-3.3-70B-Instruct-4bit-DWQ | Llama | 70B | Text | 4-bit DWQ | General Reasoning / Writing |
| llama-3-1-8b | Meta-Llama-3.1-8B-Instruct-4bit | Llama | 8B | Text | 4-bit | Fast General Assistant |
| eva-qwen2-5-32b | EVA-Qwen2.5-32B-v0.2-mlx-6bit | EVA/Qwen | 32B | Text | MLX 6-bit | Creative Dialogue / Narrative Reasoning |
| magnum-v3-34b | magnum-v3-34b-4bit | Magnum | 34B | Text | 4-bit | Longform Writing / Voice Drafting |
| gemma-4-e4b | gemma-4-e4b-it-4bit-MAD | Gemma | E4B | Text | 4-bit | Fast Assistant / Experimental |
| huihui-gemma-3n-e4b | Huihui-gemma-3n-E4B-it-abliterated-lm-6bit | Gemma | E4B | Text | 6-bit | Experimental / Unrestricted Analysis Sandbox |
| qwen2-5-vl-32b | Qwen2.5-VL-32B-Instruct-4bit | Qwen VL | 32B | Vision/Text | 4-bit | Vision Analyst |
| glm-4-6v-flash | GLM-4.6V-Flash-MLX-4bit | GLM Vision | Flash | Vision/Text | MLX 4-bit | Fast Vision / Screenshot Analysis |
| pixtral-12b | pixtral-12b-4bit | Pixtral | 12B | Vision/Text | 4-bit | Vision Assistant |
| bge-m3 | bge-m3-mlx-8bit | BGE | Embedding | Embedding | MLX 8-bit | Embedding Engine |
| qwen3-embedding-4b | Qwen3-Embedding-4B-4bit-DWQ | Qwen Embedding | 4B | Embedding | 4-bit DWQ | Embedding Engine |
| qwen3-reranker-8b | Qwen3-Reranker-8B-4bit-MLX | Qwen Reranker | 8B | Reranker | MLX 4-bit | Retrieval Judge |
| qwen3-reranker-4b | Qwen3-Reranker-4B-mxfp8 | Qwen Reranker | 4B | Reranker | MXFP8 | Fast Retrieval Judge |
| bge-reranker-v2-m3 | BAAI bge-reranker-v2-m3 | BGE Reranker | M3 | Reranker | HF cache | Retrieval Judge |
| ms-marco-minilm-l6 | ms-marco-MiniLM-L-6-v2-GGUF | MiniLM | Small | Reranker/Cross-encoder | GGUF q8_0 | Lightweight Retrieval Scorer |
| ms-marco-minilm-l12 | cross-encoder/ms-marco-MiniLM-L-12-v2 | MiniLM | Small | Reranker/Cross-encoder | HF cache | Lightweight Retrieval Scorer |
| flux-schnell | flux1.schnell.4bit.mlx | Flux | Image Gen | Image | MLX 4-bit | Image Generator |

---

## 5. Model Taxonomy

### 5.1 Taxonomy Dimensions

Every model receives values across the following dimensions.

| Dimension | Purpose | Example Values |
|---|---|---|
| Family | Model lineage or architecture family | Qwen, DeepSeek, Llama, Gemma, GLM, Pixtral, Flux |
| Modality | Type of input/output | Text, Code, Vision/Text, Embedding, Reranker, Image Generation |
| Scale Class | Practical model size tier | Tiny, Small, Medium, Large, Very Large, MoE |
| Runtime | Execution environment | MLX, GGUF, HF Transformers, llama.cpp, vLLM |
| Quantization | Compression format | FP16, BF16, 8-bit, 6-bit, 4-bit, MXFP8, DWQ |
| Primary Role | Best operational use | Architect, Coder, Critic, Vision Analyst, Router |
| Secondary Roles | Additional uses | Summarizer, Writer, JSON fixer, SQL analyst |
| Risk Class | Operational risk | Low, Medium, High, Experimental |
| Confidence Class | How well characterized the model is | Unknown, Initial, Measured, Proven |
| Lifecycle Status | Whether it should be used | Candidate, Active, Preferred, Deprecated, Retired |

### 5.2 Modality Lookup Table

| Modality | Description | Input | Output | Examples |
|---|---|---|---|---|
| Text | General language and reasoning | Text | Text | Qwen, Llama, DeepSeek |
| Code | Code-optimized language model | Text/code | Text/code | Qwen Coder, DeepSeek Coder |
| Vision/Text | Image understanding plus text | Image + text | Text | Qwen2.5-VL, GLM-V, Pixtral |
| Embedding | Vector representation | Text | Vector | BGE-M3, Qwen Embedding |
| Reranker | Relevance scoring | Query + candidate docs | Scores | Qwen Reranker, BGE Reranker |
| Cross-Encoder | Pairwise semantic scoring | Query + passage | Relevance score | MiniLM rerankers |
| Image Generation | Generate images | Prompt | Image | Flux |
| Audio | Speech/audio tasks | Audio/text | Text/audio | Future |
| Tool-Use Agent | Calls tools/APIs reliably | Text + tool schema | Tool calls | Future |

### 5.3 Scale Class Lookup Table

| Scale Class | Parameter Range | Typical Use | Strength | Weakness |
|---|---:|---|---|---|
| Tiny | <2B | Routing, classification, cheap transformations | Fast and cheap | Weak reasoning |
| Small | 2B–8B | Coding helpers, JSON repair, summaries | Good latency | Limited deep synthesis |
| Medium | 9B–20B | Vision, coding, general assistant work | Balanced | May struggle with complex architecture |
| Large | 21B–40B | Engineering, PRD, reasoning, longform | Strong capability | Slower, memory heavy |
| Very Large | 41B–80B | Architecture, synthesis, adversarial reasoning | High quality | Expensive locally |
| MoE / Active Sparse | Any total size with active subset | Heavy reasoning with efficient active params | Strong/efficient tradeoff | Routing quality can vary |

### 5.4 Runtime Lookup Table

| Runtime | Best Fit | Advantages | Risks / Notes |
|---|---|---|---|
| MLX | Apple Silicon local inference | Strong Mac performance, unified memory | Model support varies |
| GGUF / llama.cpp | Broad CPU/GPU compatibility | Portable, mature ecosystem | Quant quality varies |
| HF Transformers | Research and full model compatibility | Flexible, canonical | Heavy dependency footprint |
| vLLM | Server inference | Throughput, batching | Less Mac-native |
| Ollama | Simple local serving | Operationally easy | Less control over internals |
| LM Studio | Interactive local use | Easy exploration | Not ideal as sole automation substrate |
| llama-cpp-python | Python integration | Simple local API | Performance depends on build |
| MLX-LM | Python + MLX models | Good for Mac automation | Need model compatibility discipline |

---

## 6. Operational Model Roles

### 6.1 Role Lookup Table

| Role ID | Role Name | Description | Good Candidates |
|---|---|---|---|
| chief_architect | Chief Architect | Deep synthesis, design tradeoffs, system-level reasoning | Qwen3-Next-80B, Qwen3.6-35B |
| senior_engineer | Senior Engineer | Practical implementation design and code reasoning | Qwen3.6-27B, Qwen3.6-35B |
| code_generator | Code Generator | Create implementation code quickly | Qwen2.5-Coder-7B, DeepSeek-Coder-V2-Lite |
| code_reviewer | Code Reviewer | Find bugs, edge cases, maintainability issues | DeepSeek-R1-32B, Qwen3.6-35B |
| reasoning_critic | Reasoning Critic | Challenge conclusions and find hidden assumptions | DeepSeek-R1-32B, Qwen3-Next-80B |
| software_archaeologist | Software Archaeologist | Infer system purpose from code | Qwen3-Next-80B, Qwen3.6-35B |
| prd_writer | PRD Writer | Produce structured product requirements | Qwen3.6-35B, Magnum, Llama-70B |
| technical_writer | Technical Writer | Produce readable durable documentation | Magnum, Llama-70B, Qwen3.6-27B |
| json_validator | JSON Validator | Enforce structured output | Qwen3.6-27B, small Qwen/DeepSeek |
| router | Router | Classify task and select model/team | DeepSeek-R1-1.5B, Llama-8B |
| summarizer | Summarizer | Condense artifacts while preserving structure | Qwen3.6-27B, Llama-8B |
| vision_analyst | Vision Analyst | Interpret diagrams, screenshots, UI, charts | Qwen2.5-VL-32B, GLM-4.6V, Pixtral |
| embedding_engine | Embedding Engine | Generate vectors for retrieval | BGE-M3, Qwen3-Embedding-4B |
| reranker | Reranker | Score retrieved passages | Qwen3-Reranker, BGE Reranker, MiniLM |
| image_generator | Image Generator | Create graphics and visual artifacts | Flux Schnell |

### 6.2 Role Assignment Rules

| Task Pattern | Primary Role | Reviewer Role | Validator Role |
|---|---|---|---|
| "Design this system" | chief_architect | reasoning_critic | technical_writer |
| "Write this code" | code_generator | code_reviewer | json_validator if structured |
| "Review this code" | code_reviewer | senior_engineer | technical_writer |
| "Reverse engineer this repo" | software_archaeologist | chief_architect | evidence_validator |
| "Generate PRD from repo" | prd_writer | software_archaeologist | chief_decision_systems_architect |
| "Analyze screenshot" | vision_analyst | senior_engineer | summarizer |
| "Build RAG index" | embedding_engine | reranker | senior_engineer |
| "Classify task" | router | senior_engineer | none |
| "Write LinkedIn/article" | technical_writer | reasoning_critic | voice_editor |
| "Find hallucination" | reasoning_critic | chief_architect | evidence_validator |

Operational note:

- If the local `Qwen3-Next-80B-A3B-Instruct-REAM-mlx-3bit` build is available, prefer it over smaller general models for reverse engineering and intent recovery.
- Use coder-specialized models such as `Qwen2.5-Coder-7B` only after archaeology when the task shifts from understanding to implementation.
- Treat `Qwen3-Coder-Next-REAM` as an optional future code-role addition, not as a replacement for the archaeology-primary instruct build.

---

## 7. Capability Ontology

### 7.1 Capability Categories

| Capability Group | Description |
|---|---|
| Reasoning | Logical inference, causal reasoning, multi-step problem solving |
| Engineering | Code generation, code review, debugging, architecture |
| Software Archaeology | Reverse engineering, intent recovery, PRD reconstruction |
| Retrieval | Embedding quality, reranking, citation selection |
| Structure | JSON, YAML, Markdown, schema adherence |
| Writing | Longform writing, technical writing, voice matching |
| Vision | Image, screenshot, diagram, UI, chart analysis |
| Safety / Security | Threat modeling, prompt injection analysis, secrets detection |
| Performance | Latency, throughput, memory efficiency |
| Operations | CLI use, tool calling, deterministic workflows |

### 7.2 Detailed Capability Lookup Table

| Capability ID | Capability Name | Definition | Evidence Required |
|---|---|---|---|
| reasoning_multistep | Multi-step reasoning | Solves tasks requiring chained inference | Benchmark tasks with hidden intermediate constraints |
| reasoning_causal | Causal reasoning | Separates cause, correlation, and coincidence | Causal scenario benchmark |
| reasoning_uncertainty | Uncertainty handling | States what is unknown and why | Human review + confidence calibration |
| code_generation | Code generation | Produces working code from specs | Unit tests pass |
| code_repair | Code repair | Fixes broken code | Failing tests become passing |
| code_review | Code review | Finds bugs, risks, and maintainability issues | Seeded defect benchmark |
| architecture_design | Architecture design | Produces coherent system design | Expert rubric |
| architecture_review | Architecture review | Identifies weaknesses in designs | Expert rubric |
| repo_comprehension | Repository comprehension | Understands multi-file codebase | Repo Q&A benchmark |
| prd_reconstruction | PRD reconstruction | Infers requirements from implementation | Evidence-backed PRD benchmark |
| adr_reconstruction | ADR reconstruction | Infers likely architecture decisions | Evidence-backed ADR benchmark |
| project_dna | Project DNA generation | Produces durable repo memory | Future-agent usefulness rubric |
| json_reliability | JSON reliability | Produces valid schema-conforming JSON | Automated schema validation |
| markdown_quality | Markdown quality | Produces clean durable docs | Lint + human review |
| sql_reasoning | SQL reasoning | Explains and repairs SQL/database behavior | SQL task suite |
| rag_query_quality | RAG query quality | Generates useful retrieval queries | Retrieval benchmark |
| rerank_quality | Reranking quality | Sorts relevant evidence correctly | Labeled retrieval set |
| summarization_fidelity | Summary fidelity | Preserves important facts while compressing | Diff against source facts |
| hallucination_resistance | Hallucination resistance | Avoids unsupported claims | Grounded QA benchmark |
| vision_diagram | Diagram interpretation | Explains architecture diagrams | Human-labeled diagram benchmark |
| vision_ui | UI/screenshot interpretation | Reads screens and detects issues | Screenshot task suite |
| security_threat_model | Threat modeling | Identifies abuse paths and mitigations | Security rubric |
| prompt_injection_detection | Prompt injection detection | Flags malicious instructions in content | Injection benchmark |
| performance_reasoning | Performance reasoning | Diagnoses latency, memory, concurrency issues | Seeded performance scenarios |
| tool_calling | Tool calling | Chooses and formats tool calls reliably | Tool-call simulation |
| confidence_calibration | Confidence calibration | Confidence matches correctness | Calibration curve |

---

## 8. Scoring System

### 8.1 Score Scale

| Score | Label | Meaning |
|---:|---|---|
| 0 | Not Applicable | Model cannot perform this capability. |
| 1 | Unsafe / Unusable | Output is usually wrong or dangerous for this capability. |
| 2 | Very Weak | Fails most realistic tasks. |
| 3 | Weak | Handles toy examples only. |
| 4 | Limited | Useful with heavy supervision. |
| 5 | Adequate | Can perform routine tasks with review. |
| 6 | Good | Useful for normal work, still needs review. |
| 7 | Strong | Reliable on most non-critical tasks. |
| 8 | Very Strong | Reliable for serious work with light review. |
| 9 | Excellent | Among best available locally. |
| 10 | Reference | Default choice; proven by repeated benchmarks. |

### 8.2 Confidence Scale

| Confidence | Label | Meaning |
|---:|---|---|
| 0.00–0.20 | Unknown | Insufficient evidence. |
| 0.21–0.40 | Initial | Based on filename, known model family, or a few tests. |
| 0.41–0.60 | Observed | Based on repeated interactive use. |
| 0.61–0.80 | Measured | Based on benchmark suite results. |
| 0.81–1.00 | Proven | Based on benchmark plus repeated production use. |

### 8.3 Risk Scale

| Risk | Meaning | Example |
|---|---|---|
| Low | Safe for routine use | Summarization, formatting, local notes |
| Medium | Requires review | Code generation, architecture draft |
| High | Must be reviewed carefully | Security advice, repo modernization |
| Critical | Never automate without human approval | Deleting files, production changes, legal/medical/security decisions |

### 8.4 Capability Score Record

| Field | Type | Description |
|---|---|---|
| model_id | text | Model identifier |
| capability_id | text | Capability being scored |
| score | integer | 0–10 |
| confidence | real | 0.0–1.0 |
| evidence_type | text | Benchmark, human review, observation, inferred |
| evidence_ref | text | Path or benchmark ID |
| reviewer | text | Human/model reviewer |
| date | datetime | Score date |
| notes | text | Explanation |

---

## 9. Weighted Role Scoring

Each operational role uses weighted capabilities.

### 9.1 Chief Architect Weight Table

| Capability | Weight |
|---|---:|
| architecture_design | 0.20 |
| reasoning_multistep | 0.15 |
| reasoning_causal | 0.15 |
| repo_comprehension | 0.10 |
| performance_reasoning | 0.10 |
| security_threat_model | 0.10 |
| markdown_quality | 0.05 |
| hallucination_resistance | 0.10 |
| confidence_calibration | 0.05 |

### 9.2 Code Generator Weight Table

| Capability | Weight |
|---|---:|
| code_generation | 0.30 |
| code_repair | 0.20 |
| json_reliability | 0.10 |
| repo_comprehension | 0.10 |
| tool_calling | 0.10 |
| hallucination_resistance | 0.10 |
| markdown_quality | 0.05 |
| confidence_calibration | 0.05 |

### 9.3 Software Archaeologist Weight Table

| Capability | Weight |
|---|---:|
| repo_comprehension | 0.20 |
| prd_reconstruction | 0.20 |
| adr_reconstruction | 0.15 |
| reasoning_causal | 0.15 |
| summarization_fidelity | 0.10 |
| hallucination_resistance | 0.10 |
| markdown_quality | 0.05 |
| confidence_calibration | 0.05 |

### 9.4 Technical Writer Weight Table

| Capability | Weight |
|---|---:|
| markdown_quality | 0.25 |
| summarization_fidelity | 0.20 |
| technical_writing | 0.20 |
| hallucination_resistance | 0.15 |
| structure_adherence | 0.10 |
| voice_matching | 0.10 |

### 9.5 Routing Formula

```text
role_score(model, role) =
    SUM(capability_score(model, capability) * role_weight(capability))
```

Tie-breakers:

| Tie-Breaker Order | Criterion |
|---:|---|
| 1 | Higher confidence score |
| 2 | Lower risk class |
| 3 | Faster latency |
| 4 | Lower memory footprint |
| 5 | More recent benchmark |
| 6 | Human preferred model |

---

## 10. Benchmark Philosophy

Do not rely on generic leaderboards.

The system needs practical benchmarks that match the user's actual work.

This benchmark suite is called **John Bench**.

### 10.1 John Bench Categories

| Suite ID | Suite Name | Purpose |
|---|---|---|
| jb-code-repair | Code Repair | Fix failing code and pass tests |
| jb-repo-understanding | Repo Understanding | Explain structure and intent of codebase |
| jb-prd-reconstruction | PRD Reconstruction | Infer requirements from implementation |
| jb-adr-reconstruction | ADR Reconstruction | Infer architectural decisions from code |
| jb-sql-reasoning | SQL Reasoning | Explain database behavior and optimize queries |
| jb-architecture | Architecture Design | Design systems under constraints |
| jb-security | Security Review | Threat model code and architecture |
| jb-json | JSON Reliability | Produce schema-conforming structured output |
| jb-writing | Technical Writing | Produce durable engineering documentation |
| jb-vision | Vision Analysis | Analyze screenshots, diagrams, and UI |
| jb-rag | Retrieval/RAG | Generate embeddings, rerank, and cite evidence |
| jb-adversarial | Adversarial Critique | Challenge assumptions and find failure modes |
| jb-long-context | Long Context | Maintain coherence over large inputs |

### 10.2 Benchmark Difficulty Levels

| Level | Name | Description |
|---:|---|---|
| 1 | Toy | Small isolated task |
| 2 | Routine | Normal developer task |
| 3 | Professional | Multi-file, realistic ambiguity |
| 4 | Expert | Complex engineering judgment |
| 5 | Adversarial | Designed to expose model weakness |

### 10.3 Benchmark Result Fields

| Field | Description |
|---|---|
| benchmark_id | Unique benchmark task |
| suite_id | Benchmark suite |
| difficulty | 1–5 |
| model_id | Tested model |
| prompt_version | Prompt used |
| input_hash | Hash of benchmark input |
| output_hash | Hash of output |
| latency_ms | End-to-end latency |
| tokens_in | Prompt/input tokens |
| tokens_out | Output tokens |
| tokens_per_second | Output speed |
| cost_estimate | Local estimated energy or cloud cost |
| automated_score | Automated score when possible |
| human_score | Human score when reviewed |
| reviewer_model_score | Model reviewer score |
| final_score | Resolved score |
| pass_fail | Boolean where applicable |
| notes | Observations |
| artifacts_path | Output directory |

---

## 11. Benchmark Suites

### 11.1 Code Repair Suite

| Task ID | Description | Scoring |
|---|---|---|
| cr-001 | Fix Python syntax/runtime error | Unit tests pass |
| cr-002 | Fix broken CLI argument parsing | Unit tests pass |
| cr-003 | Fix SQL query bug | Expected output match |
| cr-004 | Fix concurrency/race bug | Stress test pass |
| cr-005 | Refactor without behavior change | Tests pass + diff review |
| cr-006 | Repair broken package import structure | Tests pass |
| cr-007 | Fix JSON schema validation failure | Schema pass |
| cr-008 | Fix hidden edge case | Hidden tests pass |

### 11.2 Repo Understanding Suite

| Task ID | Description | Scoring |
|---|---|---|
| ru-001 | Identify repo purpose from file tree | Human rubric |
| ru-002 | Identify primary language/frameworks | Automated + human |
| ru-003 | Explain module relationships | Expert rubric |
| ru-004 | Identify build/test commands | Automated command validation |
| ru-005 | Identify hidden business rules | Evidence-backed rubric |
| ru-006 | Summarize risks and unknowns | Expert rubric |

### 11.3 PRD Reconstruction Suite

| Task ID | Description | Scoring |
|---|---|---|
| prd-001 | Infer product goal | Evidence-backed |
| prd-002 | Infer personas/users | Evidence-backed |
| prd-003 | Infer functional requirements | Recall/precision |
| prd-004 | Infer non-functional requirements | Expert rubric |
| prd-005 | Infer acceptance criteria | Expert rubric |
| prd-006 | Assign confidence to each requirement | Calibration score |

### 11.4 ADR Reconstruction Suite

| Task ID | Description | Scoring |
|---|---|---|
| adr-001 | Identify major architecture decisions | Evidence-backed |
| adr-002 | Infer decision context | Expert rubric |
| adr-003 | Infer alternatives considered | Plausibility + evidence |
| adr-004 | Infer consequences | Expert rubric |
| adr-005 | Flag speculative decisions | Confidence calibration |

### 11.5 SQL Reasoning Suite

| Task ID | Description | Scoring |
|---|---|---|
| sql-001 | Explain query plan | Expert rubric |
| sql-002 | Optimize slow query | Performance delta |
| sql-003 | Identify missing index | Expected answer |
| sql-004 | Explain transaction anomaly | Expected answer |
| sql-005 | Convert MySQL to PostgreSQL syntax | Tests pass |
| sql-006 | Detect unsafe migration | Expert rubric |

### 11.6 JSON Reliability Suite

| Task ID | Description | Scoring |
|---|---|---|
| json-001 | Produce valid JSON | Schema validation |
| json-002 | Produce nested structured JSON | Schema validation |
| json-003 | Preserve exact enum values | Exact match |
| json-004 | Escape strings correctly | Parser validation |
| json-005 | Refuse extra prose | Exact output validation |

### 11.7 Vision Suite

| Task ID | Description | Scoring |
|---|---|---|
| vis-001 | Explain architecture diagram | Human rubric |
| vis-002 | Read UI screenshot | Expected fields |
| vis-003 | Identify error message | Exact match |
| vis-004 | Extract table from screenshot | Cell accuracy |
| vis-005 | Interpret chart trend | Expected answer |
| vis-006 | Identify code from image | OCR-free human rubric |

### 11.8 Security Suite

| Task ID | Description | Scoring |
|---|---|---|
| sec-001 | Detect hardcoded secret | Expected finding |
| sec-002 | Threat model API | Expert rubric |
| sec-003 | Detect prompt injection | Expected finding |
| sec-004 | Identify dependency risk | Evidence-backed |
| sec-005 | Review auth/authorization | Expert rubric |
| sec-006 | Identify unsafe tool access | Expected finding |

### 11.9 Writing Suite

| Task ID | Description | Scoring |
|---|---|---|
| wr-001 | Generate technical README | Human rubric |
| wr-002 | Generate architecture guide | Human rubric |
| wr-003 | Summarize complex session | Fact preservation |
| wr-004 | Rewrite in user's voice | Human rubric |
| wr-005 | Remove AI speech artifacts | Human rubric |
| wr-006 | Generate executive summary | Human rubric |

---

## 12. Failure Mode Catalog

### 12.1 Common Model Failure Modes

| Failure ID | Failure Mode | Description | Severity |
|---|---|---|---|
| fm-hallucination | Unsupported claim | States a fact not grounded in evidence | High |
| fm-confabulated-api | Invented API | Calls or describes nonexistent API | High |
| fm-bad-json | Invalid structured output | JSON/YAML/schema invalid | Medium |
| fm-overengineering | Excessive complexity | Proposes unnecessary architecture | Medium |
| fm-underengineering | Too simplistic | Misses operational requirements | Medium |
| fm-context-loss | Loses earlier constraints | Ignores important prior instruction | High |
| fm-false-confidence | Overconfident wrong answer | High confidence despite weak basis | High |
| fm-refusal-drift | Refuses benign task | Over-applies safety limits | Medium |
| fm-security-blindness | Misses security issue | Fails to identify risk | High |
| fm-test-blindness | Writes code without testing path | Medium |
| fm-style-drift | Stops matching desired voice | Low/Medium |
| fm-format-drift | Does not follow required format | Medium |
| fm-local-minima | Locks onto first solution | Medium |
| fm-brittle-reasoning | Breaks under small perturbation | Medium |
| fm-retrieval-naive | Uses irrelevant retrieved evidence | High |
| fm-citation-error | Misattributes evidence | High |
| fm-vision-guessing | Guesses instead of reporting uncertainty | High |

### 12.2 Failure Severity Lookup

| Severity | Meaning | Required Mitigation |
|---|---|---|
| Low | Annoying but recoverable | Prompt adjustment |
| Medium | Can waste time or produce poor artifact | Reviewer model required |
| High | Can produce materially wrong decision | Evidence check + human review |
| Critical | Can damage systems or create serious risk | Human approval required |

### 12.3 Mitigation Lookup Table

| Failure Mode | Mitigation |
|---|---|
| Unsupported claim | Require evidence references and confidence |
| Invented API | Run against actual installed libraries or docs |
| Invalid JSON | Validate against schema; retry with JSON-only prompt |
| Overengineering | Add constraint: simplest viable design |
| Underengineering | Add non-functional requirements checklist |
| Context loss | Use Project DNA and task capsule |
| False confidence | Require uncertainty and alternatives |
| Security blindness | Separate security reviewer model |
| Retrieval naive | Use reranker and evidence scoring |
| Citation error | Evidence validator pass |
| Style drift | Use saved voice profile and examples |
| Vision guessing | Require "visible / inferred / unknown" labels |

---

## 13. Routing Policy

### 13.1 Routing Input Schema

| Field | Description |
|---|---|
| task_text | Natural language task |
| task_type | Classified task category |
| required_modality | Text, code, vision, embedding, image |
| risk_level | Low/Medium/High/Critical |
| required_output_format | Markdown, JSON, code, diagram, etc. |
| context_size | Estimated token size |
| repo_path | Optional repository path |
| evidence_required | Boolean |
| latency_priority | Low/Medium/High |
| quality_priority | Low/Medium/High |
| privacy_level | Local-only, cloud-allowed, cloud-preferred |
| review_required | Boolean |

### 13.2 Routing Output Schema

| Field | Description |
|---|---|
| primary_model_id | Main model |
| reviewer_model_id | Reviewer model |
| validator_model_id | Formatter/schema validator |
| fallback_model_id | Backup |
| routing_confidence | 0.0–1.0 |
| rationale | Why this route was chosen |
| risk_notes | What can go wrong |
| required_checks | Tests/reviews required before trust |

### 13.3 Task Routing Lookup Table

| Task Type | Primary Model | Reviewer | Validator |
|---|---|---|---|
| heavy_architecture | qwen3-next-80b-a3b | deepseek-r1-32b | qwen3-6-27b-ud |
| daily_engineering | qwen3-6-27b-ud | deepseek-r1-32b | qwen3-6-27b-ud |
| code_generation_fast | qwen2-5-coder-7b | deepseek-coder-v2-lite | qwen3-6-27b-ud |
| code_review | deepseek-r1-32b | qwen3-6-35b-a3b | qwen3-6-27b-ud |
| repo_archaeology | qwen3-next-80b-a3b | qwen3-6-35b-a3b | deepseek-r1-32b |
| prd_reconstruction | qwen3-6-35b-a3b | qwen3-next-80b-a3b | magnum-v3-34b |
| technical_writing | magnum-v3-34b | qwen3-6-27b-ud | llama-3-3-70b |
| json_generation | qwen3-6-27b-ud | deepseek-r1-1-5b | qwen3-6-27b-ud |
| fast_classification | deepseek-r1-1-5b | llama-3-1-8b | none |

Current local routing interpretation:

- `repo_archaeology` primary resolves to `/Users/meat/LLM_Models/models/adam-fleet/Qwen3-Next-80B-A3B-Instruct-REAM-mlx-3bit`.
- If that model is unavailable or unstable, degrade to `qwen3-6-35b-a3b` as the practical archaeology fallback.
- Do not switch the archaeology primary to a coder-tuned variant unless benchmark evidence later shows better intent-recovery performance than the instruct build.
| screenshot_analysis | glm-4-6v-flash | qwen2-5-vl-32b | qwen3-6-27b-ud |
| diagram_analysis | qwen2-5-vl-32b | pixtral-12b | qwen3-6-27b-ud |
| rag_embedding | bge-m3 | qwen3-embedding-4b | none |
| rag_reranking | qwen3-reranker-8b | bge-reranker-v2-m3 | ms-marco-minilm-l12 |
| image_generation | flux-schnell | none | vision_analyst |

### 13.4 Privacy Routing Table

| Privacy Level | Allowed Models | Rule |
|---|---|---|
| local_only | Local models only | Do not call cloud |
| cloud_allowed | Local preferred, cloud fallback | Use cloud only if quality gap is material |
| cloud_preferred | Cloud first | Use local as reviewer or backup |
| sensitive_code | Local only | No external upload |
| public_docs | Cloud allowed | Prefer quality |
| regulated_data | Local only unless explicit approval | Evidence logged |

---

## 14. Model Card Specification

Every model should have a generated Markdown model card.

### 14.1 Model Card Fields

| Section | Required |
|---|---|
| Identity | Yes |
| Local Path | Yes |
| Family | Yes |
| Modality | Yes |
| Runtime | Yes |
| Quantization | Yes |
| System Requirements | Yes |
| Primary Role | Yes |
| Secondary Roles | Yes |
| Capability Scores | Yes |
| Benchmarks | Yes |
| Known Failure Modes | Yes |
| Best Prompt Style | Yes |
| Bad Prompt Patterns | Yes |
| Recommended Temperature | Yes |
| Context Reliability | Yes |
| Routing Policy | Yes |
| Retirement Notes | Optional |

### 14.2 Model Card Template

```markdown
# Model Card: {{ model_name }}

## Identity

| Field | Value |
|---|---|
| Model ID | {{ model_id }} |
| Family | {{ family }} |
| Provider | {{ provider }} |
| Local Path | {{ local_path }} |
| Modality | {{ modality }} |
| Runtime | {{ runtime }} |
| Quantization | {{ quantization }} |

## Operational Roles

| Role | Confidence | Notes |
|---|---:|---|
| {{ role }} | {{ confidence }} | {{ notes }} |

## Capability Scores

| Capability | Score | Confidence | Evidence |
|---|---:|---:|---|
| {{ capability }} | {{ score }} | {{ confidence }} | {{ evidence }} |

## Known Failure Modes

| Failure Mode | Severity | Mitigation |
|---|---|---|
| {{ failure }} | {{ severity }} | {{ mitigation }} |

## Recommended Use

{{ recommended_use }}

## Avoid Using For

{{ avoid_use }}

## Benchmark History

| Date | Suite | Score | Notes |
|---|---|---:|---|
| {{ date }} | {{ suite }} | {{ score }} | {{ notes }} |
```

---

## 15. Data Model

### 15.1 models

```sql
CREATE TABLE models (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    family TEXT,
    provider TEXT,
    local_path TEXT,
    modality TEXT,
    scale_class TEXT,
    parameter_count TEXT,
    active_parameter_count TEXT,
    quantization TEXT,
    runtime TEXT,
    context_window INTEGER,
    disk_size_bytes INTEGER,
    vram_required_gb REAL,
    ram_required_gb REAL,
    primary_role TEXT,
    secondary_roles TEXT,
    risk_class TEXT DEFAULT 'Medium',
    confidence_class TEXT DEFAULT 'Initial',
    lifecycle_status TEXT DEFAULT 'Candidate',
    notes TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

### 15.2 capabilities

```sql
CREATE TABLE capabilities (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    group_name TEXT NOT NULL,
    description TEXT,
    default_weight REAL DEFAULT 1.0
);
```

### 15.3 model_capability_scores

```sql
CREATE TABLE model_capability_scores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    model_id TEXT NOT NULL,
    capability_id TEXT NOT NULL,
    score INTEGER CHECK(score >= 0 AND score <= 10),
    confidence REAL CHECK(confidence >= 0.0 AND confidence <= 1.0),
    evidence_type TEXT,
    evidence_ref TEXT,
    reviewer TEXT,
    notes TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY(model_id) REFERENCES models(id),
    FOREIGN KEY(capability_id) REFERENCES capabilities(id)
);
```

### 15.4 benchmarks

```sql
CREATE TABLE benchmarks (
    id TEXT PRIMARY KEY,
    suite_id TEXT NOT NULL,
    task_id TEXT NOT NULL,
    name TEXT NOT NULL,
    difficulty INTEGER CHECK(difficulty >= 1 AND difficulty <= 5),
    input_path TEXT,
    expected_output_path TEXT,
    scoring_method TEXT,
    created_at TEXT NOT NULL
);
```

### 15.5 benchmark_runs

```sql
CREATE TABLE benchmark_runs (
    id TEXT PRIMARY KEY,
    benchmark_id TEXT NOT NULL,
    model_id TEXT NOT NULL,
    prompt_version TEXT,
    input_hash TEXT,
    output_hash TEXT,
    latency_ms INTEGER,
    tokens_in INTEGER,
    tokens_out INTEGER,
    tokens_per_second REAL,
    automated_score REAL,
    reviewer_model_score REAL,
    human_score REAL,
    final_score REAL,
    pass_fail BOOLEAN,
    output_path TEXT,
    notes TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY(benchmark_id) REFERENCES benchmarks(id),
    FOREIGN KEY(model_id) REFERENCES models(id)
);
```

### 15.6 model_failure_modes

```sql
CREATE TABLE model_failure_modes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    model_id TEXT NOT NULL,
    failure_id TEXT NOT NULL,
    severity TEXT NOT NULL,
    observed_in TEXT,
    mitigation TEXT,
    notes TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY(model_id) REFERENCES models(id)
);
```

### 15.7 routing_policies

```sql
CREATE TABLE routing_policies (
    id TEXT PRIMARY KEY,
    task_type TEXT NOT NULL,
    primary_role TEXT,
    reviewer_role TEXT,
    validator_role TEXT,
    risk_level TEXT,
    privacy_level TEXT,
    preferred_primary_model_id TEXT,
    preferred_reviewer_model_id TEXT,
    preferred_validator_model_id TEXT,
    fallback_model_id TEXT,
    rationale TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

---

## 16. CLI Specification

### 16.1 Model Inventory Commands

| Command | Purpose |
|---|---|
| `dsw models scan --path ~/LLM_Models` | Scan model tree |
| `dsw models list` | List known models |
| `dsw models show <model_id>` | Show model card summary |
| `dsw models card <model_id> --out cards/<id>.md` | Export model card |
| `dsw models edit <model_id>` | Edit metadata |
| `dsw models tag <model_id> --role <role>` | Assign role |
| `dsw models status <model_id> --set active` | Set lifecycle status |
| `dsw models export --format md --out LLM_MEGA_MATRIX.md` | Export matrix |

### 16.2 Benchmark Commands

| Command | Purpose |
|---|---|
| `dsw bench list` | List benchmark suites |
| `dsw bench run --model <model_id> --suite <suite>` | Run suite |
| `dsw bench run --model <model_id> --task <task_id>` | Run single task |
| `dsw bench compare --suite <suite>` | Compare models |
| `dsw bench report --model <model_id>` | Model benchmark report |
| `dsw bench export --format csv` | Export results |

### 16.3 Routing Commands

| Command | Purpose |
|---|---|
| `dsw route "task"` | Recommend model team |
| `dsw route --task-type repo_archaeology` | Route by explicit type |
| `dsw route --json "task"` | Output machine-readable route |
| `dsw route explain <route_id>` | Explain routing choice |

### 16.4 Failure Mode Commands

| Command | Purpose |
|---|---|
| `dsw failures list` | List failure taxonomy |
| `dsw failures add <model_id> --failure fm-bad-json` | Record failure |
| `dsw failures report <model_id>` | Show known issues |
| `dsw failures export --out FAILURE_MODES.md` | Export failure catalog |

---

## 17. Markdown Export Specifications

### 17.1 LLM Mega Matrix Export

Required sections:

| Section | Description |
|---|---|
| Executive Summary | Current state of model library |
| Inventory Table | All models |
| Role Assignment Table | Model to operational role |
| Capability Matrix | Scores by capability |
| Benchmark Summary | Results by suite |
| Failure Mode Summary | Known weaknesses |
| Routing Table | Recommended task routing |
| Gaps | Missing capabilities |
| Retirement Candidates | Models with low value or redundancy |
| Next Acquisitions | Models worth adding |

### 17.2 Capability Matrix Format

```markdown
| Model | Coding | Reasoning | Architecture | PRD | Vision | JSON | Writing | RAG | Speed | Overall Role |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| qwen3-next-80b-a3b | 8 | 10 | 10 | 9 | 0 | 8 | 8 | 0 | 4 | Chief Architect |
```

### 17.3 Routing Table Format

```markdown
| Task | Primary | Reviewer | Validator | Confidence | Notes |
|---|---|---|---|---:|---|
| Reverse engineer repo | qwen3-next-80b | deepseek-r1-32b | qwen3.6-27b | 0.72 | Needs benchmark validation |
```

---

## 18. Initial Seed Capability Matrix

These are initial working assumptions. They must be replaced by benchmark evidence.

| Model | Coding | Reasoning | Architecture | PRD | Vision | JSON | Writing | RAG | Speed | Initial Role |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| qwen3-next-80b-a3b | 8 | 10 | 10 | 9 | 0 | 8 | 8 | 0 | 3 | Chief Architect |
| qwen3-6-35b-a3b | 8 | 9 | 9 | 9 | 0 | 8 | 8 | 0 | 5 | Senior Architect |
| qwen3-6-27b-ud | 8 | 8 | 8 | 8 | 0 | 9 | 8 | 0 | 6 | Daily Driver |
| deepseek-r1-32b | 7 | 9 | 8 | 7 | 0 | 7 | 6 | 0 | 4 | Reasoning Critic |
| deepseek-coder-v2-lite | 8 | 6 | 5 | 4 | 0 | 7 | 4 | 0 | 7 | Code Specialist |
| qwen2-5-coder-7b | 8 | 5 | 4 | 3 | 0 | 7 | 4 | 0 | 8 | Fast Coder |
| llama-3-3-70b | 7 | 8 | 8 | 8 | 0 | 7 | 9 | 0 | 4 | General Writer |
| llama-3-1-8b | 5 | 5 | 4 | 4 | 0 | 6 | 6 | 0 | 9 | Fast Assistant |
| eva-qwen2-5-32b | 6 | 7 | 6 | 7 | 0 | 6 | 9 | 0 | 5 | Creative Reasoning |
| magnum-v3-34b | 5 | 6 | 5 | 8 | 0 | 5 | 10 | 0 | 5 | Voice Writer |
| qwen2-5-vl-32b | 4 | 7 | 6 | 5 | 9 | 6 | 6 | 0 | 4 | Vision Analyst |
| glm-4-6v-flash | 3 | 6 | 5 | 4 | 8 | 6 | 5 | 0 | 7 | Fast Vision |
| pixtral-12b | 3 | 6 | 5 | 4 | 7 | 5 | 5 | 0 | 7 | Vision Assistant |
| bge-m3 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 9 | 8 | Embedding |
| qwen3-embedding-4b | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 8 | 7 | Embedding |
| qwen3-reranker-8b | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 9 | 5 | Reranker |
| qwen3-reranker-4b | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 8 | 7 | Fast Reranker |
| bge-reranker-v2-m3 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 9 | 6 | Reranker |
| ms-marco-minilm-l6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 6 | 10 | Tiny Reranker |
| flux-schnell | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 5 | Image Generation |

---

## 19. Gap Analysis

### 19.1 Current Strengths

| Area | Assessment |
|---|---|
| Local reasoning | Strong, assuming Qwen3/DeepSeek models run acceptably |
| Coding | Good, with Qwen Coder and DeepSeek Coder |
| Vision | Good, with three vision-capable models |
| Retrieval | Strong, with embeddings plus multiple rerankers |
| Writing | Strong, with Magnum, EVA, Llama, and Qwen |
| Routing/classification | Adequate, using small DeepSeek/Llama models |
| Image generation | Present, with Flux Schnell |

### 19.2 Current Gaps

| Gap | Impact | Possible Fix |
|---|---|---|
| Tool-calling reliability not measured | Agent workflows may fail | Add tool-call benchmark |
| Long-context reliability unknown | Repo analysis may degrade | Add long-context degradation suite |
| Exact JSON conformance unknown | Automation brittle | Add strict schema benchmarks |
| Security model not specialized | Security review may be weaker than needed | Add dedicated security benchmark and possibly security-tuned model |
| Cloud comparison missing | Cannot know when cloud is worth it | Add cloud model adapter later |
| Runtime performance unknown | Routing cannot account for speed yet | Measure tokens/sec and memory |

---

## 20. Lifecycle Management

### 20.1 Lifecycle Status Lookup

| Status | Meaning |
|---|---|
| Candidate | Detected but not validated |
| Active | Usable, partially characterized |
| Preferred | Default for one or more roles |
| Deprecated | Still present but no longer recommended |
| Retired | Should not be used except historical testing |
| Broken | Installed but not runnable |
| Duplicate | Redundant with better model |

### 20.2 Retirement Criteria

| Criterion | Retirement Signal |
|---|---|
| Low capability | Scores below 5 in all useful roles |
| Redundant | Another model is better in same role and faster |
| Broken runtime | Cannot run reliably |
| Excessive footprint | Too large for value delivered |
| Unsafe behavior | Repeated high-severity failures |
| Licensing concern | Cannot be used for intended purpose |

---

## 21. Prompt Standards for Evaluation

### 21.1 Benchmark Prompt Requirements

Every benchmark prompt must include:

| Requirement | Reason |
|---|---|
| Task objective | Prevent ambiguity |
| Input context | Ground the model |
| Output format | Enable scoring |
| Constraints | Test instruction following |
| Evaluation criteria | Align model with benchmark |
| Refusal boundaries when needed | Avoid unsafe output |
| Confidence requirement | Test uncertainty handling |

### 21.2 Structured Output Prompt Pattern

```text
You are performing a benchmark task.

Task:
{{ task }}

Input:
{{ input }}

Return only valid JSON matching this schema:
{{ schema }}

Rules:
- Do not include prose outside JSON.
- If evidence is insufficient, use null and explain in the uncertainty field.
- Do not invent facts.
```

### 21.3 Software Archaeology Prompt Pattern

```text
You are a Software Archaeologist.

Analyze the provided repository evidence.

Infer:
- purpose
- architecture
- business rules
- likely requirements
- architectural decisions
- risks
- unknowns

For every inference, include:
- evidence
- confidence
- alternative explanations
- risk if wrong

Do not claim certainty where evidence is weak.
```

---

## 22. Implementation Plan for Phase 2

### Sprint 2.1 – Inventory Foundation

| Task | Output |
|---|---|
| Parse model tree | models table populated |
| Infer family/modality/runtime | Initial taxonomy |
| Export inventory | Markdown + CSV |
| Generate model IDs | Stable identifiers |
| Add lifecycle status | Candidate/Active/etc. |

### Sprint 2.2 – Capability Taxonomy

| Task | Output |
|---|---|
| Seed capabilities table | Capability ontology |
| Seed role weights | Role scoring |
| Add scoring CLI | Manual score entry |
| Add matrix export | Capability matrix |

### Sprint 2.3 – Benchmark Skeleton

| Task | Output |
|---|---|
| Define benchmark suites | benchmark records |
| Add benchmark runner interface | Runnable scaffold |
| Add JSON validation benchmark | First automated suite |
| Add code repair benchmark | Unit-test-based scoring |

### Sprint 2.4 – Routing Engine

| Task | Output |
|---|---|
| Add task classifier | Task type detection |
| Add route policy table | Initial routing |
| Add `dsw route` command | Model team recommendation |
| Add route explanation | Confidence + rationale |

### Sprint 2.5 – Reporting

| Task | Output |
|---|---|
| Generate LLM Mega Matrix | `LLM_MEGA_MATRIX.md` |
| Generate model cards | `model_cards/*.md` |
| Generate gap report | `MODEL_GAPS.md` |
| Generate retirement report | `MODEL_RETIREMENT_CANDIDATES.md` |

---

## 23. Acceptance Criteria

Phase 2 is complete when:

| Acceptance Criterion | Required |
|---|---|
| Local model tree can be scanned | Yes |
| Models are stored in SQLite | Yes |
| Models are classified by taxonomy | Yes |
| Capabilities can be scored | Yes |
| Matrix can be exported to Markdown | Yes |
| At least five benchmark suites are defined | Yes |
| At least two benchmark suites run automatically | Yes |
| Routing command recommends model team | Yes |
| Each route includes confidence and rationale | Yes |
| Failure modes can be recorded | Yes |
| Model cards can be generated | Yes |
| Gap analysis can be exported | Yes |

---

## 24. Strategic Role in the Workbench

The LLM Mega Matrix is the central lookup system for every later module.

| Later Module | Dependency on Mega Matrix |
|---|---|
| Software Archaeology | Selects repo analyst, PRD writer, ADR reviewer |
| Project DNA | Selects summarizer and documentation model |
| AIVAI | Selects attacker, defender, referee models |
| Benchmark Harness | Updates model scores |
| Routing Engine | Uses role scores to assemble model teams |
| Decision Systems Layer | Uses confidence, risk, and evidence |
| Agent Orchestration | Assigns model personas to expert roles |

Without the Mega Matrix, the system guesses.

With the Mega Matrix, the system routes, measures, learns, and improves.

---

## 25. Phase 2 North Star

The end state is simple:

```text
Given any task, the Workbench should know:

1. Which model should do the work.
2. Which model should review the work.
3. Which model should validate the format.
4. What risks are known.
5. How confident the system is.
6. What evidence supports that routing decision.
```

That is the purpose of the LLM Mega Matrix.

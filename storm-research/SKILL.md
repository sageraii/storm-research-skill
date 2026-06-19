---
name: storm-research
description: Grounded, multi-perspective research briefing in the style of Stanford's STORM (multi-perspective question asking), tuned by default for Physical AI / robotics. Use when the user asks to deeply analyze a complex topic — papers, model releases, benchmarks, trends, or contested claims — and wants source-grounded findings with contradictions and a reliability check, not a single-answer summary. Triggers include "storm으로 분석", "deep research", "5관점으로 분석", or any request for a structured, evidence-aware investigation of a Physical AI / robotics topic. Not for simple factual questions, definitions, translation, or basic summaries. This is NOT the official Stanford STORM software.
---

# STORM-Research

A STORM-inspired workflow that turns one topic into a grounded, multi-perspective research
briefing. Default persona pack is Physical AI / robotics; a generic pack is available for other
topics.

**This is NOT the official Stanford STORM system** (Synthesis of Topic Outlines through Retrieval
and Multi-perspective Question Asking, Stanford OVAL Lab). It is a prompt/agent-orchestration
adaptation inspired by STORM's multi-perspective question-asking idea. Do not describe it as
equivalent to running the official STORM software.

## When to use
Deep analysis of a complex or contested topic: papers, model/product releases, benchmarks,
trends, architectural choices, "should we adopt X" decisions. Especially Physical AI / robotics.

## When NOT to use
Simple factual questions, definitions, translation, basic summaries, casual advice, or anything a
short direct answer settles.

## Modes
- **Grounded multi-agent (default):** the full pipeline below with parallel subagents.
- **Single-context sequential:** for small topics, run the phases in one context without fan-out.
  In this mode, run Phase 5 as a deliberate adversarial review pass — explicitly re-framed as a
  separate evaluator critiquing the synthesis, not the author defending it.
- **Prompts-only:** if the user just wants the prompts, return the templates from
  `references/prompt-templates.md` (and the Compact Execution Prompt on request); stop.

## Pipeline

**Phase 0 — Scope.** Establish:
- Topic; User role (default: "a Physical AI / robotics researcher-engineer who needs a nuanced,
  evidence-aware briefing"; generic-pack default: "a technical decision-maker"); Goal (default:
  understand from multiple perspectives, find contradictions, produce an actionable, grounded
  briefing); Pack = `physical-ai` (default) or `generic`; Local = off (default) or on.

**Phase 1 — Grounding sweep.** Dispatch parallel search subagents per
`references/grounding-physical-ai.md` (source priority + tool mapping). Build a shared
**evidence pack**: deduplicated list of `source · claim · date · link`. If Local is on, also read
`arxive/`, `benchmark/`, `robots/` and project memory, treating local material as leads to
confirm. Grounding **reduces** hallucination; it does not eliminate it.

**Phase 2 — Multi-perspective scan.** Dispatch the five personas IN PARALLEL (from
`references/personas-physical-ai.md` or `references/personas-generic.md` by pack). Give each the
topic + the shared evidence pack + its persona brief. Each returns the three-part contract:
core position (2 sentences) / strongest cited evidence / the one unique insight. Personas must
cite the evidence pack, not invent sources. Prompt 1 in `references/prompt-templates.md` is the
base template.

**Phase 3 — Contradiction map.** One synthesis pass (Prompt 2): direct conflicts with the
specific clashing claims, strongest vs weakest evidence, the one resolving question, shared
agreement, and the field-level blind spot.

**Phase 4 — Synthesis.** Prompt 3: one-paragraph CEO summary, five findings ranked by
reliability (with supporting/challenging perspectives + citation), the hidden connection, an
actionable insight for the user's role, and the frontier question.

**Phase 5 — Peer review (separate lane).** Dispatch a SEPARATE verifier subagent (not the
context that wrote the synthesis) running Prompt 4 plus a citation fact-check: 1–10 confidence
per finding, weakest link, bias check, a proposed missing 6th perspective (the Robotics Historian
is the default candidate in the PA pack), and overall grade. The verifier **catches and flags**
weak or unsupported claims; it does not guarantee correctness.

**Phase 6 — Output.** Assemble per `references/output-template.md`, run its Quality Checklist,
save to `./storm-research/YYYY-MM-DD-<topic-slug>.md` (create the directory if missing; slugify
the topic: lowercase, non-alphanumerics → `-`), and post a short summary plus the file path in
chat.

## Honesty rules (mandatory)
- Never claim the workflow proves a topic; it produces a briefing that still needs verification.
- Never present "PhD in minutes" or "25% more organized" as factual guarantees.
- Use calibrated language: grounding **reduces** hallucination; peer review **catches/flags**
  weak claims. Avoid "prevents", "blocks", "guarantees".
- Always state this is not the official Stanford STORM system.
- Tag important claims: Verified fact / Source claim / Reasonable inference / Speculation.

## References
- `references/prompt-templates.md` — 4 templates + Compact Execution Prompt
- `references/personas-physical-ai.md` — default 5 personas + 6th candidate
- `references/personas-generic.md` — fallback 5 personas
- `references/grounding-physical-ai.md` — source priority, tools, evidence rules
- `references/output-template.md` — briefing + peer-review skeleton + Quality Checklist

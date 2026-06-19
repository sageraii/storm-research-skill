---
name: storm-research
description: STORM + Co-STORM-style grounded research that produces a sourced, Wikipedia-like long-form article with a Debates section and a Reliability & Review appendix. Discovers topic perspectives dynamically, runs grounded writer-expert conversations with a moderator that mines under-used evidence for blind spots, builds an outline/mind-map, and writes sectioned prose with numbered citations. Tuned by default for Physical AI / robotics; a generic seed pack covers any topic. Use when the user asks to deeply research or write up a complex topic — papers, model releases, benchmarks, trends, contested claims. Triggers include "storm으로 분석/조사", "deep research", "장문으로 정리", "리서치 기사". Not for simple factual questions, definitions, translation, or basic summaries. This is NOT the official Stanford STORM software.
---

# STORM-Research

A STORM + Co-STORM-inspired pipeline that turns one topic into a **sourced, Wikipedia-style
long-form article** with numbered citations and a References list — plus two grafted sections that
patch STORM's known gaps: a **Debates & Open Questions** section (contested points) and a
**Reliability & Review** appendix (self-critique, confidence, citation fact-check). Tuned by
default for **Physical AI / robotics**; a generic seed pack covers any topic.

**This is NOT the official Stanford STORM system** (Synthesis of Topic Outlines through Retrieval
and Multi-perspective Question Asking, Stanford OVAL Lab). It is a prompt/agent-orchestration
adaptation of STORM's and Co-STORM's ideas. It approximates STORM's retrieval index, embedding-based
knowledge base, and persistent state with a logged evidence pack and an LLM-maintained markdown
mind-map — so it is faithful in *method*, not in *infrastructure*. Output always requires your own
verification.

## When to use
Deep research / write-up of a complex or contested topic: papers, model/product releases,
benchmarks, trends, architectural choices, "state of X" surveys. Especially Physical AI / robotics.

## When NOT to use
Simple factual questions, definitions, translation, basic summaries, or anything a short direct
answer settles. For just the raw prompts, use prompts-only mode (below).

## Modes
- **Article (default):** the full pipeline below. Always produces the article + Debates + Reliability appendix.
- **Adaptive depth:** scale phases 1–2 to the topic — small topic → ~3 perspectives, few conversation turns; broad topic → more perspectives/turns and a deeper outline. Never skip phases 5–6.
- **Prompts-only:** if the user only wants the raw prompt scaffolding, return the templates from `references/prompt-templates.md` and stop.

## Pipeline (see `references/storm-pipeline.md` for the operational detail)

**Phase 0 — Scope.** Topic; user role (default: a Physical AI / robotics researcher-engineer);
goal; seed pack (`physical-ai` default | `generic`); local sources on/off; depth.

**Phase 1 — Perspective discovery (STORM).** Do NOT start from fixed personas. Survey analogous
structured sources for the topic (related Wikipedia/survey/arXiv/official-doc tables of contents,
GitHub README outlines) and derive several *topic-specific* perspectives from their section
structure, plus a neutral "basic fact" perspective. Use the seed pack
(`references/personas-physical-ai.md` | `personas-generic.md`) only to prime/backfill discovery.

**Phase 2 — Grounded conversation + moderator (STORM + Co-STORM).** For each perspective, run a
multi-turn **writer↔expert** conversation: the writer asks persona-anchored questions; the expert
answers ONLY from retrieved sources (per `references/grounding-physical-ai.md`), logging every
`source · claim · date · link` into a shared **evidence pack**. Periodically insert a **moderator**
turn (Co-STORM): mine snippets that were retrieved but NOT yet used, and raise a question about
them — this is the blind-spot engine. Vary expert turns across the Co-STORM action types
(Original Question / Further Details / Information Request / Potential Answer).

**Phase 3 — Mind-map + outline (STORM 2-pass + Co-STORM KB).** Maintain a running **mind-map**: a
markdown concept tree mapping evidence to sections. Generate a parametric outline draft, then
refine it with the conversation (two passes). Expand any heavily-cited node into subsections;
prune empty ones (Co-STORM reorganize).

**Phase 4 — Article generation.** Write the article section by section from the outline, drawing
only on the evidence pack. Use **inline numbered citations `[n]`** and assign them globally; emit a
**References** list mapping `[n] → source (title, author/venue, date, link)`.

**Phase 5 — Polish.** Write a **lead/summary** section (only after the body exists) covering the
topic's identity, context, notability, and key controversies. Run a **dedup** pass: a faithful
editor that removes only repeated content and preserves every citation and section.

**Phase 6 — Grafted sections (our value-add).**
- **Debates & Open Questions** — a section in the article naming where sources/perspectives
  genuinely conflict, what each side claims, and the one question that would resolve the biggest
  conflict (the contradiction-map value, encyclopedia-style).
- **Reliability & Review** appendix — a SEPARATE-lane self-critique (not the author voice):
  per-claim confidence (1–10), the weakest link, a bias check (which perspective dominated), a
  proposed missing perspective, and a citation fact-check (do cited sources support their claims?).
  This patches STORM's documented lack of self-critique. Keep it in the appendix so the article
  body still reads like an encyclopedia.

**Phase 7 — Output.** Assemble per `references/output-template.md`, run its Quality Checklist, save
to `./storm-research/YYYY-MM-DD-<topic-slug>.md` (create the dir if missing; slugify: lowercase,
non-alphanumerics → `-`), and post a short chat summary plus the file path.

## Honesty rules (mandatory)
- Never claim the workflow proves a topic; it produces an article that still needs verification.
- Never present "PhD in minutes" / "25% more organized" as factual guarantees.
- Calibrated language: grounding **reduces** hallucination; the review appendix **catches/flags**
  weak claims. Avoid "prevents", "blocks", "guarantees".
- Always state this is not the official Stanford STORM system, and that retrieval/KB are
  prompt/agent approximations of STORM's real infrastructure.
- Tag uncertain claims: Verified fact / Source claim / Reasonable inference / Speculation.
- Every `[n]` citation must resolve to a real source in References; the appendix fact-checks this.

## References
- `references/storm-pipeline.md` — STORM + Co-STORM operational mechanics (discovery, conversation, moderator, mind-map, generation, polish)
- `references/personas-physical-ai.md` — Physical AI seed perspectives (prime discovery; default)
- `references/personas-generic.md` — generic seed perspectives (any topic)
- `references/grounding-physical-ai.md` — source priority, tools, evidence rules
- `references/output-template.md` — article + References + Debates + Reliability appendix skeleton + Quality Checklist
- `references/prompt-templates.md` — raw prompt scaffolding (prompts-only mode)

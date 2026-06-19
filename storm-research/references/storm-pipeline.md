# STORM + Co-STORM Pipeline — Operational Mechanics

Faithful prompt/agent adaptation of Stanford STORM and Co-STORM. Where the originals use a
retrieval index, a sentence encoder, and a persistent in-memory knowledge base, this skill uses a
**logged evidence pack** (a markdown list) and an **LLM-maintained mind-map** (a markdown tree).
Faithful in method, approximate in infrastructure.

This file details Phases 1–6. Phase 0 (scope) and Phase 7 (assembly, quality checklist, save) are
handled in `SKILL.md`.

---

## Phase 1 — Perspective discovery (STORM `persona_generator`)

Original: STORM finds related Wikipedia articles, scrapes their tables of contents, and derives
editorial personas from those section names (plus a default "basic fact writer").

Adaptation:
1. Search for 3–6 analogous structured sources on the topic — surveys, Wikipedia pages, key arXiv
   papers, official docs, strong GitHub READMEs.
2. Extract their section/outline structure (the headings), not their full text.
3. Derive 3–5 **topic-specific perspectives** from recurring/【distinct】 section themes, each as
   `short name: what this perspective focuses on`. Always add one neutral **"basic fact"** perspective.
4. Prime/backfill with the seed pack (`personas-physical-ai.md` default, or `personas-generic.md`)
   only if discovery is thin — seeds are starting points, not the final list.

Output: a short list of named perspectives with a one-line focus each.

## Phase 2 — Grounded conversation + moderator (STORM `knowledge_curation` + Co-STORM)

Original STORM: one writer↔expert conversation per persona; the writer asks persona-anchored
questions, the expert decomposes each into search queries, retrieves, and answers ONLY from results;
each turn logs `(question, answer, queries, results)`; conversation ends when the writer is satisfied.

Original Co-STORM additions: an **expert action taxonomy** (Original Question / Further Details /
Information Request / Potential Answer), a **moderator** that surfaces retrieved-but-unused info as a
new question, and a round-robin **turn policy**.

Adaptation (per perspective, run them independently / in parallel where possible):
1. **Writer asks** a focused, persona-anchored question (keep only the last few turns in view).
2. **Expert answers** using real retrieval tools (`references/grounding-physical-ai.md`): turn the
   question into 1–3 search queries, retrieve, and answer ONLY from what was retrieved. The expert
   never asserts without a source.
3. **Log every snippet** into the shared **evidence pack** as `source · claim · date · link · [tag]`
   (tag = Verified fact / Source claim / Reasonable inference / Speculation). Mark which snippets were
   actually used in an answer vs. merely retrieved.
4. **Moderator turn** (every ~3 turns, Co-STORM): scan snippets that were retrieved but NOT yet used;
   pick the most relevant + least redundant one and raise a new question about it. This is the
   blind-spot engine — it forces coverage of evidence the personas would otherwise skip.
5. Stop a conversation when new turns stop adding cited information (diminishing returns).

Output: a populated evidence pack with usage flags, plus the dialogue history.

## Phase 3 — Mind-map + outline (STORM two-pass outline + Co-STORM KB)

Original STORM: flatten all conversations → write a parametric outline (topic only) → refine it with
the conversation content (two passes). Co-STORM additionally maintains a concept tree and
reorganizes it (expand heavily-cited nodes, merge/trim sparse ones).

Adaptation:
1. **Pass 1 (structural prior):** from the topic alone, draft a `#/##/###` outline of what a good
   article on this topic looks like.
2. **Pass 2 (informational signal):** revise that outline using the evidence pack and dialogue.
3. Maintain a **mind-map**: a markdown tree mapping each outline node → the evidence-pack items that
   support it. **Expand** any node carrying many distinct sources into subsections; **prune** nodes
   with no support.

Output: a refined outline + a node→evidence mind-map.

## Phase 4 — Article generation (STORM `article_generation`)

Original: write first-level sections in parallel, each section retrieving its top-k evidence and
writing inline-cited prose; then assign global citation numbers.

Adaptation:
1. Write each section from its mind-map node, drawing ONLY on that node's evidence-pack items.
2. Use inline numbered citations `[n]`; assign `[n]` globally across the whole article.
3. Build a **References** list: `[n] → title · author/venue · date · link`. Every `[n]` must resolve.

## Phase 5 — Polish (STORM `article_polish`)

1. **Lead/summary** (write last, needs the whole article): ≤4 short paragraphs covering identity,
   context, notability, and the key controversies.
2. **Dedup**: a faithful editor pass that removes only repeated content; preserve every citation and
   every section. Do not rewrite non-repeated text.

## Phase 6 — Grafted sections (our value-add; not in STORM)

1. **Debates & Open Questions** (from our contradiction-map): name where sources/perspectives
   genuinely conflict, give both sides with citations, and state the one question that would resolve
   the biggest conflict, plus the field-level blind spot the moderator surfaced.
2. **Reliability & Review** appendix — run as a SEPARATE-lane critique (a different voice/agent than
   the author), patching STORM's documented lack of self-critique:
   - per main claim: confidence 1–10 + reason
   - weakest link (+ what would verify it)
   - bias check (which perspective dominated; ~independent vs. overlapping evidence lines)
   - missing perspective (one not discovered in Phase 1)
   - citation fact-check: spot-check that cited sources actually support their claims; flag any that
     do not, and confirm inference-tagged claims are not presented as fact.

## Notes on faithfulness (state these honestly in output)
- No real TF-IDF/embedding retrieval index, no sentence encoder, no persistent KB object: the
  evidence pack and mind-map are markdown approximations held in working context.
- Perspective discovery uses live search instead of a fixed Wikipedia scrape.
- Moderator novelty-filtering is an LLM judgment over the logged evidence pack, not cosine scoring.

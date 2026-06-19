# Grounding: Sources, Tools, Evidence Rules (Physical AI)

## Source Priority
1. arXiv (cs.RO, cs.LG, cs.AI) and paper PDFs.
2. Official docs and model cards (NVIDIA Isaac / Omniverse / GR00T / Cosmos, HF LeRobot, DeepMind, etc.).
3. Official GitHub repositories (releases, issues, code).
4. Benchmark leaderboards — EXAMPLES to confirm at runtime, not a frozen authority:
   Open X-Embodiment, CALVIN, RLBench, robosuite, and others. Always confirm the currently
   relevant benchmark(s) for the specific topic via search; do not assume these are definitive.
   If canonical benchmarks cannot be confirmed via search, fall back to the benchmarks cited in
   the primary paper and tag them as Source claim.
5. Technical reports and release notes.
6. High-quality journalism and analyst write-ups.
7. Social posts — useful for discovering a claim, never final evidence.

## Tool Mapping
- External search: `WebSearch`, `WebFetch`.
- Library / SDK docs: `context7`.
- Grounding-sweep subagents: `Explore`, `document-specialist`, `general-purpose` (parallel).
- Local opt-in (only when the user enables it): read `arxive/`, `benchmark/`, `robots/` in the
  working directory and project memory. Local material may be stale — treat it as a lead, and
  confirm currency against external sources.

## Evidence Rules
- Tag important claims: `Verified fact | Source claim | Reasonable inference | Speculation`.
- Citations must be real and resolvable. The peer-review phase fact-checks that each cited source
  actually supports the claim it is attached to (this is where source bias and fact
  misassociation get caught).

## When Verification Is Required
Required whenever the topic involves: current events, recent papers, GitHub repos, technical
docs, product capabilities, benchmarks, financial data, regulations, or safety-sensitive claims —
i.e., anything likely to have changed recently.

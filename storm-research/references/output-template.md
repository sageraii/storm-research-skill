# Output Template (STORM + Co-STORM article)

The saved artifact (`./storm-research/YYYY-MM-DD-<topic-slug>.md`) is a sourced, Wikipedia-style
long-form article ending with a Debates section, a References list, and a Reliability & Review
appendix. The chat summary points to the file and gives a 4-6 line digest.

## Article Skeleton

```text
# <Topic> — Research Article
_Seed pack: [physical-ai|generic] · Sources: [external|external+local] · Date: YYYY-MM-DD_
_Method: STORM + Co-STORM-style (perspective discovery → grounded conversation + moderator →
outline/mind-map → sectioned writing). NOT the official Stanford STORM system; retrieval and
knowledge base are prompt/agent approximations. Verify before relying on it._

## Summary
[Lead section, written last. ≤4 short paragraphs: what the topic is, context, why it matters,
and the key controversies. Inline citations [n] as needed.]

## <Section 1 from the outline>
[Encyclopedic prose drawn only from the evidence pack, with inline [n] citations.]

### <Subsection if a node was expanded>
[...]

## <Section 2 ...>
[...]

## Debates & Open Questions
[Where sources/perspectives genuinely conflict: each conflict with both sides + citations; the one
question that would resolve the biggest conflict; the field-level blind spot the moderator surfaced.]

## References
[1] Title · author/venue · date · link
[2] ...
(every [n] used in the body must resolve here, to a real source)
```

## Reliability & Review (appendix — separate-lane self-critique)

```text
# Reliability & Review
_Independent critique pass — not the article's author voice. Patches STORM's lack of self-critique._

## Confidence by claim
- <main claim>: <1-10> — <reason>
  (repeat for each major claim)

## Weakest link
Least-supported claim + exactly what would verify it.

## Bias check
Which perspective dominated; note where convergence is ~independent vs. overlapping evidence lines.

## Missing perspective
One perspective not discovered in Phase 1 and how it would change the article.

## Citation fact-check
Spot-check that cited sources support their claims; flag any that do not; confirm inference-tagged
claims are not presented as fact.
```

## Quality Checklist (final self-check)
Each item notes the phase where it is satisfied.
- [ ] (Phase 1) Perspectives were DISCOVERED from analogous sources, not just the fixed seed pack.
- [ ] (Phase 2) Every expert answer is grounded in retrieved sources; nothing asserted without a source.
- [ ] (Phase 2) A moderator turn surfaced at least one retrieved-but-unused angle (blind-spot engine).
- [ ] (Phase 3) Outline was built in two passes (structural prior → conversation-refined) with a node→evidence mind-map.
- [ ] (Phase 4) Article is sectioned with inline numbered citations `[n]`; every `[n]` resolves in References.
- [ ] (Phase 5) Lead/summary written last; dedup pass preserved all citations and sections.
- [ ] (Phase 6) Debates & Open Questions section present with both sides + the resolving question.
- [ ] (Phase 6) Reliability & Review appendix present as a separate-lane critique (confidence, weakest link, bias, missing perspective, citation fact-check).
- [ ] (Phases 0–7) Calibrated language (reduce/catch, not prevent/block/guarantee).
- [ ] (Phase 0/7) Stated this is NOT the official Stanford STORM system, and that retrieval/KB are approximations.
- [ ] (Phase 2) Uncertain claims tagged (Verified fact / Source claim / Reasonable inference / Speculation).
- [ ] (Phase 1) Verified current/technical claims against real sources when required.

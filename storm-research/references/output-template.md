# Output Template

The saved artifact (`./storm-research/YYYY-MM-DD-<topic-slug>.md`) and the chat summary must
together cover all 9 elements: (1) five perspectives, (2) contradiction map, (3) synthesis
briefing, (4) peer review, (5) confidence scores, (6) weakest link, (7) missing perspective,
(8) actionable insight for the user's role, (9) frontier question.

## Briefing Skeleton

```text
# Research Briefing: [Topic]
_Persona pack: [physical-ai|generic] · Sources: [external|external+local] · Date: [YYYY-MM-DD]_
_Not the official Stanford STORM system._

## Perspectives
### 1..5 [persona name]
Core position / Strongest evidence (cite) / Unique insight

## Contradiction Map
Direct conflicts / Strongest & weakest evidence / Resolving question / Shared agreement / Field blind spot

## Synthesis
1. One-paragraph CEO summary
2. Five key findings ranked by reliability (supported by / challenged by + citation each)
3. Hidden connection
4. Actionable insight for [user role]
5. Frontier question
```

## Peer-Review Skeleton (separate verifier)

```text
# Peer Review
1. Confidence scores (1-10 per finding, with reason)
2. Weakest link (+ what would verify it)
3. Bias check (overrepresented perspective?)
4. Missing 6th perspective (+ how it would change conclusions)
5. Citation fact-check (do cited sources support their claims?)
6. Overall grade + what to fix
```

## Quality Checklist (final self-check)
Each item notes the phase where it is satisfied.
- [ ] (Phase 4) Avoided a single majority-view answer.
- [ ] (Phase 2) Included all five expert perspectives, each with core position + cited evidence + unique insight.
- [ ] (Phase 3) Mapped real contradictions (specific clashing claims), not just summaries.
- [ ] (Phase 3) Identified strongest and weakest evidence.
- [ ] (Phase 3) Identified shared agreement and a field blind spot.
- [ ] (Phase 4) Produced a CEO-ready one-paragraph summary.
- [ ] (Phase 4) Ranked five findings by reliability with support/challenge attribution.
- [ ] (Phase 4) Gave an actionable insight for the user's role and a frontier question.
- [ ] (Phase 5) Ran peer review in a separate lane with 1-10 confidence scores.
- [ ] (Phase 5) Identified the weakest link and a missing sixth perspective.
- [ ] (Phase 5) Fact-checked that citations support their claims.
- [ ] (Phases 0–6) Used calibrated language (reduce/catch, not prevent/block/guarantee).
- [ ] (Phase 6) Stated this is NOT the official Stanford STORM system.
- [ ] (Phase 1) Verified current/technical claims against real sources when required.

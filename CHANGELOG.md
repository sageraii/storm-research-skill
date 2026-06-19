# Changelog

## v1.1.0 — 2026-06-19
STORM + Co-STORM rework. The skill now produces a **sourced, Wikipedia-style long-form article**
instead of a briefing, while keeping the v1.0 critical-analysis strengths as in-article sections.

**Added (from Stanford STORM):**
- Dynamic **perspective discovery** from analogous sources' outlines (replaces fixed personas; the persona packs are now *seed* packs that prime discovery).
- Grounded **writer↔expert simulated conversation** (experts answer only from retrieved sources).
- **Two-pass outline** (structural prior → conversation-refined) + a node→evidence **mind-map**.
- **Sectioned article generation** with inline numbered `[n]` citations + a **References** list.
- **Polish**: lead/summary written last + a faithful dedup pass.

**Added (from Co-STORM):**
- A **moderator** turn that mines retrieved-but-unused evidence to raise blind-spot questions.
- Expert **action taxonomy** (question / further detail / information request / answer) and turn cadence.

**Kept from v1.0.0 (our value-add, now folded into the article):**
- **Debates & Open Questions** section (the contradiction-map value, encyclopedia-style).
- **Reliability & Review** appendix — separate-lane self-critique (confidence, weakest link, bias check, missing perspective, citation fact-check). Patches STORM's documented lack of self-critique.

**Files:** added `references/storm-pipeline.md`; rewrote `SKILL.md` and `references/output-template.md`; `personas-physical-ai.md` / `personas-generic.md` reframed as seed packs; `grounding-physical-ai.md` and `prompt-templates.md` unchanged.

**Honesty:** explicitly states it is not the official Stanford STORM system and that retrieval and the knowledge base are prompt/agent *approximations* of STORM's real infrastructure (no TF-IDF index, no sentence encoder, no persistent KB object).

## v1.0.0 — 2026-06-19
Initial release: grounded multi-perspective research **briefing** (5 personas → contradiction map →
synthesis → separate-lane peer review), tuned by default for Physical AI / robotics, with a generic
persona pack. Package: skill + `install.sh` + README (EN/KO) + MIT license.

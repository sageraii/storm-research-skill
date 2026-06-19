# storm-research — Claude Code Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/sageraii/storm-research-skill/releases)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-7C3AED.svg)](https://docs.claude.com/en/docs/claude-code)
[![Domain](https://img.shields.io/badge/tuned%20for-Physical%20AI%20%2F%20robotics-orange.svg)](#)

**English** | [한국어](README.ko.md)

A **STORM + Co-STORM-inspired** research skill for Claude Code. It turns one topic into a
**sourced, Wikipedia-style long-form article** — discovering perspectives dynamically, running
grounded writer↔expert conversations with a moderator that surfaces blind spots, building an
outline/mind-map, and writing sectioned prose with numbered citations. It then adds two sections
that patch STORM's known gaps: a **Debates & Open Questions** section and a **Reliability & Review**
appendix (self-critique). Tuned by default for **Physical AI / robotics**, with a generic seed pack
for any topic.

> **This is NOT the official Stanford STORM system** (Synthesis of Topic Outlines through Retrieval
> and Multi-perspective Question Asking, Stanford OVAL Lab — https://github.com/stanford-oval/storm).
> It is a prompt/agent-orchestration adaptation of STORM's and Co-STORM's ideas. It **approximates**
> STORM's retrieval index, embedding-based knowledge base, and persistent state with a logged
> evidence pack and an LLM-maintained markdown mind-map — faithful in *method*, not in
> *infrastructure*. Output always requires your own verification.

Version: 1.1.0 · see [CHANGELOG.md](CHANGELOG.md)

---

## What it does

An 8-phase pipeline (see `storm-research/SKILL.md` and `storm-research/references/storm-pipeline.md`):

0. **Scope** — topic, role, goal, seed pack (`physical-ai` | `generic`), local sources on/off, depth.
1. **Perspective discovery** (STORM) — derive topic-specific perspectives from analogous sources' outlines (not fixed personas).
2. **Grounded conversation + moderator** (STORM + Co-STORM) — writer↔expert Q&A answered only from retrieved sources; a moderator mines retrieved-but-unused evidence for blind spots.
3. **Outline + mind-map** (STORM 2-pass + Co-STORM KB) — structural prior → conversation-refined outline, with a node→evidence map.
4. **Article generation** — sectioned prose with inline numbered `[n]` citations + a References list.
5. **Polish** — lead/summary written last + a faithful dedup pass.
6. **Grafted sections** — a **Debates & Open Questions** section + a separate-lane **Reliability & Review** appendix (confidence, weakest link, bias check, missing perspective, citation fact-check).
7. **Output** — saves `./storm-research/YYYY-MM-DD-<topic-slug>.md` and posts a chat summary.

Modes: **article** (default) · **adaptive depth** (scale perspectives/turns to the topic) ·
**prompts-only** (raw prompt scaffolding only — a simplified path that skips Phase 1 discovery).

## Requirements

- Claude Code with skills support (the `Skill` tool / `/skills`).
- For the full pipeline: an environment where Claude can dispatch subagents and use web search/fetch
  tools. Without those, run a shallower single-context pass or **prompts-only** mode.
- No external services, API keys, or Python. Pure markdown orchestration.

## Install

### Quick install from GitHub
```bash
git clone https://github.com/sageraii/storm-research-skill.git
cd storm-research-skill
./install.sh             # personal scope — available in all projects
# or
./install.sh project     # current repository only
```
Then restart Claude Code (or reload skills) and invoke `/storm-research`.

### Option A — Personal skill (every project) · recommended
```bash
./install.sh            # copies to ~/.claude/skills/storm-research
```
or manually: `mkdir -p ~/.claude/skills && cp -R storm-research ~/.claude/skills/`

### Option B — Project skill (one repository)
```bash
./install.sh project     # copies to ./.claude/skills/storm-research
```
or copy `storm-research/` into your repo's `.claude/skills/` and commit it for your team.

### Option C — As a Claude Code plugin (advanced)
Put `storm-research/` under `skills/` in a plugin repo with a `.claude-plugin/plugin.json`
(`name`, `version`, `description`) and a `marketplace.json`, then
`/plugin marketplace add <your-repo>` and `/plugin install storm-research`.

## Usage examples

```
/storm-research
storm-research로 'imitation learning 데이터셋 구축' 장문으로 조사해줘
storm-research로 '<topic>' 분석해줘 (generic 팩, 로컬 포함)
storm-research prompts-only   # raw prompt scaffolding only (skips dynamic discovery)
```

## Local corpus (optional, opt-in)

In Physical AI mode you can let the skill also read a local corpus. Only when you enable it, it
looks (relative to your working directory) for folders named `arxive/`, `benchmark/`, `robots/`
and project memory. These are **relative, opt-in leads** — there are no hardcoded paths, and the
skill works fine with external sources only.

## Package layout

```
storm-research-skill/
├── README.md           (this file)
├── README.ko.md        (한국어)
├── CHANGELOG.md
├── install.sh
├── LICENSE
└── storm-research/      (the skill — drop into .claude/skills/)
    ├── SKILL.md
    └── references/
        ├── storm-pipeline.md        (STORM + Co-STORM operational mechanics)
        ├── personas-physical-ai.md  (Physical AI seed perspectives)
        ├── personas-generic.md      (generic seed perspectives)
        ├── grounding-physical-ai.md (sources, tools, evidence rules)
        ├── output-template.md       (article + References + Debates + Reliability appendix)
        └── prompt-templates.md      (prompts-only mode)
```

## Credits

Inspired by Stanford OVAL Lab's **STORM** (Shao et al., NAACL 2024) and **Co-STORM** (Jiang et al.,
EMNLP 2024), and by the viral "four-prompt" reinterpretation of STORM. This skill is an independent
adaptation, not affiliated with or endorsed by Stanford. License: MIT.

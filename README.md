# storm-research — Claude Code Skill

A STORM-inspired, **grounded multi-perspective research** skill for Claude Code. It turns one
topic into a source-grounded briefing: 5 expert perspectives → contradiction map → synthesis →
separate-lane peer review → saved artifact. Tuned by default for **Physical AI / robotics**, with
a generic persona pack for any other topic.

> **This is NOT the official Stanford STORM system** (Synthesis of Topic Outlines through
> Retrieval and Multi-perspective Question Asking, Stanford OVAL Lab — https://github.com/stanford-oval/storm).
> It is a prompt/agent-orchestration adaptation inspired by STORM's multi-perspective
> question-asking idea. Its output always requires your own verification.

Version: 1.0.0

---

## What it does

A 6-phase pipeline (see `storm-research/SKILL.md`):

0. **Scope** — topic, role, goal, persona pack (`physical-ai` | `generic`), local sources on/off.
1. **Grounding sweep** — parallel search subagents build a shared evidence pack (arXiv / GitHub / docs / benchmarks; optional local corpus).
2. **Multi-perspective scan** — 5 personas, each grounded in the evidence pack.
3. **Contradiction map** — where the perspectives clash, agree, and leave blind spots.
4. **Synthesis** — CEO summary, findings ranked by reliability, actionable insight, frontier question.
5. **Peer review (separate lane)** — confidence scores, weakest link, bias check, 6th perspective, citation fact-check.
6. **Output** — saves `./storm-research/YYYY-MM-DD-<topic-slug>.md` and posts a chat summary.

Modes: **grounded multi-agent** (default), **single-context sequential** (small topics),
**prompts-only** (just the templates).

## Requirements

- Claude Code with skills support (the `Skill` tool / `/skills`).
- For **grounded multi-agent** mode: an environment where Claude can dispatch subagents and use
  web search/fetch tools. Without those, use **single-context** or **prompts-only** mode — the
  skill degrades gracefully.
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

### Option A — Personal skill (available in every project) · recommended
Copy the `storm-research/` folder into your personal skills directory:

```bash
./install.sh            # copies to ~/.claude/skills/storm-research
```
or manually:
```bash
mkdir -p ~/.claude/skills
cp -R storm-research ~/.claude/skills/
```

### Option B — Project skill (one repository only)
```bash
./install.sh project     # copies to ./.claude/skills/storm-research
```
or manually copy `storm-research/` into your repo's `.claude/skills/` directory and commit it so
teammates get it too.

After installing, restart Claude Code (or reload skills). Invoke with `/storm-research` or just
ask: *"storm-research로 <topic> 분석해줘"*.

### Option C — As a Claude Code plugin (advanced, for team distribution)
Put this skill in a git repo as a plugin and install via a marketplace:

```
your-plugin-repo/
├── .claude-plugin/
│   ├── plugin.json          # see snippet below
│   └── marketplace.json     # lists this plugin
└── skills/
    └── storm-research/      # the contents of this package's storm-research/ folder
        ├── SKILL.md
        └── references/
```

`.claude-plugin/plugin.json`:
```json
{
  "name": "storm-research",
  "version": "1.0.0",
  "description": "Grounded multi-perspective STORM-style research briefing, tuned for Physical AI.",
  "author": { "name": "your-name" }
}
```
Then `/plugin marketplace add <your-repo>` and `/plugin install storm-research`.

## Usage examples

```
/storm-research
storm-research로 'sim-to-real 도메인 갭 완화 기법'을 분석해줘
storm-research로 '<topic>' 분석해줘 (generic 팩, 로컬 포함)
storm-research prompts-only   # just return the 4 templates + compact prompt
```

## Local corpus (optional, opt-in)

In Physical AI mode you can let the skill also read a local corpus. It looks (relative to your
working directory, only when you enable it) for folders named `arxive/`, `benchmark/`, `robots/`
and project memory. These are **relative, opt-in leads** — the skill has no hardcoded paths and
works fine with external sources only.

## Package layout

```
storm-research-skill/
├── README.md          (this file)
├── install.sh         (copy skill to personal or project scope)
├── LICENSE
└── storm-research/     (the skill itself — drop into .claude/skills/)
    ├── SKILL.md
    └── references/
        ├── prompt-templates.md
        ├── personas-physical-ai.md
        ├── personas-generic.md
        ├── grounding-physical-ai.md
        └── output-template.md
```

## Credits

Inspired by Stanford OVAL Lab's STORM (Shao et al., NAACL 2024; Jiang et al., EMNLP 2024) and by
the viral "four-prompt" reinterpretation. This skill is an independent adaptation and is not
affiliated with or endorsed by Stanford. License: MIT.

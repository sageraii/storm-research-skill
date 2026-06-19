# storm-research — Claude Code Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/sageraii/storm-research-skill/releases)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-7C3AED.svg)](https://docs.claude.com/en/docs/claude-code)
[![Domain](https://img.shields.io/badge/tuned%20for-Physical%20AI%20%2F%20robotics-orange.svg)](#)

**English** | [한국어](#한국어-korean)

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

---

## 한국어 (Korean)

[English](#storm-research--claude-code-skill) | **한국어**

Claude Code용 **grounded 멀티 관점 리서치** 스킬입니다. 하나의 주제를 출처 기반 브리핑으로 바꿔
줍니다: 5개 전문가 관점 → 모순 지도 → 종합 → 별도 lane peer review → 산출물 저장. 기본값은
**Physical AI / 로보틱스**에 맞춰져 있고, 다른 주제용 generic 페르소나 팩도 포함합니다.

> **공식 Stanford STORM 시스템이 아닙니다** (Stanford OVAL Lab). STORM의 다관점 질문 방식에서
> 영감을 받은 프롬프트/에이전트 오케스트레이션 적응 버전이며, 결과물은 항상 직접 검증이 필요합니다.

### 무엇을 하나 (6단계 파이프라인)
0. **스코프** — 주제·역할·목표·페르소나 팩(`physical-ai`|`generic`)·로컬 소스 on/off
1. **Grounding 스윕** — 병렬 검색 에이전트가 공유 증거팩 구성 (arXiv/GitHub/문서/벤치마크, 선택적 로컬)
2. **다관점 스캔** — 증거팩에 grounding된 5개 페르소나
3. **모순 지도** — 관점 간 충돌·합의·사각지대
4. **종합** — CEO 요약, 신뢰도순 발견, 실행 인사이트, 프런티어 질문
5. **Peer review (별도 lane)** — 신뢰도 점수, 약한 고리, 편향 점검, 6번째 관점, 인용 사실검증
6. **출력** — `./storm-research/YYYY-MM-DD-<주제>.md` 저장 + 채팅 요약

모드: **grounded 멀티에이전트**(기본), **단일 컨텍스트**(작은 주제), **prompts-only**(템플릿만).

### 설치
```bash
# GitHub에서 바로
git clone https://github.com/sageraii/storm-research-skill.git
cd storm-research-skill
./install.sh             # 개인 스코프 (~/.claude/skills, 모든 프로젝트)
# 또는
./install.sh project     # 프로젝트 스코프 (현재 repo의 .claude/skills)
```
수동 설치: `cp -R storm-research ~/.claude/skills/` · 설치 후 Claude Code 재시작 → `/storm-research`

### 사용 예
```
/storm-research
storm-research로 'sim-to-real 도메인 갭 완화 기법'을 분석해줘
storm-research prompts-only      # 4개 템플릿 + 통합 프롬프트만 반환
```

### 로컬 코퍼스(선택)
Physical AI 모드에서 작업 디렉터리 기준 `arxive/`·`benchmark/`·`robots/` 폴더와 프로젝트 메모리를
**opt-in**으로 참조할 수 있습니다(하드코딩 경로 없음, 외부 소스만으로도 동작).

### 크레딧 / 라이선스
Stanford STORM(Shao et al., NAACL 2024; Jiang et al., EMNLP 2024)과 바이럴 "4프롬프트" 재해석에서
영감을 받은 독립 적응 버전이며 Stanford와 무관합니다. 라이선스: MIT.

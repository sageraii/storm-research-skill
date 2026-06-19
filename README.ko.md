# storm-research — Claude Code 스킬

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/sageraii/storm-research-skill/releases)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-7C3AED.svg)](https://docs.claude.com/en/docs/claude-code)
[![Domain](https://img.shields.io/badge/tuned%20for-Physical%20AI%20%2F%20robotics-orange.svg)](#)

[English](README.md) | **한국어**

**STORM + Co-STORM에서 영감을 받은** Claude Code 리서치 스킬입니다. 주제 하나를 **출처가 달린
위키피디아式 장문 기사**로 만들어 줍니다 — 관점을 그때그때 발견하고, 검색에 근거한 작성자↔전문가
대화를 돌리며, 사각지대를 들춰내는 moderator를 거쳐, outline/mind-map을 세우고, 번호 인용이 달린
섹션 글을 씁니다. 여기에 STORM의 약점을 메우는 두 섹션을 더합니다 — **Debates & Open Questions**
(쟁점)와 **Reliability & Review** 부록(자기비평). 기본값은 **Physical AI / 로보틱스**에 맞춰져
있고, 다른 주제용 generic seed 팩도 포함합니다.

> **공식 Stanford STORM 시스템이 아닙니다** (Synthesis of Topic Outlines through Retrieval and
> Multi-perspective Question Asking, Stanford OVAL Lab — https://github.com/stanford-oval/storm).
> STORM과 Co-STORM의 아이디어를 프롬프트/에이전트 오케스트레이션으로 옮긴 버전입니다. STORM의
> 검색 인덱스·임베딩 기반 지식베이스·영속 상태를 **로그된 evidence pack과 LLM이 유지하는 마크다운
> mind-map으로 근사**합니다 — *방식*은 충실하나 *인프라*는 근사입니다. 결과물은 언제나 직접
> 검증해야 합니다.

버전: 1.1.0 · [CHANGELOG.md](CHANGELOG.md) 참고

---

## 무엇을 하나

8단계 파이프라인입니다 (`storm-research/SKILL.md`, `references/storm-pipeline.md`):

0. **스코프** — 주제·역할·목표·seed 팩(`physical-ai` | `generic`)·로컬 소스 on/off·깊이
1. **관점 발견** (STORM) — 고정 페르소나가 아니라, 유사 자료의 목차에서 주제별 관점을 도출
2. **근거 대화 + moderator** (STORM + Co-STORM) — 작성자↔전문가 Q&A(전문가는 검색 결과로만 답변), moderator가 검색됐으나 미사용된 증거에서 사각지대 질문 발굴
3. **Outline + mind-map** (STORM 2-pass + Co-STORM KB) — 구조 초안 → 대화로 정제, 노드→증거 매핑
4. **기사 생성** — 번호 인용 `[n]`이 달린 섹션 글 + References 목록
5. **Polish** — lead 요약을 마지막에 작성 + 충실한 중복 제거
6. **추가 섹션** — **Debates & Open Questions** 섹션 + 별도 lane **Reliability & Review** 부록(신뢰도·약한 고리·편향 점검·누락 관점·인용 사실검증)
7. **출력** — `./storm-research/YYYY-MM-DD-<주제-슬러그>.md` 저장 + 채팅 요약

모드: **article**(기본) · **adaptive depth**(주제에 맞춰 관점·턴 수 조절) ·
**prompts-only**(원시 프롬프트만 — Phase 1 발견을 건너뛰는 간이 경로)

## 요구 사항

- 스킬을 지원하는 Claude Code (`Skill` 도구 / `/skills`)
- 전체 파이프라인을 쓰려면 Claude가 서브에이전트를 띄우고 웹 검색·페치 도구를 쓸 수 있는 환경이어야
  합니다. 그렇지 않으면 단일 컨텍스트로 얕게 돌리거나 **prompts-only** 모드를 쓰세요.
- 외부 서비스·API 키·Python이 필요 없습니다. 순수 마크다운 오케스트레이션입니다.

## 설치

```bash
# GitHub에서 바로
git clone https://github.com/sageraii/storm-research-skill.git
cd storm-research-skill
./install.sh             # 개인 스코프 — 모든 프로젝트에서 사용
# 또는
./install.sh project     # 현재 저장소에만
```
수동 설치: `cp -R storm-research ~/.claude/skills/` · 설치 후 Claude Code 재시작 → `/storm-research`

플러그인으로 쓰려면 `storm-research/`를 플러그인 repo의 `skills/` 아래에 두고
`.claude-plugin/plugin.json`·`marketplace.json`을 추가한 뒤 `/plugin install` 하면 됩니다.

## 사용 예

```
/storm-research
storm-research로 'imitation learning 데이터셋 구축' 장문으로 조사해줘
storm-research로 '<주제>' 분석해줘 (generic 팩, 로컬 포함)
storm-research prompts-only   # 원시 프롬프트만 (동적 발견 생략)
```

## 로컬 코퍼스 (선택, opt-in)

Physical AI 모드에서, 사용자가 켰을 때만 작업 디렉터리 기준으로 `arxive/`·`benchmark/`·`robots/`
폴더와 프로젝트 메모리를 참조합니다. **상대 경로 기반 opt-in 참고 자료**일 뿐이며(하드코딩 경로
없음), 외부 소스만으로도 문제없이 동작합니다.

## 패키지 구성

```
storm-research-skill/
├── README.md           (영문)
├── README.ko.md        (이 문서)
├── CHANGELOG.md
├── install.sh
├── LICENSE
└── storm-research/      (스킬 본체 — .claude/skills/ 에 넣으세요)
    ├── SKILL.md
    └── references/
        ├── storm-pipeline.md        (STORM + Co-STORM 운영 메커니즘)
        ├── personas-physical-ai.md  (Physical AI seed 관점)
        ├── personas-generic.md      (generic seed 관점)
        ├── grounding-physical-ai.md (소스·도구·증거 규칙)
        ├── output-template.md       (기사 + References + Debates + Reliability 부록)
        └── prompt-templates.md      (prompts-only 모드)
```

## 크레딧

Stanford OVAL Lab의 **STORM**(Shao et al., NAACL 2024)과 **Co-STORM**(Jiang et al., EMNLP 2024),
그리고 STORM을 재해석한 바이럴 "4프롬프트" 글에서 영감을 받았습니다. 독립적으로 만든 적응 버전이며
Stanford와 무관합니다. 라이선스: MIT.

## storm-research v1.0.0

STORM에서 영감을 받은 **출처 기반 다관점 리서치** 스킬입니다. 기본값은 **Physical AI / 로보틱스**에
맞춰져 있고, 다른 주제에 쓸 수 있는 generic 페르소나 팩도 함께 들어 있습니다.

> 공식 Stanford STORM 시스템이 아닙니다. STORM의 다관점 질문 방식에서 아이디어만 빌려 온 독립
> 적응 버전이며, 결과물은 언제나 직접 검증해야 합니다.

### 설치
```bash
git clone https://github.com/sageraii/storm-research-skill.git
cd storm-research-skill
./install.sh             # ~/.claude/skills (모든 프로젝트)  ·  또는: ./install.sh project
```
또는 아래 `storm-research-skill.zip`을 받아 압축을 풀고 `./install.sh`를 실행하세요.
설치한 뒤 Claude Code를 재시작(또는 스킬 새로고침)하고 `/storm-research`로 호출합니다.

### 구성
- **6단계 파이프라인:** 스코프 → grounding 스윕 → 근거 있는 5개 관점 → 모순 지도 → 종합 → 별도 lane peer review → 브리핑 저장 (`./storm-research/<날짜>-<주제>.md`).
- **Physical AI 페르소나 팩** (Sim-to-Real, Foundation-Model, 벤치마크 회의론자, 하드웨어/임바디먼트, 생태계 분석가 + 로보틱스 역사가)과 전환 가능한 **generic** 팩.
- **모드:** grounded 멀티에이전트(기본) · 단일 컨텍스트 · prompts-only.
- 과장을 걸러 내는 캘리브레이션·환각 방지 정직성 규칙 적용. 외부 서비스나 API 키가 필요 없습니다.

### English
A STORM-inspired, grounded multi-perspective research skill for Claude Code (default: Physical AI
/ robotics, with a generic pack). Install: download the zip below and run `./install.sh`, or use
the `git clone` above → restart Claude Code → `/storm-research`. **Not the official Stanford
STORM system** — output always requires your own verification.

**전체 문서:** [README (영문)](https://github.com/sageraii/storm-research-skill#readme) ·
[README (한국어)](https://github.com/sageraii/storm-research-skill/blob/main/README.ko.md)

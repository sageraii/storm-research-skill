# Prompt Templates

Two forms are preserved: four sequential templates (used by the orchestrated pipeline) and one
combined Compact Execution Prompt (for users who want a single paste). In grounded multi-agent
mode the orchestrator injects the shared evidence pack into Prompt 1 and carries each phase's
output into the next; the template text itself is unchanged.

## Prompt 1 — Multi-Perspective Scan

```text
I need to research [YOUR TOPIC].

Simulate 5 different expert perspectives on this topic:

1. THE PRACTITIONER: works with this daily.
What do they know that academics miss?
What practical realities are usually ignored?

2. THE ACADEMIC: has studied this for years.
What does the peer reviewed evidence actually say?
Where does the evidence contradict popular belief?

3. THE SKEPTIC: thinks the mainstream view is wrong.
What is the strongest counterargument?
What evidence do proponents conveniently ignore?

4. THE ECONOMIST: follows the money.
Who profits from the current narrative?
What financial incentives shape the research?

5. THE HISTORIAN: has seen similar patterns before.
What historical parallels exist?
What can we learn from how those played out?

For each perspective give me:
- Their core position in 2 sentences
- The strongest evidence supporting their view
- The one thing they would tell me that no other perspective would
```

When the Physical AI persona pack is active, substitute the five personas from
`personas-physical-ai.md` while keeping the same three-part output contract.

## Prompt 2 — Contradiction Map

```text
Based on the 5 perspectives above, map the contradictions:

1. Where do two or more perspectives directly contradict each other?
List each conflict with the specific claims that clash.

2. Which perspective has the strongest evidence?
Which has the weakest? Why?

3. What is the one question that, if answered, would resolve the biggest contradiction?

4. What does EVERY perspective agree on?
This is likely true. Even opponents confirm it.

5. What topic did NONE of the perspectives address?
This is the blind spot in the whole field. Often the most valuable finding.
```

## Prompt 3 — Synthesis

```text
Synthesize everything from the 5 perspectives and the contradiction map into a research briefing:

1. THE ONE PARAGRAPH SUMMARY:
Explain this topic as if briefing a CEO who has 60 seconds and needs nuance, not just the headline.

2. THE 5 KEY FINDINGS:
Most important things I now know, ranked by reliability.
For each, note which perspectives support it and which challenge it.

3. THE HIDDEN CONNECTION:
One non obvious link between findings that only shows up when you look at all 5 perspectives together.

4. THE ACTIONABLE INSIGHT:
Based on all the evidence, what should someone in [YOUR ROLE] actually DO differently?
Be specific.

5. THE FRONTIER QUESTION:
The one question that, if answered, would change everything about how we understand this topic.
```

## Prompt 4 — Peer Review

```text
Now peer review your own research briefing:

1. CONFIDENCE SCORES:
Rate each of the 5 key findings on a 1 to 10 scale for reliability.
Explain each score.

2. WEAKEST LINK:
Which claim are you least confident in?
What specific info would you need to verify it?

3. BIAS CHECK:
Which perspective might be overrepresented in your synthesis?
Did one voice dominate?

4. MISSING PERSPECTIVE:
Is there a 6th angle I should have included that would change the conclusions?

5. OVERALL GRADE:
If a Stanford professor reviewed this briefing, what grade would they give and why?
What would they tell me to fix?
```

In the orchestrated pipeline this prompt is run by a SEPARATE verifier subagent (not the same
context that produced the synthesis) and additionally fact-checks that each cited source actually
supports its claim.

## Compact Execution Prompt

Use this when the user wants a single combined prompt instead of the full orchestrated skill.

```text
I need to research [YOUR TOPIC].
My role is [YOUR ROLE].

Use a STORM-style four-prompt research workflow.

First, simulate 5 different expert perspectives:
1. THE PRACTITIONER: works with this daily.
2. THE ACADEMIC: has studied this for years.
3. THE SKEPTIC: thinks the mainstream view is wrong.
4. THE ECONOMIST: follows the money.
5. THE HISTORIAN: has seen similar patterns before.

For each perspective give me:
- Their core position in 2 sentences
- The strongest evidence supporting their view
- The one thing they would tell me that no other perspective would

Second, map the contradictions:
- Where do two or more perspectives directly contradict each other?
- Which perspective has the strongest evidence?
- Which has the weakest evidence?
- What one question would resolve the biggest contradiction?
- What does every perspective agree on?
- What topic did none of the perspectives address?

Third, synthesize everything into a research briefing:
- One paragraph summary for a CEO with 60 seconds
- Five key findings ranked by reliability
- Which perspectives support and challenge each finding
- One hidden connection
- One actionable insight for someone in my role
- One frontier question

Finally, peer review your own briefing:
- Confidence scores from 1 to 10 for each key finding
- Weakest link
- Bias check
- Missing sixth perspective
- Overall grade from a Stanford professor and what they would tell me to fix

If the topic requires factual grounding, verify important claims with reliable sources and
separate verified facts from source claims, inferences, and speculation.
```

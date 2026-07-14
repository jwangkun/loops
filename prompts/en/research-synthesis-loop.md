---
name: "research-synthesis-loop"
description: "Synthesize multi-source research into key insights"
---

# Research Synthesis Loop

**Category:** Learning & Knowledge
**Slug:** `research-synthesis-loop`
**Max Iterations:** 15

## Goal

Synthesize a structured research report from multiple sources, capturing consensus, disagreement, and key insights, with a citation on every claim. The synthesis must stay faithful to the sources, stay traceable, and explicitly flag evidence strength.

## When to Use

When you need to fold a batch of papers, web pages, or interviews into a single citable synthesis report.

## Check Command

```bash
python scripts/research_check.py
```

## Exit Condition

- Check script exits 0.
- The synthesis covers every included source.
- Each key claim carries a traceable citation.
- No unverified or over-generalized assertions remain.

## Steps

Step 1: Run the check command and capture the list of uncovered sources, uncited claims, and under-evidenced items.
Step 2: Locate defects: which sources are not yet incorporated, which claims lack citations, whether a single source has been generalized into a universal conclusion, whether genuine disagreements have been flattened.
Step 3: Make the smallest fix: restore traceable citations to claims, separate fact from interpretation, flag evidence strength and source reliability; never fabricate content not present in the sources.
Step 4: Re-run the check; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining blockers (e.g., unverifiable sources, mutually contradictory raw data); never loop forever.

## Common Pitfalls

- Citing sources you did not personally verify (hearsay passed as fact).
- Generalizing a single source's narrow view into a universal conclusion.
- Flattening genuine disagreement between sources into false consensus.
- Drawing inferences beyond what the evidence supports (over-generalizing).

## Notes

- Every claim must trace back to an original source; never cite from memory.
- Explicitly distinguish fact, interpretation, and speculation.
- Flag each source's reliability and evidence strength.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

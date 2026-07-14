---
name: "blog-post-until-publish"
description: "blog post polished and ready to publish"
---

# Blog Post Until Publish

**Category:** Content Creation
**Slug:** `blog-post-until-publish`
**Max Iterations:** 8

## Goal

Bring the draft to publishable quality: clear structure, precise wording, SEO-friendly, and factually sound. Success means the check command returns a quality score at or above the threshold, with no hard violations.

## When to Use

Use when a draft needs systematic polishing rather than one-shot writing; ideal for the final gate on structure, readability, SEO, and factual accuracy before publishing.

## Check Command

```bash
python scripts/blog_quality.py draft.md
```

## Exit Condition

- The check command returns a quality score at or above the set threshold.
- No unresolved hard violations (e.g., duplicate content, empty headings, broken links, overlong paragraphs).

## Steps

Step 1: Run the check command, capturing the quality score and the detail of every violation.
Step 2: Analyze violations by impact—distinguish structural flaws (missing subheadings/broken logic), readability issues (run-on sentences/jargon), SEO problems (missing or stuffed keywords), and factual problems (suspect citations/figures).
Step 3: Make the smallest effective revision: prioritize hard violations; fix one independently verifiable issue per iteration and avoid large rewrites that introduce new errors.
Step 4: Re-run the check command; if still below threshold and under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining major issues and the current score for human judgment; never loop forever.

## Common Pitfalls

- Stuffing keywords to raise the score, which hurts readability and natural tone.
- Masking factual emptiness with flowery language, inflating the score without substance.
- Rewriting the same paragraph repeatedly while ignoring structural problems, getting stuck in a local optimum.
- Blindly gaming the checker's word-count and heading rules at the expense of the article's real logic.

## Notes

- Never fabricate citations, data, or case studies; flag or remove uncertain facts.
- Preserve the author's intent and voice; polishing is not rewriting.
- Keep a traceable draft version after each revision.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

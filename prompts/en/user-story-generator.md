---
name: "user-story-generator"
description: "qualified user stories for every feature"
---

# User Story Generator

**Category:** Product & Design
**Slug:** `user-story-generator`
**Max Iterations:** 15

## Goal

Generate an INVEST-compliant user story with verifiable acceptance criteria for every feature in the backlog, all passing `story_check.py`. Each pass makes only the minimal edits to stories that fail — splitting oversized ones, adding acceptance criteria, stripping implementation detail — rather than rewriting the batch. Success means every feature is covered by a qualified story.

## When to Use

During requirements breakdown, sprint planning, or backlog refinement, especially when delivering to engineering or under explicit acceptance gates.

## Check Command

```bash
python scripts/story_check.py
```

## Exit Condition

- `story_check.py` exits 0 with all stories passing.
- Every feature is covered by at least one INVEST-compliant story.
- Each story has verifiable acceptance criteria.

## Steps

Step 1: Run the check and capture the full output (features without stories, oversized stories, missing acceptance criteria, implementation disguised as story).
Step 2: Analyze each failure: separate uncovered features, oversized stories (violating INVEST's N/S), missing or unverifiable acceptance criteria, and technical tasks written as user stories; localize to the specific feature and cause.
Step 3: Fix that story minimally — split an oversized one, add verifiable acceptance criteria, rewrite to be implementation-neutral — rather than rewriting wholesale.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report remaining blockers (feature, story, missing item); do not loop forever.

## Common Pitfalls

- Stories missing acceptance criteria, so "done" cannot be judged.
- Stories too large, violating INVEST's negotiability and smallness, hard to finish in one iteration.
- Disguising implementation detail as story ("use Redis for caching…"), locking the technical approach.
- Unclear user value, so stories read like tasks rather than "as X, I want Y, so that Z".

## Notes

- Base stories on the feature list from the requester; confirm scope-unclear features first, do not assume.
- Acceptance criteria must be verifiable; avoid subjective phrasing like "smooth experience".
- Keep stories implementation-neutral; leave technical choices to the engineering discussion.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

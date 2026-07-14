---
name: "prd-review-loop"
description: "PRD is complete, clear, dev-ready"
---

# PRD Review Loop

**Category:** Product & Design
**Slug:** `prd-review-loop`
**Max Iterations:** 6

## Goal

Bring the PRD to a fully passing state on `prd_check.py` across completeness, clarity, and implementability — ready for development to start. Each pass makes only the minimal fixes reported by the check — filling missing sections, adding acceptance criteria to requirements, removing ambiguity — rather than a full rewrite. Success means all review checks pass.

## When to Use

Before finalizing a PRD, at requirements review, or when handing off to engineering, especially for new features, cross-team dependencies, or acceptance-gate requirements.

## Check Command

```bash
python scripts/prd_check.py
```

## Exit Condition

- `prd_check.py` exits 0 with all review checks passing.
- Every requirement has verifiable acceptance criteria.
- Key sections (background, scope, non-goals, dependencies) are present with no blanks.

## Steps

Step 1: Run the check and capture the full output (missing sections, requirements without acceptance criteria, ambiguous wording, undefined scope).
Step 2: Analyze each failure: separate missing sections, requirements lacking acceptance criteria, undefined boundaries/non-goals, and unstated dependencies/risks; localize to the specific location and cause.
Step 3: Fix that spot minimally — add a section, attach verifiable acceptance criteria to a requirement, clarify non-goals — rather than rewriting wholesale.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report remaining blockers (section, requirement, missing item); do not loop forever.

## Common Pitfalls

- Writing requirements without acceptance criteria, so dev and QA cannot tell when "done".
- Leaving scope and non-goals undefined, causing gold-plating or scope creep.
- Writing implementation as requirement, prematurely locking technical choices.
- Not listing dependencies, constraints, and risks explicitly, so downstream teams hit landmines.

## Notes

- Base requirements on facts and goals from the requester; confirm missing information first, do not assume.
- Acceptance criteria must be verifiable; avoid subjective phrasing like "feels good".
- Keep changes traceable; material scope changes must go back through review.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

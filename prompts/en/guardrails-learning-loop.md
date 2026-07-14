---
name: "guardrails-learning-loop"
description: "Checks pass without repeating past failures"
---

# Guardrails Learning Loop

**Category:** Development Process
**Slug:** `guardrails-learning-loop`
**Max Iterations:** 5

## Goal

Make tests and lint pass without introducing any failure pattern already recorded in `guardrails.md`. Each repeat failure must be turned into a reusable rule written back to `guardrails.md`.

## When to Use

A `guardrails.md` exists that records historical pitfalls and rules, and the fix process must keep learning and avoid repeating the same mistakes.

## Check Command

```bash
npm test && npm run lint
```

## Exit Condition

- The check command exits 0; tests and lint all pass.
- This failure does not repeat any pattern already recorded in `guardrails.md`.

## Steps

Step 1: Read `guardrails.md` and understand the existing failure patterns and avoidance rules.
Step 2: Run the check command, capture the failure, and compare it against historical patterns to decide whether it is a repeat.
Step 3: Make the smallest fix; if it is a repeat failure, prefer the approach given by the historical rule instead of starting over.
Step 4: Re-run the check command; if still failing and under max iterations, append the new failure pattern to `guardrails.md` and go to Step 2.
Step 5: If max iterations are hit without success, stop and report the unresolved failure and any new guardrails entries; never loop forever.

## Common Pitfalls

- The same class of failure keeps recurring but no rule is ever captured, leaving `guardrails.md` empty or stale.
- "Greening" lint by ignoring/skipping errors instead of actually fixing them.
- Recording rules that are too vague (e.g. "watch out for null pointers") to guide the next decision.

## Notes

- Every rule in `guardrails.md` must be actionable (trigger condition + correct approach).
- Do not disable or downgrade tests and lint rules just to pass the check.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

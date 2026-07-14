---
name: "spec-first-ship"
description: "every requirement in spec.md is implemented and checked"
---

# Spec-First Ship

**Category:** CI/CD  
**Slug:** `spec-first-ship`  
**Max Iterations:** 20

## Goal

Implement, verify, and check off every requirement listed in spec.md so the requirement list stays in full sync with the code state. On completion, no requirement item remains unchecked and the tests are green.

## When to Use

Use when a requirements document (spec.md) is the single source of truth. Each iteration advances the next unchecked item, preventing feature drift or missed delivery.

## Check Command

```bash
npm test
```

## Exit Condition

All requirement items in spec.md are checked [x], and the check command exits 0.

## Steps

Step 1: Read spec.md and find the first unchecked item (marked [ ]); clarify its acceptance criteria.
Step 2: Implement that item with the smallest possible change, touching only files relevant to it; do not implement later items early.
Step 3: Run the check command; on failure, isolate the first failing case and fix it; never skip or xdescribe around it.
Step 4: Once green, change the item in spec.md from [ ] to [x] and record how it was verified (command/case).
Step 5: If unchecked items remain and under 20 iterations, return to Step 1; if 20 iterations are reached with unfinished items, stop and list the remaining items; do not loop forever.

## Common Pitfalls

- Quietly checking off unimplemented items: using a tick to hide an empty implementation, making the list untrustworthy.
- Packing multiple items per iteration: too many changes at once, making regressions hard to locate.
- Skipping failing tests: using skip/xdescribe to work around them, breaking the "tests = acceptance" contract.
- Implementing on guesses when requirements are vague: starting without clear acceptance criteria, drifting off target.

## Notes

- spec.md is the single source of truth; when code and doc conflict, defer to the acceptance criteria rather than editing the doc arbitrarily.
- One iteration handles exactly one requirement item, keeping the diff small and reviewable.
- Ticking requires running the check command and actually passing; "should be fine" is not acceptable.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

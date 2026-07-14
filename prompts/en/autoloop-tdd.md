---
name: "autoloop-tdd"
description: "implement target behavior incrementally, test-first"
---

# Autoloop TDD

**Category:** Development Process
**Slug:** `autoloop-tdd`
**Max Iterations:** 20

## Goal

Incrementally implement target behavior through strict test-first (red-green-refactor) cycles until all relevant tests pass with no regressions. Each iteration targets a single not-yet-implemented behavior, keeping the codebase always working.

## When to Use

Implementing a new feature from a behavior description or acceptance criteria; when adding behavior to existing code, drive each behavior one at a time with a failing test instead of backfilling tests afterward.

## Check Command

```bash
npm test
```

## Exit Condition

- All tests for the target behaviors pass.
- No new failures or regressions introduced.
- The check command exits with code 0.

## Steps

Step 1: Run the check command, capture full output, and identify which behaviors are not yet passing or missing tests.
Step 2: Pick the next smallest unimplemented behavior and write a failing test first; confirm the failure is "behavior not implemented" rather than a syntax error or a miswritten assertion.
Step 3: Write the minimal implementation that makes exactly that test pass; do not anticipate future needs or add design not driven by a test.
Step 4: Re-run the check command; if behaviors still fail and max iterations is not reached, go to Step 2; if all pass, proceed to refactor.
Step 5: If max iterations is reached without implementing the target behavior, stop and report the remaining failing tests and blockers; never loop forever or paper over failures with stubs.

## Common Pitfalls

- Writing implementation first and tests after: this is not TDD; the test merely restates the implementation instead of describing behavior.
- Large-scale refactoring during red: changing many things while tests fail taints the failure cause.
- One test covering multiple behaviors: failures become unlocalizable; split into the smallest behavior units.

## Notes

- Refactor only when all tests are green, and never change external behavior.
- Do not delete or weaken assertions just to make a test pass.
- Preserve a clean red → green → refactor boundary on every commit.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "test-until-green"
description: "Fix failing tests until the suite is fully green"
---

# Test Until Green

**Category:** Testing
**Slug:** `test-until-green`
**Max Iterations:** 10

## Goal

Make the full test suite pass in a single complete run with exit code 0. Success means the real root cause of each failure is fixed — never skipped, commented out, or weakened assertions. Each iteration addresses only the smallest real defect.

## When to Use

After a commit or refactor, when unit/integration tests fail locally or in CI and you must restore green fast without sacrificing test integrity.

## Check Command

```bash
npm test
```

## Exit Condition

- `npm test` exits 0.
- All cases pass with no skips, todos, or unhandled `console.error`.
- Max iterations not reached.

## Steps

Step 1: Run `npm test`, fully capturing stdout/stderr and the exit code.
Step 2: Analyze each failure: locate the assertion, error stack, related source and test code; decide whether it is a product defect or a test defect.
Step 3: Make the smallest real fix — fix product code or correct the test itself (only when the test is wrong); never mask failures via `skip`, narrowed assertions, fake data, or try/catch swallowing.
Step 4: Re-run `npm test`; if failures remain and under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and list remaining failures, fixes attempted, and suspected root causes; never loop forever.

## Common Pitfalls

- Misjudging a real failure as flaky: one failure is not enough to call something flaky; root-cause it as a real failure first.
- Changing correct product behavior just to make a test pass: confirm whether expected behavior actually changed.
- Implicit inter-test dependencies (shared files, globals, ordering) — passes in isolation, fails in the full run.

## Notes

- Do not achieve green by disabling, skipping, or weakening tests.
- Change only the minimal scope per iteration to avoid regressions.
- Update expectations only when genuinely outdated, and state the reason; never silently loosen assertions.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

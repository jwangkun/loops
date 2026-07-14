---
name: "coverage-until-threshold"
description: "Raise coverage until the threshold is met (default 80%)"
---

# Coverage Until Threshold

**Category:** Testing
**Slug:** `coverage-until-threshold`
**Max Iterations:** 10

## Goal

Make test coverage meet the configured threshold (default 80%) with the check command exiting 0. Gains must come from meaningful tests covering real uncovered paths — never from lowering the threshold, excluding files, or writing meaningless stub tests.

## When to Use

After new code or refactors drop coverage below the threshold and CI fails the coverage gate, requiring valuable tests to be added to reach it.

## Check Command

```bash
npm test -- --coverage
```

## Exit Condition

- `npm test -- --coverage` exits 0.
- Overall coverage and each dimension (line/branch/function) meet the threshold (default 80%).
- Max iterations not reached.

## Steps

Step 1: Run `npm test -- --coverage`, capturing the coverage report and exit code.
Step 2: Locate the largest gaps: find the lowest-covered files and uncovered branches/error-handling paths; distinguish core logic from low-value code.
Step 3: Add meaningful tests for uncovered critical branches that cover real behavior (including boundaries and error paths); never lower the threshold, exclude files in config, or pile on empty-assertion tests.
Step 4: Re-run the command; if still below threshold and under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining gaps (lowest-covered files, uncovered branches, estimated cost to cover); never loop forever.

## Common Pitfalls

- Chasing line coverage only: high line coverage can still miss critical branches and error paths.
- Writing meaningless tests: merely invoking a function without assertions inflates numbers without preventing regressions.
- Lowering standards for coverage: excluding files or lowering the threshold to pass masks real risk.

## Notes

- Do not meet the threshold by lowering it or excluding files in config.
- Tests must cover real behavior and boundary/error paths with valid assertions.
- Prioritize core business logic over chasing numbers on low-value code.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

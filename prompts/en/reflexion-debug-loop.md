---
name: "reflexion-debug-loop"
description: "Make the failing test or repro pass reliably"
---

# Reflexion Debug Loop

**Category:** Development Process
**Slug:** `reflexion-debug-loop`
**Max Iterations:** 10

## Goal

Make a currently failing test or minimal reproduction pass reliably. Each attempt must update its hypothesis from the previous failure's evidence, not re-apply the same fix idea over and over.

## When to Use

There is a reproducible failing case (test command, repro script, or error stack) that needs several rounds of reproduce-reflect-fix to converge on the root cause.

## Check Command

```bash
npm test -- --testNamePattern=<test>
```

## Exit Condition

- The target test exits 0 and passes twice in a row (to rule out flakiness).
- No new test failures, type errors, or lint errors are introduced.

## Steps

Step 1: Run the check command and fully capture the failure output, assertion diffs, and stack trace.
Step 2: Analyze the output and pinpoint the most likely root cause; after ruling out environment/data noise, form a single falsifiable hypothesis.
Step 3: Make the smallest fix (prefer changing code over tests or assertions); never mask the failure with try/catch, loosened assertions, or skipped cases.
Step 4: Re-run the check command; if still failing and under max iterations, record in the reflexion file why the previous hypothesis failed and the new one, then go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining blocking evidence (minimal repro, ruled-out hypotheses, suspicious locations); never loop forever.

## Common Pitfalls

- Retrying the same fix without updating the hypothesis, getting stuck on the same error for all ten iterations.
- "Greening" the test by catching exceptions or loosening assertions while the real defect remains.
- Concluding from a single reproduction without ruling out flaky/concurrency/order-dependent failures.
- Changing code beyond the root cause's scope and introducing regressions.

## Notes

- Reflexion notes must state "hypothesis -> evidence -> conclusion" so later iterations can reuse them.
- Fixes target the root cause; test-fixture changes should be reviewed separately from production-code changes.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

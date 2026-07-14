---
name: "refactor-until-clean"
description: "Module meets clean-code standards"
---

# Refactor Until Clean

**Category:** Code Quality
**Slug:** `refactor-until-clean`
**Max Iterations:** 10

## Goal

Continuously remove code smells from the target module without changing external behavior, until lint and tests both pass and key metrics (complexity, duplication, function length) show measurable improvement. Correctness is guarded by the test suite.

## When to Use

Use when a module is hard to read, duplicated, has overly long functions, or resists extension, yet behaves correctly and has test coverage. For modules lacking tests, add tests before entering this loop.

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition

- Both `npm run lint` and `npm test` exit with code 0.
- At least one metric (cyclomatic complexity / duplication / longest function) has dropped from the baseline.
- No new lint warnings or failing tests were introduced.
- If 10 iterations are reached without meeting the bar, stop and report.

## Steps

Step 1: Run `npm run lint && npm test`, confirm a green baseline, and record baseline metrics.
Step 2: Identify the single most severe smell currently present (long function, duplicated block, deep nesting, ambiguous naming) and locate its smallest extent.
Step 3: Apply the smallest behavior-preserving refactor to that extent (extract function, inline, rename, move); run tests before committing the iteration.
Step 4: Re-run the check and compare metrics; if lint/tests are still green but the bar is unmet, go back to Step 2.
Step 5: If 10 iterations are reached, or tests go red and cannot be fixed within the iteration, stop and report remaining smells and blockers.

## Common Pitfalls

- Introducing a behavior change that goes unnoticed — always use the test suite as a guardrail and roll back the iteration the moment it goes red.
- One large refactor that loses verifiable intermediate steps, making rollback and review hard.
- Chasing "looks shorter" without real metric improvement, burning iterations for nothing.
- Changes spilling outside the module and triggering cross-module regressions.

## Notes

- Strictly preserve external behavior: public API signatures, return values, side effects, and error types must not change.
- Touch only one smell per iteration so each change is independently rollback-able.
- Before any refactor, confirm the path is covered by tests; if not, add tests first.
- Do not suppress rules just to pass lint; fix properly.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

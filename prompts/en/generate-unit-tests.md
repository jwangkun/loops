---
name: "generate-unit-tests"
description: "add passing edge-case tests for a target function"
---

# Generate Unit Tests

**Category:** Code Generation
**Slug:** `generate-unit-tests`
**Max Iterations:** 5

## Goal

Produce a stable suite of unit tests for a target function covering the normal path, boundary conditions, and error paths, all passing under the check command. Tests should describe the function's external behavior contract, not restate its internals.

## When to Use

When you need to add or harden unit tests for an already-implemented target function; pass its path as `<target-file>`.

## Check Command

```bash
npm test -- <target-file>
```

## Exit Condition

- All newly added tests pass.
- Normal, boundary, and error cases are all covered.
- The check command exits with code 0.

## Steps

Step 1: Run the check command, capture output, and establish the target function's current test status and coverage gaps.
Step 2: Analyze the function's external behavior and contract; enumerate boundaries (empty, zero, negative, extreme values, type limits) and error paths (invalid input, exceptions, concurrency), not just the happy path.
Step 3: Generate minimal, readable test cases named to express the behavior they verify; make the check command pass.
Step 4: Re-run the check command; if cases still fail or coverage gaps remain and max iterations is not reached, go to Step 2 to add or fix them.
Step 5: If max iterations is reached with tests still failing, stop and report the remaining failures and suspected implementation defects; never delete tests to force green.

## Common Pitfalls

- Testing the implementation instead of behavior: asserting internal private state or call order makes tests brittle under refactor.
- Covering only the happy path: ignoring boundary and error inputs leaves hidden regressions.
- Over-mocking: stubbing the unit under test until it only verifies itself, losing real meaning.

## Notes

- Report genuine implementation defects found; do not work around them with looser assertions.
- Tests must be independent and repeatable, not dependent on execution order or external state.
- Do not write trivial assertions merely to inflate coverage.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

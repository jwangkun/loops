---
name: "pre-commit-guard"
description: "block git commit when tests fail"
---

# Pre-Commit Guard

**Category:** CI/CD  
**Slug:** `pre-commit-guard`  
**Max Iterations:** 3

## Goal

Run the test suite before every git commit and allow the commit only when tests exit 0. Any failure must be fixed first; never push a red state into the repository.

## When to Use

As the final gate before committing, run this when you are about to execute git commit. Suited for local pre-commit self-checks to catch issues before they reach CI.

## Check Command

```bash
npm test
```

## Exit Condition

The check command exits 0, at which point git commit may proceed; otherwise the commit is blocked.

## Steps

Step 1: Run the check command before git commit, capturing full output and the exit code.
Step 2: If the exit code is non-zero, isolate the first failing case, read its stack trace and assertions, and decide whether it is a code defect or a faulty test.
Step 3: Apply the smallest fix to a code defect; if the test itself is stale, correct it to reflect the real expectation; never delete assertions or skip to mask it.
Step 4: Re-run the check command; if it still fails and under 3 iterations, return to Step 2.
Step 5: If still failing after 3 iterations, stop the commit and report the blocker and suggested next steps to the user; do not force the commit.

## Common Pitfalls

- Bypassing the gate with --no-verify: committing a red state and leaving the problem for CI or teammates.
- Deleting assertions or skipping failing cases: turning tests green while stripping their protective value.
- Mistreating a wrong test as a code defect: failing to distinguish an implementation bug from test-expectation drift, fixing the wrong target.
- Running only single-file tests: assuming local green is enough, ignoring cross-module regressions.

## Notes

- The commit gate must not be bypassed; if a temporary skip is genuinely required (e.g., a hotfix process), state it explicitly and restore the gate as soon as possible.
- Fixing takes priority over committing; never commit first and fix later.
- If the suite is too slow, optimize the suite rather than relaxing the gate.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

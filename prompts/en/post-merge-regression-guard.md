---
name: "post-merge-regression-guard"
description: "smoke tests pass immediately after merge or rebase"
---

# Post-Merge Regression Guard

**Category:** Pull Request  
**Slug:** `post-merge-regression-guard`  
**Max Iterations:** 3

## Goal

Run the smoke test suite immediately after every merge or rebase to confirm the integration introduced no regression. Any failure must be fixed before continuing other work, keeping the merged code in a shippable state at all times.

## When to Use

Run immediately after performing a merge or rebase that brings another branch into the current branch. Use it to catch integration regressions before starting new development, so you never pile changes on a broken base.

## Check Command

```bash
npm run test:smoke
```

## Exit Condition

The check command exits 0, i.e. the full smoke test suite passes.

## Steps

Step 1: Right after the merge or rebase, run the check command, capturing full output and the list of failing cases.
Step 2: For each failing case, determine the root cause: a merge-introduced regression (semantic conflict, missed call-site update) or a stale test caused by an intentional upstream change.
Step 3: Apply the smallest fix to a regression (sync a missed call site, restore an overwritten change); for an intentional change, update the test expectation to match the new contract; never delete assertions.
Step 4: Re-run the check command; if it still fails and under 3 iterations, return to Step 2.
Step 5: If still failing after 3 iterations, stop and report the unresolved regressions and the likely responsible commits to the user; do not continue with further development.

## Common Pitfalls

- Developing immediately after merge without testing: stacking changes on a broken main, burying the regression deeper.
- Treating a semantic conflict as a test bug: deleting assertions instead of actually syncing call sites, masking the regression.
- Using git checkout -- to discard changes to "go green": losing valid changes along with the broken ones.
- Trusting a "no conflicts" merge message: no textual conflict does not mean no semantic conflict.

## Notes

- The smoke suite must cover critical paths; if it is too weak, strengthen it before relying on this guard.
- Fixing takes priority over new features; never start new development on a red main.
- If a regression originates upstream rather than from local changes, revert or coordinate with upstream instead of silently absorbing it.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

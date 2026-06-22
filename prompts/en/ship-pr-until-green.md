---
name: "ship-pr-until-green"
description: "Implement, push, open PR; drive all CI checks to green"
---

# Ship PR Until Green

**Category:** CI/CD
**Slug:** `ship-pr-until-green`
**Max Iterations:** 15

## Goal

End-to-end delivery from implementing the change to all PR CI checks green: finish the implementation, verify locally, push, open the PR, and loop on fixing CI failures until `gh pr checks` reports all passing and the PR is in a mergeable, healthy state.

## When to Use

Use when a task must be pushed all the way from "write the code" to "PR CI is green and ready to review/merge" — a single complete, small-scope delivery.

## Check Command

```bash
gh pr checks <PR-NUMBER>
```

## Exit Condition

- Every PR check is `pass`; no failing items beyond `fail`/`pending`.
- The PR is `OPEN` with no blocking CI failure.

## Steps

Step 1: Implement the change and run local tests/lint/type checks; only push the branch after local checks pass.
Step 2: If no PR exists yet, create it with `gh pr create`; run `gh pr checks <PR-NUMBER>` and capture each check's name and status (if still pending, wait and re-check).
Step 3: For each failing check, read its logs and the related job, and decide whether it is a defect in this PR's code or infra/upstream noise; make the smallest fix only for real defects introduced by this PR (never force green via skips, loosened checks, or `|| true`).
Step 4: After the relevant tests pass locally, commit and push; go back to Step 2 and re-check until all pass or max iterations are reached.
Step 5: If max iterations are reached with checks still failing, stop and report: the PR link, remaining failing checks, key log errors, fixes already tried, and unresolved blockers. Do not loop forever.

## Common Pitfalls

- Running only unit tests locally before pushing, ignoring lint, typecheck, integration tests, or cross-platform matrices in CI.
- Treating flaky checks or quota/network failures as code problems and editing implementation.
- Bundling several unrelated changes into one commit, making failures hard to attribute and review.
- Failures come from conflict with the target branch or a broken upstream main, yet you keep editing inside this PR.

## Notes

- The PR must be based on the latest target branch; if you find conflicts or a broken base, rebase or sync first before continuing.
- Never fake a pass by skipping checks, forcing exit code 0, or commenting out tests.
- Keep each push focused on one root-cause fix so the commit history stays clear and reviewable.
- Follow the repo's merge convention (squash/rebase/merge); do not rewrite commits others have already reviewed.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

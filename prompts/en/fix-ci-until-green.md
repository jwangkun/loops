---
name: "fix-ci-until-green"
description: "Fix failing CI on current branch until it turns green"
---

# Fix CI Until Green

**Category:** CI/CD
**Slug:** `fix-ci-until-green`
**Max Iterations:** 10

## Goal

Turn the most recent CI run on the current branch green. Success means the root cause of the failure is genuinely fixed, the change is pushed, and the latest remote run ends with exit code 0 — not a green achieved by skipping, cancelling, or papering over failures.

## When to Use

Use when code has been pushed to the current branch but CI is failing, and you need an automated loop that locates the root cause, fixes it, and verifies the fix.

## Check Command

```bash
gh run list --branch "$(git rev-parse --abbrev-ref HEAD)" --limit 1 --json status,conclusion,databaseId
```

## Exit Condition

- The latest run on the current branch has `status` `completed` and `conclusion` `success`.

## Steps

Step 1: Run the check command and capture the latest run's id, status, and conclusion; if `status` is still `in_progress`, wait and re-check.
Step 2: If `conclusion` is not `success`, read the failed logs with `gh run view <id> --log-failed` and pinpoint the failing job, test, or step; distinguish a real failure caused by this branch's code from infra noise (flaky test, network, broken upstream main).
Step 3: Make the smallest fix for the real root cause: reproduce the failure locally, then change code or config (never comment out tests, never loosen checks, never skip steps to force a "green").
Step 4: After the relevant tests pass locally, `git commit` and push; wait for the new CI run and go back to Step 1.
Step 5: If max iterations are reached without green, stop and report: remaining failing jobs, key log errors, fixes already tried, and unresolved blockers. Do not loop forever.

## Common Pitfalls

- Misreading a flaky test or transient network/infra failure as a code defect and changing code; those should be fixed by re-running the run, not editing implementation.
- Fixing only for local pass while missing the matrix, env vars, or lint/typecheck steps CI actually runs.
- Fixating on the error line and ignoring stale build-artifact caches that cause false failures (clear the cache or bump its key).
- Upstream main is already broken and gets mistaken for this branch's problem.

## Notes

- Only fix problems introduced by this branch; if the failure originates upstream, sync main or report it rather than rewriting someone else's code.
- Never fake green by skipping tests, forcing exit code 0, or appending `|| true`.
- Push small, root-cause-focused commits; don't bundle unrelated changes into a fix.
- Confirm the failure reproduces locally before pushing, otherwise the fix is unverifiable.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

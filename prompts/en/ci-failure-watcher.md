---
name: "ci-failure-watcher"
description: "Watch current branch CI; fix root cause if it fails"
---

# CI Failure Watcher

**Category:** CI/CD
**Slug:** `ci-failure-watcher`
**Max Iterations:** 10

## Goal

Keep observing the status of the latest CI run on the current branch and, on any failure, locate and fix the root cause so the run returns to green without manual intervention. Unlike an active fix loop, this loop is primarily "observe — judge — intervene only when needed."

## When to Use

Useful when you want to keep watch over a branch's CI during a long task and have failures handled automatically instead of checking repeatedly by hand.

## Check Command

```bash
gh run list --branch "$(git rev-parse --abbrev-ref HEAD)" --limit 1 --json status,conclusion,databaseId
```

## Exit Condition

- The latest run on the current branch has `status` `completed` and `conclusion` `success`.

## Steps

Step 1: Run the check command to get the latest run's id, status, and conclusion; if it is still `in_progress`, wait and re-check rather than acting in haste.
Step 2: If `conclusion` is failure/cancelled, read logs with `gh run view <id> --log-failed` and judge whether this is a real code failure or infra noise (timeout, rate-limit, flaky test, broken upstream main).
Step 3: For a real failure, make the smallest root-cause fix, verify it reproduces locally, then push; for noise or a cancelled run, prefer triggering `gh run rerun` over editing code.
Step 4: Re-run the check command; if still not green and under the max iterations, go back to Step 2.
Step 5: If max iterations are reached without green, stop and report the remaining failures, key log errors, and actions already taken. Do not loop forever.

## Common Pitfalls

- Treating flaky/network/rate-limit failures as code defects and editing implementation; the correct fix is to re-run the run.
- Acting on a "fix" while the run is still `in_progress`, which means acting on a stale conclusion.
- Reading only the run summary without the specific failing job's logs, misjudging the scope of the failure.
- The failure is actually from broken upstream main, yet you keep poking at this branch.

## Notes

- Default to observation; only edit code once you are sure it is a real failure introduced by this branch.
- Never fake green by skipping tests or loosening checks.
- Before triggering a rerun, confirm the run is in a rerunnable state (`incomplete`/failed) to avoid retriggering the same run.
- Keep fix commits root-cause-focused, one change at a time, without bundling unrelated edits.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

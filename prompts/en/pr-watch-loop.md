---
name: "pr-watch-loop"
description: "Patrol codex-watch PRs; report or fix blockers"
---

# PR Watch Loop

**Category:** CI/CD
**Slug:** `pr-watch-loop`
**Max Iterations:** 10

## Goal

Regularly patrol PRs carrying the `codex-watch` label, stay aware of each PR's CI and review status, fix the simple solvable blockers, and report the rest clearly, so no PR stays stuck on a detail that went unnoticed.

## When to Use

Useful for lightweight patrolling when you need to report progress on a batch of PRs, or periodically confirm they are not blocked by CI failures or missing reviews.

## Check Command

```bash
gh pr list --label codex-watch --json number,title,mergeable,mergeStateStatus
```

## Exit Condition

- No `codex-watch` PR has a blocker that this loop can solve.
- Any remaining blockers (awaiting human review, needing a decision, upstream failure) are all written into the report.

## Steps

Step 1: Run the check command to get the list of `codex-watch` PRs and, for each, query CI check status (`gh pr checks <N>`) and review status (review/requested-reviewers).
Step 2: Classify each PR as: healthy, CI failure, missing review, conflict/stale with base, or blocked on an external dependency.
Step 3: Fix only simple, low-risk blockers (e.g. re-run a failed flaky check, apply an obvious one-line lint fix); do not change logic or make decisions yourself — record those instead.
Step 4: Summarize each PR's status and next action into a concise report; if you just applied a fix, go back to Step 1 to confirm the blocker is cleared.
Step 5: If max iterations are reached, stop and output the final report: each PR's health, unresolved blockers, and the suggested way forward. Do not loop forever.

## Common Pitfalls

- Misreading flaky or upstream failures as the PR's own CI failure and editing implementation unnecessarily.
- Overstepping into problems that need human review or a product decision, leaving changes that no one reviewed.
- Reporting only that something "failed" without a next action, so no one follows up.
- Watching only CI and ignoring equally blocking factors like missing reviews or mergeable=false.

## Notes

- Prioritize observation and reporting; limit fixes to simple, low-risk, self-verifiable items.
- Never make CI "green" for the report by skipping tests or loosening checks.
- Reports must be actionable: give a concrete next step for each PR (who needs to do what), not a vague "there's a problem."
- Do not touch PRs outside the `codex-watch` label.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

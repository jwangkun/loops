---
name: "pr-babysitter"
description: "Keep PRs labeled codex-watch healthy and mergeable"
---

# PR Babysitter

**Category:** CI/CD
**Slug:** `pr-babysitter`
**Max Iterations:** 10

## Goal

Continuously look after PRs carrying the `codex-watch` label and keep them healthy and mergeable: fix CI failures, rebase stale PRs that conflict with the target branch, and leave clear comments on PRs with no progress, so no PR stalls on a solvable problem.

## When to Use

Useful when maintaining several PRs awaiting merge and needing a regular patrol that checks CI status, resolves conflicts, and nudges progress.

## Check Command

```bash
gh pr list --label "codex-watch"
```

## Exit Condition

- No `codex-watch` PR has a blocking CI failure.
- No PR is unmergeable due to staleness (conflict/stale base), or each such PR has a clear handling comment.

## Steps

Step 1: Run the check command to list all `codex-watch` PRs and, for each, gather status: CI conclusion, mergeability, and how far behind/ahead of the target branch it is.
Step 2: Triage each PR into: CI failure, conflict with base, behind base but rebaseable, or long-stalled awaiting review.
Step 3: Make the smallest safe fix for actionable problems: fix real CI failures introduced by the PR, rebase conflict/stale PRs and push; never rewrite someone else's unreviewed core commits.
Step 4: For problems you cannot solve automatically (waiting on human review, needing a decision), leave a clear comment on the PR describing the current state and the next step, then go back to Step 1 to re-check.
Step 5: If max iterations are reached with blockers remaining, stop and report: each remaining PR's status, the blocker, and the actions taken. Do not loop forever.

## Common Pitfalls

- Blaming a babysat PR for CI failures actually caused by upstream main or flaky tests, then editing its code.
- Rebasing a stale PR, introducing conflicts, and pushing without local verification — turning CI red.
- Making large changes across multiple PRs at once, which are hard to review and roll back.
- Forgetting to comment on PRs that need human input, so they keep stalling silently.

## Notes

- Only handle PRs within the `codex-watch` label scope; do not touch unmonitored PRs.
- Fix CI at the root; never fake green by skipping tests or loosening checks.
- Always run relevant checks locally before rebasing to confirm no new failures or conflicts.
- Keep changes to other people's PRs minimal and focused; do not change their intent or merge strategy on your own.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

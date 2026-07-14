---
name: "pr-self-review"
description: "three clean self-reviews on the current diff"
---

# PR Self Review

**Category:** CI/CD  
**Slug:** `pr-self-review`  
**Max Iterations:** 6

## Goal

Complete three independent, strict self-reviews on the diff between the current branch and main, each round focused on a different dimension (correctness, maintainability, risk), fixing every issue found before exit. Review only the changes in this PR; do not rewrite unrelated code.

## When to Use

Run this loop before requesting review or merging a PR, to avoid dumping obvious issues on reviewers. It can also be re-run after CI or reviewer feedback.

## Check Command

```bash
git diff main...HEAD
```

## Exit Condition

Three consecutive review rounds covering correctness, maintainability, and risk, with no new fixable items in each round; every discovered issue has been fixed and locally verified.

## Steps

Step 1: Run the check command to capture the full diff; understand the intent of each changed file without reading unchanged files.
Step 2: Round one, review correctness: boundary conditions, null/empty values, error handling, concurrency and race conditions, alignment with tests.
Step 3: Round two, review maintainability: naming, duplication, function length, missing comments, magic numbers, naming consistency.
Step 4: Round three, review risk: security (injection, authz), performance, breaking changes, log and sensitive-data leakage, rollback difficulty.
Step 5: Make the smallest fix for each finding; re-run the check command to confirm the diff has converged; if issues remain and under 6 iterations, return to Step 2.
Step 6: If 6 iterations are reached with unresolved issues, stop and list the remaining blockers; do not loop forever.

## Common Pitfalls

- Reading only the diff without context: judging a change's side effects detached from its call sites.
- Rubber-stamping: treating "looks fine" as approval without interrogating the reason for each change.
- Drive-by refactors of unrelated code: widening the diff, obscuring the real change and increasing review and rollback cost.
- Ignoring test/implementation drift: changing the implementation but forgetting to update or add tests.

## Notes

- Review the diff itself; do not rewrite the whole file.
- Fixes must be real fixes; never comment out failing tests or delete assertions to "pass."
- Flag breaking changes and security fixes explicitly in the description; do not hide them inside the diff.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

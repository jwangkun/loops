---
name: "staging-smoke-test"
description: "staging smoke tests all pass"
---

# Staging Smoke Test

**Category:** Testing
**Slug:** `staging-smoke-test`
**Max Iterations:** 5

## Goal

Run the smoke test suite in the staging environment and confirm that all critical paths (login, core business flows, payments/data writes, etc.) return normally and the test process exits with code 0. Success means the most recently deployed image is actually usable in a production-like environment.

## When to Use

After code is merged and deployed to staging, before release; used to validate that core functionality still works before shifting traffic.

## Check Command

```bash
npm run smoke:staging
```

## Exit Condition

- `npm run smoke:staging` exits with code 0.
- No failing cases, no skipped cases, and no 5xx or timeouts in error logs.
- The failed-case count is stably 0 (not achieved by commenting out or skipping).

## Steps

Step 1: Run the check command; capture full stdout/stderr and the exit code.
Step 2: Parse failures: separate environment issues (downstream services not up, network, missing config/secrets, pending DB migrations) from application defects (assertion failures, API errors). Suspect the environment first, since smoke tests hit real downstream services.
Step 3: Make the smallest fix for the root cause: fix staging config or run migrations for environment issues; fix the relevant code for application defects. Never force "green" by relaxing assertions, skipping cases, or commenting out checks.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining failures and their root causes, clearly marking which are environment issues and which are code defects. Never loop forever.

## Common Pitfalls

- Running before staging dependencies (DB, cache, third-party APIs) are ready, causing a flood of false failures.
- Tests hitting real third-party APIs whose keys/quotas are not configured, mistakenly treated as code defects.
- Forcing the suite green with `|| true`, `.skip`, or relaxed assertions, masking real regressions.
- Trusting a cached previous-failure result and judging "pass" without re-running.

## Notes

- Run only in staging; never run write-oriented smoke against production.
- Limit fixes to the config/code involved in the current failures; do not opportunistically refactor unrelated tests.
- When changing secrets, confirm they are staging secrets, not production secrets.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

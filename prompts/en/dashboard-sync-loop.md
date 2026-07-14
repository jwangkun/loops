---
name: "dashboard-sync-loop"
description: "dashboard reflects latest data and metrics"
---

# Dashboard Sync Loop

**Category:** Data Science
**Slug:** `dashboard-sync-loop`
**Max Iterations:** 5

## Goal

Make the dashboard accurately reflect the latest underlying data and business metrics, eliminating stale figures, failing queries, and missing indicators. Success means the check command exits cleanly and the key numbers on the dashboard match the source data.

## When to Use

Use when a dashboard refresh fails, numbers disagree with the source system, or a scheduled sync has broken and needs manual intervention. Not for cases where the source data itself is not yet ready.

## Check Command

```bash
python scripts/refresh_dashboard.py
```

## Exit Condition

- The check command completes with exit code 0 and no error output.
- All key metrics on the dashboard are updated to the latest period.
- No residual failed queries, error logs, or missing data blocks remain.

## Steps

Step 1: Run the check command, capturing full stdout/stderr and the exit code.
Step 2: Analyze the failure—distinguish query syntax errors, renamed fields, uninvalidated caches, unreachable dependencies, or a source that simply hasn't updated to the latest period yet.
Step 3: Make the smallest fix: correct the query/field, clear the stale cache, reconnect the source; never paper over errors by commenting out a failing metric or hardcoding an old value.
Step 4: Re-run the check command; if it still fails and you're under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining blockers (which metric, which query, which source); never loop forever.

## Common Pitfalls

- Mistaking a cache hit for updated data when the underlying figures have already changed.
- Fixing a query by widening the time window or relaxing filters just to pass the check, masking the real problem.
- Ignoring query timeouts and pagination truncation, so the dashboard silently shows partial data with no error.
- Multiple dashboards sharing one cache key, but only one is cleared.

## Notes

- Confirm the data source is ready before syncing; out of scope when the source hasn't updated.
- Follow read-only principles for production databases; confirm scope before clearing caches.
- Change one thing per iteration and log it for traceability.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

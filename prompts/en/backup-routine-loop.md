---
name: "backup-routine-loop"
description: "critical data backed up and verified"
---

# Backup Routine Loop

**Category:** System & DevOps
**Slug:** `backup-routine-loop`
**Max Iterations:** 5

## Goal

The backup check reports zero failures across all critical data sources, and every backup's checksum/record matches its source — backups are healthy and restorable. Success means not merely that the job ran, but that it can actually be recovered.

## When to Use

Run this loop during scheduled backup windows, before/after major changes, or whenever you must confirm that disaster-recovery assets are truly usable.

## Check Command

```bash
python scripts/backup_check.py
```

## Exit Condition

- `backup_check.py` exits 0.
- Every critical data source shows ok/verified.
- No missing, stale (freshness below threshold), or corrupt entries.

## Steps

Step 1: Run `python scripts/backup_check.py`, capturing full stdout, warning lines, and exit code.
Step 2: Analyze failures — distinguish missing backups, staleness (freshness below threshold), checksum mismatch, file corruption, and permission/credential errors, and attribute each to a specific source.
Step 3: Make the smallest fix: re-trigger the relevant backup job, correct paths/credentials, or fix permissions; never paper over failures by widening thresholds or deleting failing entries.
Step 4: Re-run the check; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and list the remaining blockers and failing sources; never loop forever.

## Common Pitfalls

- Trusting exit code 0 while ignoring warning lines about stale or corrupt sources.
- Backups succeed but no restore drill is ever performed, so they prove unusable in a real disaster.
- Silencing alerts by widening the freshness threshold or skipping sources, masking genuine backup failures.

## Notes

- Never modify source data; only trigger backups and correct the backup pipeline's configuration.
- Follow least-privilege when handling credentials/secrets; keep them out of logs.
- Confirm before deleting or overwriting any backup to avoid losing the only copy.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

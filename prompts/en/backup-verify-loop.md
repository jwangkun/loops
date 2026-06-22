---
name: "backup-verify-loop"
description: "latest backup restores and smoke queries pass"
---

# Backup Verify Loop

**Category:** Database
**Slug:** `backup-verify-loop`
**Max Iterations:** 3

## Goal

Prove the latest database backup restores successfully to a temporary instance and that basic smoke queries pass — a backup file existing is not the same as recoverable; the only reliable evidence is a successful restore plus queries. Success means the backup is genuinely usable if disaster strikes.

## When to Use

After a backup job runs, during periodic DR drills, or after changing backup/restore procedures, to confirm the backup is actually usable.

## Check Command

```bash
npm run db:backup:verify
```

## Exit Condition

- The backup file exists, is complete, and parses correctly.
- Restore into an isolated temporary instance succeeds without errors.
- Smoke queries (row counts of key tables, most-recent timestamps, constraint validity) return expected results.

## Steps

Step 1: Run `npm run db:backup:verify`, capturing the full output of the restore and smoke queries.
Step 2: If it fails, classify the cause — common issues are truncated/corrupt backup files, format mismatch with the restore tool version, a temp instance that wasn't cleanly initialized, or smoke queries failing due to schema drift. Fix each root cause directly.
Step 3: After the smallest fix (regenerate the backup, correct restore parameters, align schema), re-run; never fake green by loosening smoke thresholds or skipping checks.
Step 4: If still failing and under max iterations (3), return to Step 2.
Step 5: If max iterations are reached without success, stop and clearly report the backup is unusable — this is a high-priority issue needing human intervention; never loop forever.

## Common Pitfalls

- Verifying only that the file exists: normal size does not mean recoverable; restore is the only proof.
- Restoring into a production instance: the temp instance must be fully isolated to avoid contaminating real data.
- Schema drift: backup and current code schema diverge, so queries fail without being noticed.
- Smoke queries too weak: running only `SELECT 1` cannot detect real data corruption.

## Notes

- Restore must use a temporary instance isolated from production; never write to the production database.
- Clean up the temp instance after verification to avoid leftovers and wasted resources.
- An unusable backup is a high-priority issue and must be escalated immediately, not retried silently.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

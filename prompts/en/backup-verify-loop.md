---
name: "backup-verify-loop"
description: "latest database backup restores successfully"
---

# Backup Verify Loop

**Category:** Database  
**Slug:** `backup-verify-loop`  
**Max Iterations:** 3

## Goal

latest database backup restores successfully

## Check Command

```bash
npm run db:backup:verify
```

## Exit Condition

backup restores and basic queries pass

## Steps

Step 1: Take backup. Restore to temp instance. Run smoke queries. Fix issues.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "backup-routine-loop"
description: "all critical data backed up and verified"
---

# Backup Routine Loop

**Category:** System & DevOps  
**Slug:** `backup-routine-loop`  
**Max Iterations:** 5

## Goal

all critical data backed up and verified

## Check Command

```bash
python scripts/backup_check.py
```

## Exit Condition

all backups complete and verified

## Steps

Step 1: Run backup job. Verify integrity. Fix failures. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "schema-migration-loop"
description: "database schema change is migrated and tests pass"
---

# Schema Migration Loop

**Category:** Database  
**Slug:** `schema-migration-loop`  
**Max Iterations:** 8

## Goal

database schema change is migrated and tests pass

## Check Command

```bash
npx prisma migrate dev && npm test
```

## Exit Condition

migration applies cleanly and tests pass

## Steps

Step 1: Update schema. Generate migration. Apply. Run tests. Fix issues.

## Recommended Agents

Claude Code, Cursor, Trae

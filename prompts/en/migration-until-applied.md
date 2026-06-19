---
name: "migration-until-applied"
description: "all database migrations applied clean"
---

# Migration Until Applied

**Category:** Dependencies  
**Slug:** `migration-until-applied`  
**Max Iterations:** 5

## Goal

all database migrations applied clean

## Check Command

```bash
npx prisma migrate status
```

## Exit Condition

migrations applied

## Steps

Step 1: Run migrations. Fix schema or SQL errors.

## Recommended Agents

Claude Code, Cursor, Trae

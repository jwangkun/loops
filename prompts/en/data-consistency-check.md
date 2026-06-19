---
name: "data-consistency-check"
description: "no orphaned records or constraint violations"
---

# Data Consistency Check

**Category:** Database  
**Slug:** `data-consistency-check`  
**Max Iterations:** 5

## Goal

no orphaned records or constraint violations

## Check Command

```bash
npm run db:consistency
```

## Exit Condition

all consistency checks pass

## Steps

Step 1: Run consistency checks. Fix each violation. Repeat until clean.

## Recommended Agents

Claude Code, Cursor, Trae

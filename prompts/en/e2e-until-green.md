---
name: "e2e-until-green"
description: "E2E test suite passes"
---

# E2E Until Green

**Category:** Testing  
**Slug:** `e2e-until-green`  
**Max Iterations:** 10

## Goal

E2E test suite passes

## Check Command

```bash
npm run test:e2e
```

## Exit Condition

E2E tests exit 0

## Steps

Step 1: Run E2E tests. Fix the first failing spec, then repeat until all pass.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "post-merge-regression-guard"
description: "smoke tests pass immediately after merge or rebase"
---

# Post-Merge Regression Guard

**Category:** Pull Request  
**Slug:** `post-merge-regression-guard`  
**Max Iterations:** 3

## Goal

smoke tests pass immediately after merge or rebase

## Check Command

```bash
npm run test:smoke
```

## Exit Condition

smoke tests pass

## Steps

Step 1: Run smoke tests after merge. Fix regressions before continuing other work.

## Recommended Agents

Claude Code, Cursor, Trae

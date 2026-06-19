---
name: "lint-typecheck-fix"
description: "lint and typecheck clean"
---

# Lint Typecheck Fix

**Category:** Code Quality  
**Slug:** `lint-typecheck-fix`  
**Max Iterations:** 5

## Goal

lint and typecheck clean

## Check Command

```bash
npm run lint && npx tsc --noEmit
```

## Exit Condition

lint and typecheck exit 0

## Steps

Step 1: Run lint and typecheck. Fix reported issues with minimal diff.

## Recommended Agents

Claude Code, Cursor, Trae

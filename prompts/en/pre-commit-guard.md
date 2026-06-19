---
name: "pre-commit-guard"
description: "tests fail at commit time to block git commit"
---

# Pre-Commit Guard

**Category:** CI/CD  
**Slug:** `pre-commit-guard`  
**Max Iterations:** 3

## Goal

tests fail at commit time to block git commit

## Check Command

```bash
npm test
```

## Exit Condition

tests exit 0 to allow commit

## Steps

Step 1: Run tests before each git commit. Fix failures before committing.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "fix-ci-until-green"
description: "latest CI run on current branch passes"
---

# Fix CI Until Green

**Category:** CI/CD  
**Slug:** `fix-ci-until-green`  
**Max Iterations:** 10

## Goal

latest CI run on current branch passes

## Check Command

```bash
gh run list ...
```

## Exit Condition

CI run exits 0

## Steps

Step 1: Find latest failing CI run. Read logs. Reproduce locally. Fix root cause. Push. Verify.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "test-until-green"
description: "all tests pass"
---

# Test Until Green

**Category:** Testing  
**Slug:** `test-until-green`  
**Max Iterations:** 10

## Goal

all tests pass

## Check Command

```bash
npm test
```

## Exit Condition

tests exit 0

## Steps

Step 1: Run tests. If there are failures, fix the smallest root cause, then repeat.

## Recommended Agents

Claude Code, Cursor, Trae

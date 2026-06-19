---
name: "refactor-until-clean"
description: "target module meets clean code standards"
---

# Refactor Until Clean

**Category:** Code Generation  
**Slug:** `refactor-until-clean`  
**Max Iterations:** 10

## Goal

target module meets clean code standards

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition

lint and tests pass with improved metrics

## Steps

Step 1: Identify one smell. Refactor. Run checks. Repeat until metrics improve.

## Recommended Agents

Claude Code, Cursor, Trae

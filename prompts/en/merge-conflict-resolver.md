---
name: "merge-conflict-resolver"
description: "branch rebases on main clean with passing tests"
---

# Merge Conflict Resolver

**Category:** Pull Request  
**Slug:** `merge-conflict-resolver`  
**Max Iterations:** 10

## Goal

branch rebases on main clean with passing tests

## Check Command

```bash
npm test
```

## Exit Condition

rebase clean and tests pass

## Steps

Step 1: Rebase on main. Resolve conflicts one file at a time. Run tests.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "ci-failure-watcher"
description: "latest CI run on current branch is green"
---

# CI Failure Watcher

**Category:** CI/CD  
**Slug:** `ci-failure-watcher`  
**Max Iterations:** 10

## Goal

latest CI run on current branch is green

## Check Command

```bash
gh run list ...
```

## Exit Condition

CI run is green

## Steps

Step 1: Check CI status. If failing, read logs, fix root cause, push if needed.

## Recommended Agents

Claude Code, Cursor, Trae

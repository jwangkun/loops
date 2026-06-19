---
name: "pr-self-review"
description: "three clean self-reviews on current diff"
---

# PR Self Review

**Category:** CI/CD  
**Slug:** `pr-self-review`  
**Max Iterations:** 6

## Goal

three clean self-reviews on current diff

## Check Command

```bash
git diff main...HEAD
```

## Exit Condition

no issues found in three reviews

## Steps

Step 1: Review diff like a senior reviewer. Fix found issues, then re-review.

## Recommended Agents

Claude Code, Cursor, Trae

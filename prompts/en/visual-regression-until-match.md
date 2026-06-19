---
name: "visual-regression-until-match"
description: "visual regression suite passes with intentional UI only"
---

# Visual Regression Until Match

**Category:** Testing  
**Slug:** `visual-regression-until-match`  
**Max Iterations:** 6

## Goal

visual regression suite passes with intentional UI only

## Check Command

```bash
npx playwright test --grep @visual
```

## Exit Condition

visual tests exit 0

## Steps

Step 1: Run visual tests. Fix unintended UI diffs; update baselines only for deliberate design changes.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "responsive-until-match"
description: "UI renders correctly on all target breakpoints"
---

# Responsive Until Match

**Category:** Frontend  
**Slug:** `responsive-until-match`  
**Max Iterations:** 8

## Goal

UI renders correctly on all target breakpoints

## Check Command

```bash
npx playwright test --grep @responsive
```

## Exit Condition

responsive tests pass

## Steps

Step 1: Test each breakpoint. Fix layout issues. Repeat until all pass.

## Recommended Agents

Claude Code, Cursor, Trae

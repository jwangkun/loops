---
name: "bundle-size-budget"
description: "client bundle stays within budget"
---

# Bundle Size Budget

**Category:** Performance  
**Slug:** `bundle-size-budget`  
**Max Iterations:** 5

## Goal

client bundle stays within budget

## Check Command

```bash
npm run build && npm run size-limit
```

## Exit Condition

bundle within budget

## Steps

Step 1: Build and measure bundle size. Lazy load or cut deps if over budget.

## Recommended Agents

Claude Code, Cursor, Trae

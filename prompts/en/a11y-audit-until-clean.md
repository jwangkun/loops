---
name: "a11y-audit-until-clean"
description: "no severe accessibility violations on changed UI"
---

# A11y Audit Until Clean

**Category:** Accessibility  
**Slug:** `a11y-audit-until-clean`  
**Max Iterations:** 10

## Goal

no severe accessibility violations on changed UI

## Check Command

```bash
npm run test:a11y
```

## Exit Condition

no a11y violations

## Steps

Step 1: Run a11y audit on changed routes. Fix each violation.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "frontend-error-boundary-check"
description: "all routes have error boundaries and fallback UI"
---

# Frontend Error Boundary Check

**Category:** Frontend  
**Slug:** `frontend-error-boundary-check`  
**Max Iterations:** 8

## Goal

all routes have error boundaries and fallback UI

## Check Command

```bash
npm run lint:error-boundaries
```

## Exit Condition

every route has error boundary coverage

## Steps

Step 1: Audit routes. Add missing error boundaries. Test fallback UI.

## Recommended Agents

Claude Code, Cursor, Trae

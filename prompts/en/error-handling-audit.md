---
name: "error-handling-audit"
description: "all public functions have consistent error handling"
---

# Error Handling Audit

**Category:** Code Generation  
**Slug:** `error-handling-audit`  
**Max Iterations:** 8

## Goal

all public functions have consistent error handling

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition

no unhandled error patterns found

## Steps

Step 1: Scan for functions lacking error handling. Add consistent handling. Test.

## Recommended Agents

Claude Code, Cursor, Trae

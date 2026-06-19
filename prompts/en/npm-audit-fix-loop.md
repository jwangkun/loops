---
name: "npm-audit-fix-loop"
description: "no high or critical npm audit vulnerabilities"
---

# NPM Audit Fix Loop

**Category:** Dependencies  
**Slug:** `npm-audit-fix-loop`  
**Max Iterations:** 10

## Goal

no high or critical npm audit vulnerabilities

## Check Command

```bash
npm audit --audit-level=high && npm test
```

## Exit Condition

no vulnerabilities found

## Steps

Step 1: Pick a high/critical advisory. Apply the safest fix.

## Recommended Agents

Claude Code, Cursor, Trae

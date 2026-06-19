---
name: "logging-audit-loop"
description: "all critical paths produce structured logs"
---

# Logging Audit Loop

**Category:** Backend  
**Slug:** `logging-audit-loop`  
**Max Iterations:** 8

## Goal

all critical paths produce structured logs

## Check Command

```bash
npm run lint:logging
```

## Exit Condition

no unstructured log statements in critical paths

## Steps

Step 1: Audit critical paths. Replace unstructured logs. Test log output.

## Recommended Agents

Claude Code, Cursor, Trae

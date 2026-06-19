---
name: "independent-verifier-pass"
description: "build, lint, and tests pass under independent verification"
---

# Independent Verifier Pass

**Category:** Maintenance  
**Slug:** `independent-verifier-pass`  
**Max Iterations:** 1

## Goal

build, lint, and tests pass under independent verification

## Check Command

```bash
npm run build && npm run lint && npm test
```

## Exit Condition

all verifications pass

## Steps

Step 1: Run build, lint, and tests as verifier. Trust only command output.

## Recommended Agents

Claude Code, Cursor, Trae

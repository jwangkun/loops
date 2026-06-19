---
name: "de-sloppify-pass"
description: "recent changes are clean and minimal"
---

# De-Sloppify Pass

**Category:** Code Quality  
**Slug:** `de-sloppify-pass`  
**Max Iterations:** 3

## Goal

recent changes are clean and minimal

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition

no sloppiness found

## Steps

Step 1: Review diff for debugging code, dead branches, naming issues.

## Recommended Agents

Claude Code, Cursor, Trae

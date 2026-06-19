---
name: "dead-code-removal"
description: "no unused exports, variables, or functions remain"
---

# Dead Code Removal

**Category:** Code Generation  
**Slug:** `dead-code-removal`  
**Max Iterations:** 5

## Goal

no unused exports, variables, or functions remain

## Check Command

```bash
npx knip --no-exit-code && npm test
```

## Exit Condition

knip reports no dead code

## Steps

Step 1: Run dead code analyzer. Remove or use flagged items. Test.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "type-definition-sync"
description: "TypeScript types match runtime API and database schemas"
---

# Type Definition Sync

**Category:** Code Generation  
**Slug:** `type-definition-sync`  
**Max Iterations:** 8

## Goal

TypeScript types match runtime API and database schemas

## Check Command

```bash
npx tsc --noEmit
```

## Exit Condition

typecheck passes without any cast

## Steps

Step 1: Find mismatched types. Update definitions. Run typecheck. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "knip-until-clean"
description: "knip reports no unused code or deps"
---

# Knip Until Clean

**Category:** Code Quality  
**Slug:** `knip-until-clean`  
**Max Iterations:** 5

## Goal

knip reports no unused code or deps

## Check Command

```bash
npx knip
```

## Exit Condition

knip exits 0

## Steps

Step 1: Run knip. Delete dead code and unused deps. Verify tests still pass.

## Recommended Agents

Claude Code, Cursor, Trae

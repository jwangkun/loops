---
name: "post-edit-test-guard"
description: "related tests must pass after edits"
---

# Post-Edit Test Guard

**Category:** Testing  
**Slug:** `post-edit-test-guard`  
**Max Iterations:** 3

## Goal

related tests must pass after edits

## Check Command

```bash
npm test -- --findRelatedTests <files>
```

## Exit Condition

related tests pass

## Steps

Step 1: Run related tests after edits. Fix failures before continuing.

## Recommended Agents

Claude Code, Cursor, Trae

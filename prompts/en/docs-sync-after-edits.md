---
name: "docs-sync-after-edits"
description: "documentation matches current code changes"
---

# Docs Sync After Edits

**Category:** Documentation  
**Slug:** `docs-sync-after-edits`  
**Max Iterations:** 5

## Goal

documentation matches current code changes

## Check Command

```bash
git diff main...HEAD --name-only
```

## Exit Condition

docs match code

## Steps

Step 1: Review diff. Find outdated docs. Update them.

## Recommended Agents

Claude Code, Cursor, Trae

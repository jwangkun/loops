---
name: "changelog-sync-after-ship"
description: "CHANGELOG.md has accurate [Unreleased] entries"
---

# Changelog Sync After Ship

**Category:** Development Process  
**Slug:** `changelog-sync-after-ship`  
**Max Iterations:** 1

## Goal

CHANGELOG.md has accurate [Unreleased] entries

## Check Command

```bash
git log -5 --oneline
```

## Exit Condition

changelog updated

## Steps

Step 1: Review recent commits. Write Keep-a-Changelog entries for user-visible changes.

## Recommended Agents

Claude Code, Cursor, Trae

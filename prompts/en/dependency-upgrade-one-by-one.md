---
name: "dependency-upgrade-one-by-one"
description: "critical outdated deps upgraded and tests green"
---

# Dependency Upgrade One By One

**Category:** Dependencies  
**Slug:** `dependency-upgrade-one-by-one`  
**Max Iterations:** 10

## Goal

critical outdated deps upgraded and tests green

## Check Command

```bash
npm outdated && npm test && npm run build
```

## Exit Condition

outdated deps upgraded and all green

## Steps

Step 1: Pick an outdated package. Upgrade it. Fix breaking changes. Commit.

## Recommended Agents

Claude Code, Cursor, Trae

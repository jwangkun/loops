---
name: "build-until-green"
description: "production build succeeds"
---

# Build Until Green

**Category:** CI/CD  
**Slug:** `build-until-green`  
**Max Iterations:** 5

## Goal

production build succeeds

## Check Command

```bash
npm run build
```

## Exit Condition

build exits 0

## Steps

Step 1: Run build. If it fails, fix the first error, then repeat until success.

## Recommended Agents

Claude Code, Cursor, Trae

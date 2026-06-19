---
name: "design-token-sync"
description: "all UI uses approved design tokens"
---

# Design Token Sync

**Category:** Frontend  
**Slug:** `design-token-sync`  
**Max Iterations:** 8

## Goal

all UI uses approved design tokens

## Check Command

```bash
npm run lint:design-tokens
```

## Exit Condition

no hardcoded colors or spacing values

## Steps

Step 1: Scan for hardcoded values. Replace with design tokens. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

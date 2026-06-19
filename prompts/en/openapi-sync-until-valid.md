---
name: "openapi-sync-until-valid"
description: "openapi.yaml lint clean and matches implemented routes"
---

# OpenAPI Sync Until Valid

**Category:** API/Specs  
**Slug:** `openapi-sync-until-valid`  
**Max Iterations:** 10

## Goal

openapi.yaml lint clean and matches implemented routes

## Check Command

```bash
npx @redocly/cli lint openapi.yaml
```

## Exit Condition

openapi lint exits 0

## Steps

Step 1: Lint openapi.yaml. Fix spec errors and handler drift.

## Recommended Agents

Claude Code, Cursor, Trae

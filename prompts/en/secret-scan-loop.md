---
name: "secret-scan-loop"
description: "no secrets or credentials in repository"
---

# Secret Scan Loop

**Category:** Security & Compliance  
**Slug:** `secret-scan-loop`  
**Max Iterations:** 5

## Goal

no secrets or credentials in repository

## Check Command

```bash
npx secretlint --maskSecrets "**/*"
```

## Exit Condition

secret scan passes clean

## Steps

Step 1: Run secret scan. Remove or rotate leaked secrets. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

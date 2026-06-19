---
name: "seed-data-validator"
description: "seed data loads cleanly and references are valid"
---

# Seed Data Validator

**Category:** Database  
**Slug:** `seed-data-validator`  
**Max Iterations:** 5

## Goal

seed data loads cleanly and references are valid

## Check Command

```bash
npm run db:seed && npm run test:seed
```

## Exit Condition

seed data loads without errors

## Steps

Step 1: Run seed script. Fix broken references or data issues. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

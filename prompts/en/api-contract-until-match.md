---
name: "api-contract-until-match"
description: "API implementation matches published contract"
---

# API Contract Until Match

**Category:** API/Specs  
**Slug:** `api-contract-until-match`  
**Max Iterations:** 10

## Goal

API implementation matches published contract

## Check Command

```bash
npm run test:contract
```

## Exit Condition

contract tests pass

## Steps

Step 1: Run contract tests. Fix each schema/response mismatch with minimal diff.

## Recommended Agents

Claude Code, Cursor, Trae

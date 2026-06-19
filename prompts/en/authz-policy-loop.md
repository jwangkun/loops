---
name: "authz-policy-loop"
description: "all sensitive endpoints enforce authorization"
---

# Authz Policy Loop

**Category:** Backend  
**Slug:** `authz-policy-loop`  
**Max Iterations:** 10

## Goal

all sensitive endpoints enforce authorization

## Check Command

```bash
npm run test:authz
```

## Exit Condition

authorization tests pass

## Steps

Step 1: Audit endpoints. Add authorization checks. Write tests. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

---
name: "rate-limit-enforcer"
description: "all public endpoints enforce rate limits"
---

# Rate Limit Enforcer

**Category:** Backend  
**Slug:** `rate-limit-enforcer`  
**Max Iterations:** 8

## Goal

all public endpoints enforce rate limits

## Check Command

```bash
npm run test:rate-limit
```

## Exit Condition

rate limit tests pass

## Steps

Step 1: Identify unprotected endpoints. Add rate limiting. Test.

## Recommended Agents

Claude Code, Cursor, Trae

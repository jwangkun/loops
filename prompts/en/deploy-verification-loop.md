---
name: "deploy-verification-loop"
description: "all post-deploy health and smoke endpoints return success"
---

# Deploy Verification Loop

**Category:** Deployment  
**Slug:** `deploy-verification-loop`  
**Max Iterations:** 5

## Goal

all post-deploy health and smoke endpoints return success

## Check Command

```bash
curl -fsS <your-health-url>
```

## Exit Condition

endpoints return 0

## Steps

Step 1: Hit health/smoke URLs. If failing, check deployment logs.

## Recommended Agents

Claude Code, Cursor, Trae

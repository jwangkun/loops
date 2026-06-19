---
name: "access-review-loop"
description: "all user access permissions are justified"
---

# Access Review Loop

**Category:** Security & Compliance  
**Slug:** `access-review-loop`  
**Max Iterations:** 20

## Goal

all user access permissions are justified

## Check Command

```bash
python scripts/access_review.py
```

## Exit Condition

all permissions reviewed and documented

## Steps

Step 1: Review one user/role. Verify justification. Remove or document.

## Recommended Agents

Claude Code, Cursor, Trae

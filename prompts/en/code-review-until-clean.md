---
name: "code-review-until-clean"
description: "code passes structured review checklist"
---

# Code Review Until Clean

**Category:** Code Generation  
**Slug:** `code-review-until-clean`  
**Max Iterations:** 5

## Goal

code passes structured review checklist

## Check Command

```bash
python scripts/review_checklist.py
```

## Exit Condition

all review checks pass

## Steps

Step 1: Run review checklist. Fix each flagged issue. Repeat until clean.

## Recommended Agents

Claude Code, Cursor, Trae

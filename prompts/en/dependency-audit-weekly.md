---
name: "dependency-audit-weekly"
description: "deliver weekly dependency audit summary"
---

# Dependency Audit Weekly

**Category:** Dependencies  
**Slug:** `dependency-audit-weekly`  
**Max Iterations:** 1

## Goal

deliver weekly dependency audit summary

## Check Command

```bash
npm outdated || true
```

## Exit Condition

outdated report delivered

## Steps

Step 1: Run npm outdated. Categorize updates. Suggest security upgrade plan.

## Recommended Agents

Claude Code, Cursor, Trae

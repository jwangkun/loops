---
name: "dashboard-sync-loop"
description: "dashboard reflects latest data and metrics"
---

# Dashboard Sync Loop

**Category:** Data Science  
**Slug:** `dashboard-sync-loop`  
**Max Iterations:** 5

## Goal

dashboard reflects latest data and metrics

## Check Command

```bash
python scripts/refresh_dashboard.py
```

## Exit Condition

dashboard data is up to date

## Steps

Step 1: Refresh dashboard. Fix broken queries or stale caches. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

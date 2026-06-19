---
name: "log-anomaly-detector"
description: "no critical anomalies in recent logs"
---

# Log Anomaly Detector

**Category:** System & DevOps  
**Slug:** `log-anomaly-detector`  
**Max Iterations:** 10

## Goal

no critical anomalies in recent logs

## Check Command

```bash
python scripts/log_anomaly.py
```

## Exit Condition

no critical anomalies detected

## Steps

Step 1: Scan logs. Investigate anomalies. Fix root cause. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

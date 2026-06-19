---
name: "data-pipeline-until-green"
description: "data pipeline runs end-to-end without errors"
---

# Data Pipeline Until Green

**Category:** Data Science  
**Slug:** `data-pipeline-until-green`  
**Max Iterations:** 10

## Goal

data pipeline runs end-to-end without errors

## Check Command

```bash
python scripts/run_pipeline.py
```

## Exit Condition

pipeline completes successfully

## Steps

Step 1: Run pipeline. Fix first failure. Repeat until completion.

## Recommended Agents

Claude Code, Cursor, Trae

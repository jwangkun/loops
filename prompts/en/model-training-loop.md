---
name: "model-training-loop"
description: "model reaches target accuracy on validation set"
---

# Model Training Loop

**Category:** Data Science  
**Slug:** `model-training-loop`  
**Max Iterations:** 20

## Goal

model reaches target accuracy on validation set

## Check Command

```bash
python scripts/train.py --validate
```

## Exit Condition

validation accuracy meets target

## Steps

Step 1: Train model. Evaluate. Tune hyperparameters. Repeat until target met.

## Recommended Agents

Claude Code, Cursor, Trae

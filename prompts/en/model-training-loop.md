---
name: "model-training-loop"
description: "validation accuracy reaches target"
---

# Model Training Loop

**Category:** Data Science
**Slug:** `model-training-loop`
**Max Iterations:** 20

## Goal

The model reaches the preset accuracy/metric target on the validation set, with a reasonable train/validation gap and no overfitting, and the result is reproducible via a fixed random seed. Hitting target means genuine generalization, not overfitting to the evaluation set.

## When to Use

Run this loop once data and features are ready and you need to iterate on tuning until the metric target is met.

## Check Command

```bash
python scripts/train.py --validate
```

## Exit Condition

- `train.py --validate` reports validation accuracy ≥ target.
- Train/validation gap within threshold (no overfitting).
- Run uses a fixed random seed and is reproducible.

## Steps

Step 1: Run `python scripts/train.py --validate`, capturing train/validation metrics, loss curves, and exit code.
Step 2: Analyze the gap — high train/low validation means overfitting; both low means underfitting; volatile metrics usually point to learning-rate or data issues.
Step 3: Make the smallest change: regularization/early stopping/data augmentation for overfitting; more capacity/features/longer training for underfitting; change one variable at a time for clean attribution.
Step 4: Re-run validation; if below target and under max iterations, go to Step 2.
Step 5: If max iterations are hit without reaching target, stop and report the best metric so far and remaining bottlenecks; never loop forever or silently lower the target.

## Common Pitfalls

- Tuning on the test set, causing data leakage and over-optimistic estimates.
- Tracking a single metric that gets gamed (e.g. accuracy hiding class imbalance).
- Not fixing the random seed, so results are irreproducible and gains cannot be attributed.
- Overfitting goes unnoticed: training score looks great while generalization is poor.

## Notes

- Evaluate only on the validation set; reserve the test set for final evaluation and never tune on it.
- Fix the random seed and commit the matching code and data versions for reproducibility.
- Never tamper with evaluation logic or resample the validation set just to pass the target.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

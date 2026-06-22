---
name: "feature-engineering-loop"
description: "new features steadily improve score"
---

# Feature Engineering Loop

**Category:** Data Science
**Slug:** `feature-engineering-loop`
**Max Iterations:** 15

## Goal

The feature script shows that new features improve the validation score beyond random noise, the feature set is free of redundancy/leakage, and training and serving share identical feature-generation logic. Gains must be reproducible and deployable.

## When to Use

Run this loop once a baseline model is ready and you want to engineer features iteratively to push performance higher.

## Check Command

```bash
python scripts/evaluate_features.py
```

## Exit Condition

- `evaluate_features.py` reports a repeatable validation improvement over the baseline.
- New features have no NaNs, no target leakage, and reasonable importance.
- The gain holds stable across multiple random seeds.

## Steps

Step 1: Run `python scripts/evaluate_features.py`, capturing the validation score for the current feature set and the impact of each candidate feature.
Step 2: Analyze — separate features carrying real signal from noise/leakage ones; check for future information and for high correlation with the target column (leakage).
Step 3: Make the smallest change: add only features that bring stable gains, drop redundant or leaking ones; keep feature-generation code identical between training and serving.
Step 4: Re-run evaluation; if further improvement is possible and under max iterations, go to Step 2.
Step 5: If max iterations are hit or no more useful features remain, stop and report the cumulative gain and the retained feature list; never pile on features indefinitely.

## Common Pitfalls

- Introducing future-information/leakage features: offline scores look great, then collapse in production.
- Computing features from history at training time but reimplementing them differently at serving time, causing train/serve skew.
- Stacking many weak features, inflating dimensionality and overfitting.
- Reading a single-seed score and mistaking random noise for a real gain.

## Notes

- Feature selection must use the validation set; the test set is off-limits for selecting candidates too.
- Training and serving must share the same feature-generation code to avoid inconsistent definitions.
- Never keep a leaking or non-deployable feature just to boost the score.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

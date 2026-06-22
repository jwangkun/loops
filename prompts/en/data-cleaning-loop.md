---
name: "data-cleaning-loop"
description: "dataset passes all quality checks"
---

# Data Cleaning Loop

**Category:** Data Science
**Slug:** `data-cleaning-loop`
**Max Iterations:** 8

## Goal

The data quality script reports every rule passing for the current dataset, with data self-consistent in type, range, uniqueness, and completeness, and ready for downstream modeling. Cleaning must preserve true signal, not merely turn the checks green.

## When to Use

Run this loop after ingesting/merging new data, before modeling, or whenever data-quality checks regress.

## Check Command

```bash
python scripts/data_quality.py
```

## Exit Condition

- `data_quality.py` exits 0.
- All quality rules pass.
- No missing values, duplicate rows, type mismatches, or out-of-range records.

## Steps

Step 1: Run `python scripts/data_quality.py`, capturing the report and per-rule failure detail.
Step 2: Analyze failures — distinguish missing values, duplicate rows, type errors, out-of-range/outlier values, and encoding errors, locating the affected columns and rows.
Step 3: Make the smallest fix: impute/drop missing values by business rule, deduplicate, correct types, clip outliers; always preserve signal and never delete real data just to pass checks.
Step 4: Re-run the check; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and list the remaining failing rules and affected columns; never loop forever.

## Common Pitfalls

- Blanket removal of outliers that destroys the real distribution and model signal.
- Mean/median imputation without grouping, leaking information across categories.
- Fixing the data but not the cleaning script, so the issue reappears identically on the next run.
- Silently dropping rows without a record, leaving sample size and bias untraceable.

## Notes

- Every cleaning operation must be traceable (record what changed) for rollback and audit.
- Finish cleaning before the train/test split to avoid leakage; never infer or impute from the target column.
- Deletion is a last resort and must account for downstream modeling impact.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

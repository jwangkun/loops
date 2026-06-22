---
name: "data-pipeline-until-green"
description: "data pipeline runs end-to-end without errors"
---

# Data Pipeline Until Green

**Category:** Data Science
**Slug:** `data-pipeline-until-green`
**Max Iterations:** 10

## Goal

Run the data pipeline end-to-end with no unhandled exception, exit code 0, and every stage (extract, transform, load/validate) completing as expected and producing data. Success means the pipeline is genuinely repeatable under the current data and configuration.

## When to Use

After changes to pipeline code, SQL/transform logic, upstream data sources, or scheduling config; suited to iteratively fixing until the pipeline runs cleanly before release or scheduled execution.

## Check Command

```bash
python scripts/run_pipeline.py
```

## Exit Condition

- `python scripts/run_pipeline.py` exits with code 0.
- All stages executed with no uncaught exceptions.
- Output data is produced and row counts/validations are within a reasonable range (non-empty, not abnormally zeroed, matching expected magnitude).

## Steps

Step 1: Run the check command; capture full stdout/stderr, exit code, and per-stage logs/timing; note which stage failed.
Step 2: Analyze failures: separate code defects (SQL syntax/field errors, transform logic, type mismatches), data issues (upstream schema drift, nulls/dirty data, volume spikes), and environment issues (missing dependencies, connection failures, credentials/permissions, out-of-memory/disk). First confirm whether it is a data problem or a code problem to avoid the wrong fix.
Step 3: Make the smallest fix — correct SQL/transform logic, complete dependencies or connection config, or add explicit validation for dirty data. Never force the pipeline "green" with empty try/except swallowing, skipping failed stages, or downgrading exceptions to warnings.
Step 4: Re-run the check command; if it still fails and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining failing stages, error messages, and root-cause categories (code/data/environment), noting the impact on downstream outputs. Never loop forever.

## Common Pitfalls

- Swallowing exceptions with empty `except: pass`: the pipeline "succeeds" but data is missing or wrong, poisoning downstream.
- Upstream schema drift (renamed/dropped fields) causing missing fields, misjudged as a code bug and fixed by repeatedly editing code.
- Silent truncation or forced casts (e.g. `NaN`→`0`, string→number) masking real dirty data.
- Passing on a small local dataset but failing on full data due to memory/timeout; validate with a representative data volume.
- Non-idempotent re-runs that re-write existing data, inflating validated row counts.

## Notes

- Confirm a failure is reproducible before fixing, to avoid code changes for transient issues (network jitter).
- Do not relax data-validation thresholds or comment out assertions just to pass.
- When writing production data, ensure changes are idempotent to avoid duplication or overwrite on re-runs.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

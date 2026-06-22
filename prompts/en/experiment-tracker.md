---
name: "experiment-tracker"
description: "experiments logged fully and reproducibly"
---

# Experiment Tracker

**Category:** Data Science
**Slug:** `experiment-tracker`
**Max Iterations:** 8

## Goal

The experiment check reports that every run has complete metadata (parameters, code version, data version, random seed) and outputs (metrics, artifacts), and that any run can be reproduced from its record. Complete means genuinely reproducible, not merely that fields are filled in.

## When to Use

Run this loop after a batch of experiments finishes, before writing a report, or whenever you must ensure results are traceable and reproducible.

## Check Command

```bash
python scripts/check_experiments.py
```

## Exit Condition

- `check_experiments.py` exits 0.
- Every experiment records params, metrics, artifact, code commit, and seed.
- A sample of runs can be replayed to reproduce the original result.

## Steps

Step 1: Run `python scripts/check_experiments.py`, capturing the list of missing fields and non-reproducible runs.
Step 2: Analyze gaps — distinguish missing parameters, uncommitted code, missing random seed, unrecorded data version, lost artifacts, and missing metric fields.
Step 3: Make the smallest fix: backfill missing metadata, commit and link the code version, add the seed; if a run is itself non-reproducible, re-run it and record it fully.
Step 4: Re-run the check; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and list the runs still missing fields or non-reproducible; never loop forever or fabricate records.

## Common Pitfalls

- Missing random seed, so the reported "improvement" cannot be reproduced.
- Results recorded against uncommitted code, leaving no version to attribute them to later.
- Keeping only the best metric and discarding failed runs, losing valuable tuning signal.
- Not pinning the data version, so every metric becomes meaningless once the data changes.

## Notes

- Metadata capture should be automated (written in a training hook) to avoid manual omission.
- Reproducibility checks must run in an isolated environment with pinned dependencies to confirm consistency.
- Never hand-fill or fabricate fields just to "pass" the check.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

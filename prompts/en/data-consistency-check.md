---
name: "data-consistency-check"
description: "no orphaned records or constraint violations"
---

# Data Consistency Check

**Category:** Database
**Slug:** `data-consistency-check`
**Max Iterations:** 5

## Goal

Ensure the dataset has no orphaned records, foreign-key violations, or broken constraints — every class of consistency assertion passes. Success means the data is self-consistent and safe for queries, reporting, and downstream processing.

## When to Use

After data migrations, after bulk soft-delete operations, or during periodic data-health reviews to find and fix accumulated referential and constraint issues.

## Check Command

```bash
npm run db:consistency
```

## Exit Condition

- All consistency checks pass with exit code 0.
- Violation counts in the report are zero (no orphans, no broken foreign keys, no unique-constraint conflicts).

## Steps

Step 1: Run `npm run db:consistency`, capturing the full report (tables, row counts, and categories of violations).
Step 2: Analyze violations by category — orphaned records from soft deletes, broken foreign keys from missing cascades, unique conflicts from concurrent writes. Find the root cause, not just the offending rows.
Step 3: Apply the smallest data fix (re-link orphans, add missing cascades, deduplicate) or correct the missing constraint/cascade rule; never mask issues by loosening checks or excluding rows via `WHERE`.
Step 4: Re-run the check; if violations remain and you're under max iterations (5), return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining violation categories and their scope; never loop forever or silently ignore issues.

## Common Pitfalls

- Soft-delete orphans: a parent is soft-deleted but children still reference it, which plain foreign-key checks miss.
- Deleting only the offending rows: hides the root cause; the problem recurs on new data.
- Checks out of sync with production schema: the check script targets an old schema and misses new tables/constraints.
- Order sensitivity: concurrent writes cause transient violations during the check — distinguish real corruption from transaction timing.

## Notes

- Back up affected data before fixing; data fixes are not reversible.
- Distinguish whether code (missing constraints/cascades) or data needs fixing, to avoid patching only data and leaving the gap.
- Checks on large tables can be slow; mind the run window and locking impact.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

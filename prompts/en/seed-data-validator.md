---
name: "seed-data-validator"
description: "seed data loads cleanly and references are valid"
---

# Seed Data Validator

**Category:** Database
**Slug:** `seed-data-validator`
**Max Iterations:** 5

## Goal

Ensure seed data loads fully into a clean (reset) database, all foreign keys and references are valid, and every `test:seed` assertion passes. Success means any developer running this flow gets a consistent, deterministic initial dataset.

## When to Use

Use for project initialization, CI pipelines, or after changing seed scripts or database schema to verify reproducible seeding.

## Check Command

```bash
npm run db:seed && npm run test:seed
```

## Exit Condition

- `db:seed` exits 0 with no errors or warnings.
- Every assertion in `test:seed` (row counts, foreign-key integrity, unique constraints) passes.
- A re-run of the command is stable (deterministic).

## Steps

Step 1: Run `npm run db:seed` against a clean database, capturing full stdout/stderr.
Step 2: If it fails, isolate the root cause — common issues are foreign-key insertion order, unique-constraint collisions, missing required fields, or references to records that don't exist yet. Fix each directly; never mask errors with try/catch or empty data.
Step 3: After applying the smallest fix (reorder loading, fill missing fields, correct fixture values), run `npm run test:seed` to verify referential integrity.
Step 4: If still failing and under max iterations (5), return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining blockers; never loop forever or skip checks.

## Common Pitfalls

- Foreign-key order: inserting child rows before parents references non-existent records.
- Non-determinism: random values or unfixed timestamps make runs differ and tests flaky.
- Unique constraints: duplicate seed rows or hardcoded IDs colliding with existing data.
- Partial failures ignored: seed logs errors but still exits 0, masking real problems.

## Notes

- Modify only seed scripts and fixtures; do not change schema migrations or production code.
- Reset the database before each run to guarantee a truly clean environment and avoid false passes from leftover data.
- Never weaken or skip assertions just to make the test pass.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

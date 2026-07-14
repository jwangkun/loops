---
name: "schema-migration-loop"
description: "schema change is migrated and tests pass"
---

# Schema Migration Loop

**Category:** Database
**Slug:** `schema-migration-loop`
**Max Iterations:** 8

## Goal

Complete an end-to-end database schema change: update `schema.prisma`, generate and cleanly apply the migration, and make `npx prisma migrate dev && npm test` exit 0 overall. Migration and tests must both pass — neither alone is sufficient.

## When to Use

Use after a structural schema change (new tables/columns, type changes, indexes/constraints, relationship edits) to drive the closed loop of "edit schema → generate migration → apply → run tests → fix" until both migration and tests are green.

## Check Command

```bash
npx prisma migrate dev && npm test
```

## Exit Condition

- `npx prisma migrate dev` generates and applies the migration with no drift and no errors.
- `npm test` exits with code 0 and all tests pass.
- The generated client is regenerated (prisma client up to date).

## Steps

Step 1: Run `npx prisma migrate dev && npm test`, capturing migration output and test output separately.
Step 2: Analyze failure points — distinguish migration-generation failures (schema syntax / irreversible change / data-loss risk), apply failures (type incompatibility / constraint violation), and test failures (old fixtures no longer matching the new schema, changed query fields).
Step 3: Make the smallest fix: correct `schema.prisma` and the migration SQL first, then sync affected fixtures/seed data/query code. Never delete legitimate tests or relax assertions just to make tests pass.
Step 4: Re-run the check command; if migration or tests still fail and you are under max iterations, go back to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining migration and test blockers separately; never loop forever.

## Common Pitfalls

- Editing migration SQL before updating the schema, causing the two to diverge and `migrate dev` to repeatedly detect drift.
- Irreversible / data-loss-prone changes (dropping a column, narrowing a type) being blocked by the migration tool and then force-bypassed as if it were a bug.
- Test fixtures/seed data not synced with the schema, so the migration passes but tests turn broadly red.
- Using `db push` to bypass migrations so tests pass, leaving an unversioned schema diff behind.

## Notes

- Schema and migrations must stay mutually consistent; every schema change must land via a real migration.
- Never disable constraint checks or delete real test cases to make tests pass.
- For destructive changes, assess the impact on existing data and downstream consumers first; add a patch migration when necessary.
- Modify only schema, migrations, the prisma client, and directly related tests/fixtures; avoid unrelated refactors.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

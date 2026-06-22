---
name: "migration-until-applied"
description: "all database migrations applied clean"
---

# Migration Until Applied

**Category:** Dependencies
**Slug:** `migration-until-applied`
**Max Iterations:** 5

## Goal

Make `npx prisma migrate status` report that all migrations are applied successfully with no drift and no pending migrations. If schema or SQL errors occur, fix the migrations themselves rather than bypassing validation or hand-editing the database.

## When to Use

Use after adding/modifying migration files or when syncing database state across environments, to confirm the migration chain is fully landed on the target database.

## Check Command

```bash
npx prisma migrate status
```

## Exit Condition

- `npx prisma migrate status` exits with code 0.
- Output shows "Database schema is up to date" with no pending migrations.
- No drift warning (migration history matches the filesystem).

## Steps

Step 1: Run `npx prisma migrate status`, capture output, and identify pending migrations, drift, or failed records.
Step 2: Analyze the problem — distinguish not-yet-applied, mid-apply failure, history/filesystem mismatch, and schema-vs-SQL type incompatibility.
Step 3: Make the smallest fix: apply pending migrations with `prisma migrate deploy`; for a failed migration, correct the SQL/schema and retry; never hand-edit the down/history of an already-applied migration.
Step 4: Re-run the check command; if still not clean and you are under max iterations, go back to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining pending/drift/failed migrations; never loop forever.

## Common Pitfalls

- Hand-editing the `_prisma_migrations` table or already-applied migration files to "resolve" drift, sowing cross-environment inconsistency.
- Using `migrate dev` in production (which can reset data); production must use `migrate deploy`.
- Wrong migration ordering: dropping/renaming a column in a migration that runs before a dependent migration.
- Asymmetric down vs up migrations, leaving dirty state after rollback and re-apply.

## Notes

- Fix migration failures by editing the migration file or adding a patch migration; never tamper with migration history.
- Never run destructive migrations against a database with existing data without a backup.
- Touch only migration and schema files; avoid unrelated changes.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

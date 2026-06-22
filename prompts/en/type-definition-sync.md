---
name: "type-definition-sync"
description: "Types match runtime API and DB schema"
---

# Type Definition Sync

**Category:** Code Quality
**Slug:** `type-definition-sync`
**Max Iterations:** 8

## Goal

Make TypeScript types fully consistent with the real runtime API responses and database schema, so `tsc --noEmit` passes cleanly without relying on casts or assertions like `as` / `@ts-ignore` to suppress errors.

## When to Use

Use when the API or database schema has changed, runtime data has drifted from type definitions, or the code has accumulated type assertions.

## Check Command

```bash
npx tsc --noEmit
```

## Exit Condition

- `npx tsc --noEmit` exits with code 0.
- No new `as`, `@ts-ignore`, or `any` assertions added merely to bypass type errors (pre-existing justified assertions excepted, each documented).
- Type sources (hand-written interfaces / generated types / ORM entities) match the runtime data.
- If 8 iterations are reached without success, stop and report.

## Steps

Step 1: Run `npx tsc --noEmit`, capturing all type errors with their file/line locations.
Step 2: Compare against the runtime (actual API responses, DB schema/migrations, ORM entities) to locate drift and decide whether "types lag runtime" or "runtime lags types".
Step 3: Apply the smallest fix: update type definitions to match runtime facts; if types are generator-produced, change the source schema and regenerate instead of hand-editing generated files.
Step 4: Re-run `npx tsc --noEmit`; if errors remain and you are under 8 iterations, go back to Step 2.
Step 5: If 8 iterations are reached without success, stop and list the remaining type errors and root causes (e.g. missing schema field, un-migrated API).

## Common Pitfalls

- Flattening type errors with `as` / `@ts-ignore` to create a false "passing" appearance.
- Hand-editing generator-produced type files that get overwritten on the next generation.
- Making tsc pass without checking real runtime fields, so types and data stay mismatched.
- Removing seemingly-unused optional fields that downstream consumers actually rely on.

## Notes

- Runtime facts take precedence: types should follow the data, not the other way around.
- Distinguish hand-written from generated types; generated types must be regenerated from source.
- Do not loosen to `any` or `unknown` just to compile.
- Schema/interface changes are cross-module contracts; notify callers and update docs.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

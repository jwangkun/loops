---
name: "openapi-sync-until-valid"
description: "openapi.yaml lints clean and matches routes"
---

# OpenAPI Sync Until Valid

**Category:** API/Specs
**Slug:** `openapi-sync-until-valid`
**Max Iterations:** 10

## Goal

Make `openapi.yaml` pass lint (no syntax/structural errors) and stay fully consistent with the routes, methods, and parameters actually implemented in code — no orphaned routes and no drifted fields.

## When to Use

Use after adding, renaming, or deleting API routes, or after changing request/response structures, to bring the OpenAPI spec in sync with the implementation. Also for pre-release spec consistency checks.

## Check Command

```bash
npx @redocly/cli lint openapi.yaml
```

## Exit Condition

- `npx @redocly/cli lint openapi.yaml` exits 0.
- No lint errors or warnings in the spec.
- Every route in code has a matching spec definition, and no spec route is unimplemented.

## Steps

Step 1: Run `npx @redocly/cli lint openapi.yaml`, recording all errors and warnings (missing fields, wrong types, duplicate operationIds, unresolved $refs).
Step 2: Compare the spec against route registration code to find routes missing from the spec, orphaned routes still documented, and parameter/response drift.
Step 3: Apply the smallest fix: add missing paths and operations, fix schema references, remove orphaned entries; never silence lint rules to hide problems.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining lint errors and inconsistent routes; never loop forever.

## Common Pitfalls

- Fixing lint errors but ignoring drift between spec and implemented routes.
- Orphaned routes left in the spec after deletion, creating "ghost endpoints".
- Copy-pasting operations and producing duplicate operationIds.
- Silencing warnings with rule disables instead of actually fixing them.

## Notes

- Spec and code must be consistent in both directions: neither more nor less.
- When editing response schemas, update examples and error codes too.
- On route migration, update the spec before migrating code to avoid long-term drift.
- Never delete a legitimate route definition just to make lint pass.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

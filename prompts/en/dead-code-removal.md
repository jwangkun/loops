---
name: "dead-code-removal"
description: "no unused exports, variables, or functions remain"
---

# Dead Code Removal

**Category:** Code Generation  
**Slug:** `dead-code-removal`  
**Max Iterations:** 5

## Goal
Remove every unused export, variable, function, and file in the repo so the dead code analyzer reports zero dead code and all tests pass. Each deletion is confirmed to avoid removing code used via dynamic references. Success means the codebase no longer carries any confirmed dead code.

## When to Use
After a major refactor or feature deprecation, or during periodic maintenance, to clear accumulated orphaned code and reduce maintenance cost.

## Check Command

```bash
npx knip --no-exit-code && npm test
```

## Exit Condition
- knip output reports no dead code items
- `npm test` exits 0

## Steps
Step 1: Run `npx knip --no-exit-code` and tests, capturing the analyzer's full output to assemble the list of dead code to handle.
Step 2: Evaluate each item: confirm whether it is truly dead code, paying special attention to dynamic imports, string-referenced exports, symbols loaded by plugins/CLI/config by name, and references triggered only by type inference — these are commonly misjudged.
Step 3: Make minimal deletions for confirmed items (remove unused exports/variables/functions/files); keep uncertain items and record them; never use `// @ts-expect-error` or empty stubs to "clear" the report.
Step 4: Re-run knip and tests; if items remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without a zero report, stop and report remaining items and the reasons they could not be confirmed (e.g. suspected dynamic references); do not loop forever.

## Common Pitfalls
- Deleting exports used by dynamic `import()`, `require()`, string property access, or plugin systems, causing runtime crashes.
- Forgetting to re-run tests after deletion, leaving references to removed symbols.
- Replacing deletions with empty functions/placeholder exports to make the analyzer "zero out", which only introduces new dead code.

## Notes
- Handle one related group of items at a time, so failures are easy to locate and roll back.
- For exports that are part of a public API or referenced by external packages, confirm there are no external consumers before deleting.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

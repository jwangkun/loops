---
name: "knip-until-clean"
description: "knip reports zero unused code or deps"
---

# Knip Until Clean

**Category:** Code Quality  
**Slug:** `knip-until-clean`  
**Max Iterations:** 5

## Goal
Get knip to report zero unused files, exports, types, dependencies, or configuration entries, exiting 0. After removing genuinely dead code and unused deps, all tests still pass. Success means the repo carries no redundancy that knip can detect.

## When to Use
Periodic cleanup, or after deleting a feature or refactoring, to ensure no orphaned code or dependencies are left behind.

## Check Command

```bash
npx knip
```

## Exit Condition
- `npx knip` exits 0 with no reported items
- After dead code removal, `npm test` still passes

## Steps
Step 1: Run `npx knip` and capture the full output, grouping items by category (unused files, exports, dependencies, etc.).
Step 2: Confirm each item is truly dead code: watch for dynamic imports, exports referenced via reflection/strings, and modules loaded by plugins or config by name — these are high false-positive areas.
Step 3: Delete confirmed-dead files/exports and `npm uninstall` confirmed-unused dependencies; for uncertain items, keep them and list them in the report; never delete blindly.
Step 4: Re-run knip and tests; if items remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without a clean run, stop and report remaining items and the reasons they could not be confirmed (e.g. suspected dynamic references); do not loop forever.

## Common Pitfalls
- Deleting exports used via dynamic imports, string references, plugin loading, or reflection, which only fail at runtime.
- Forgetting to re-run tests after deletion, missing a live caller of a removed helper.
- Uninstalling a dependency that is only used in specific contexts (tests, Storybook, scripts) as if it were unused.

## Notes
- Be cautious with every removal: prefer keeping and reporting over deleting for the sake of a zero report.
- If knip config needs adjusting (e.g. marking entry files), do it outside this loop and validate it.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

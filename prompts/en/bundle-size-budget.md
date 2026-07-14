---
name: "bundle-size-budget"
description: "client bundle stays within budget"
---

# Bundle Size Budget

**Category:** Performance
**Slug:** `bundle-size-budget`
**Max Iterations:** 5

## Goal

Keep client build artifacts within the `size-limit` budget to protect first-load and runtime performance. Success means `npm run build && npm run size-limit` passes and every budget entry (main bundle, async chunks, per-route/entry splits) is within threshold — not just the main bundle.

## When to Use

Use after adding or upgrading a large dependency, when a new page/feature inflates output, or to guard a performance budget in CI.

## Check Command

```bash
npm run build && npm run size-limit
```

## Exit Condition

- `size-limit` reports all entries passing (exit 0).
- No chunk exceeds its corresponding budget.
- The first-paint-critical bundle is within budget without sacrificing maintainability.

## Steps

Step 1: Run `npm run build && npm run size-limit`; capture the failing entries, bytes over budget, and affected chunks.
Step 2: Locate the bloat source: largest dependencies (build report/source-map-explorer), duplicate packaging, non-tree-shaken named imports, or oversized polyfills.
Step 3: Apply the smallest correct fix: route-level lazy loading, swap to a lighter equivalent, fix import paths to enable tree-shaking, or drop unused polyfills; avoid lazy-loading everything as a blanket fix.
Step 4: Re-run build and `size-limit`; if still over and under max iterations, go to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining over-budget entries with recommendations (e.g. whether to raise a budget); never loop forever.

## Common Pitfalls

- Lazy-loading every page to "pass", increasing interaction latency — a false win.
- Watching only the main bundle, missing real growth in async or shared chunks.
- Swapping dependencies without verifying feature parity, introducing behavioral regressions.
- Lowering budget thresholds to "pass", masking real bloat.

## Notes

- Fix the root cause (dependency size, tree-shaking) rather than masking by splitting chunks one by one.
- Any dependency swap must land only after tests pass.
- Build-config changes must match team conventions and not break the existing chunk strategy.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

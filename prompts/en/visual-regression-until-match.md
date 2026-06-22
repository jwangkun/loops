---
name: "visual-regression-until-match"
description: "Clear unintended UI diffs until visuals pass"
---

# Visual Regression Until Match

**Category:** Testing
**Slug:** `visual-regression-until-match`
**Max Iterations:** 6

## Goal

Make the `@visual`-tagged visual regression suite pass with exit code 0. Of all pixel diffs, only intentional design changes (requiring a baseline update) may be kept; unintended diffs must be fixed in product code or styles to match the baseline.

## When to Use

After UI refactors, component changes, or design-system upgrades produce snapshot diffs and you must distinguish intentional style changes from accidental regressions, handling each accordingly.

## Check Command

```bash
npx playwright test --grep @visual
```

## Exit Condition

- `npx playwright test --grep @visual` exits 0.
- All visual cases match the baseline; any baseline update corresponds to a clearly intentional design change.
- Max iterations not reached.

## Steps

Step 1: Run `npx playwright test --grep @visual`, collecting each failing case's diff report, expected/actual screenshots, and affected scope.
Step 2: Classify each diff: intentional design change → prepare a baseline update; accidental regression → locate the component/style/layout root cause. Ignore non-meaningful noise like anti-aliasing or font rendering.
Step 3: For unintended diffs, apply the smallest style or component fix to match the baseline; only for intentional changes update the corresponding snapshot baseline with a stated reason — never batch-approve.
Step 4: Re-run the command; if diffs remain and under max iterations, go to Step 2.
Step 5: If max iterations are reached with unresolved diffs, stop and report each remaining diff (intentional/accidental verdict, affected component, screenshot links); never loop forever.

## Common Pitfalls

- Baseline drift: bulk-updating snapshots permanently masks real regressions.
- Ignoring environmental variance: fonts, anti-aliasing, viewport, and animation timing cause false positives across machines.
- Treating layout regressions as noise: size/spacing diffs are often real regressions and should not be waved through.

## Notes

- Do not batch-approve all diffs to pass quickly.
- Baseline updates must map one-to-one to intentional, reviewed design changes.
- Prefer fixing product code to match the existing baseline; update baselines only when the design genuinely changed.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

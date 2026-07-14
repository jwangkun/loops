---
name: "responsive-until-match"
description: "UI renders correctly on all target breakpoints"
---

# Responsive Until Match

**Category:** Frontend
**Slug:** `responsive-until-match`
**Max Iterations:** 8

## Goal

Make the UI render correctly on every target breakpoint (mobile, tablet, desktop, wide): no overflow, no truncated content, and interactive elements stay reachable and non-overlapping. Success means the full `@responsive` Playwright suite passes — not just a single viewport.

## When to Use

Use after adding or refactoring a layout component, when adjusting breakpoint strategy, or to guard against responsive regressions in CI.

## Check Command

```bash
npx playwright test --grep @responsive
```

## Exit Condition

- The Playwright `@responsive` suite passes fully (exit 0).
- No layout overflow, truncation, or element overlap on any target viewport.
- Interactive elements are visible and clickable on every viewport.

## Steps

Step 1: Run `npx playwright test --grep @responsive`; capture failing cases, the failing viewport sizes, and assertion messages.
Step 2: Analyze each failure by type: fixed-width overflow, misconfigured flex/grid, missing media query, undersized touch targets, or positioning errors that appear only at one breakpoint.
Step 3: Apply the smallest fix using fluid layout, responsive utility classes, or correct breakpoint styles; do not introduce hardcoded pixels or single-viewport patches.
Step 4: Re-run the suite; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining failures with viewport and screenshot evidence; never loop forever.

## Common Pitfalls

- Debugging only on the desktop viewport, missing real mobile layout issues.
- Forcing one viewport into place with fixed `px` widths or `!important`, breaking other breakpoints.
- Ignoring touch-target size and accessibility, making mobile taps hard.
- Editing global styles without assessing the ripple effect on other pages.

## Notes

- Fix only the failing responsive layout; do not opportunistically refactor unrelated components.
- Verify changes manually across all target viewports — do not trust a single breakpoint's pass.
- Global or shared style changes must be assessed for cross-page impact.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

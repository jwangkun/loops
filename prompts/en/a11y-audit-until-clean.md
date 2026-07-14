---
name: "a11y-audit-until-clean"
description: "changed UI has no severe accessibility violations"
---

# A11y Audit Until Clean

**Category:** Accessibility
**Slug:** `a11y-audit-until-clean`
**Max Iterations:** 10

## Goal

Eliminate all serious/critical accessibility violations on the routes/pages touched by this change so that `npm run test:a11y` (e.g. axe) passes with zero failures. Fixes must address root causes rather than merely silencing tool warnings, improving real keyboard, screen-reader, and contrast usability.

## When to Use

Use after adding or modifying UI components, page layouts, or forms to verify the change introduces no severe accessibility regressions.

## Check Command

```bash
npm run test:a11y
```

## Exit Condition

- `npm run test:a11y` exits with code 0.
- The report contains no serious / critical violations.
- Moderate / minor violations that affect core interaction should also be fixed where feasible.

## Steps

Step 1: Run `npm run test:a11y` and capture each violation's rule ID, node selector, and help text.
Step 2: Analyze root causes — separate DOM-order issues, missing semantic labels, focus-management gaps, and contrast failures; avoid fixing one report item while ignoring the underlying class of problem.
Step 3: Make the smallest fix: prefer native semantic elements and correct ARIA roles to fix root causes; never mask with `aria-hidden` or empty `alt`. Keep visual appearance and behavior unchanged.
Step 4: Re-run the check command; if violations remain and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining violations with root-cause analysis; never loop forever.

## Common Pitfalls

- Treating symptoms, not causes: hiding offending nodes with `aria-hidden` instead of fixing semantics or focus order.
- Misclassifying contrast problems as ARIA problems — contrast needs background/foreground color changes, not labels.
- Introducing a new violation while fixing another (e.g. adding `alt` then breaking focus order) with no regression check.
- Automated tools catch only ~30–40% of accessibility issues; passing automation is not the same as passing manual audit — do not overclaim "fully accessible."

## Notes

- Fixes must not change existing visual appearance or interaction (unless the appearance itself is the violation root cause, e.g. contrast).
- Do not lower tool strictness or skip rules to pass the check.
- Audit and fix only the UI touched by this change; avoid large unrelated changes.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "design-token-sync"
description: "all UI uses approved design tokens"
---

# Design Token Sync

**Category:** Frontend
**Slug:** `design-token-sync`
**Max Iterations:** 8

## Goal

Make every UI visual value — color, spacing, font size, radius, shadow — come from the approved set of design tokens, eliminating hardcoded literals. Success means `lint:design-tokens` passes and styles are fully driven by, themable through, and uniformly changeable via the design system.

## When to Use

Use after adopting or upgrading a design system, when refactoring styles to support themes (e.g. dark mode), or to guard design-spec consistency in CI.

## Check Command

```bash
npm run lint:design-tokens
```

## Exit Condition

- `lint:design-tokens` passes (exit 0).
- No hardcoded color, spacing, font-size, radius, or shadow literals.
- Every visual value is traceable to a design token.

## Steps

Step 1: Run `npm run lint:design-tokens`; capture hardcoded values with file, line number, and the literal value (color, spacing, etc.).
Step 2: Categorize hardcoded values: color, spacing, font size, radius, shadow, or z-index; confirm whether each has an equivalent in the existing token set or needs a new token.
Step 3: Replace literals with the matching token variable/utility class; if a new value is genuinely needed, register and review it in the token source file first; keep changes minimal.
Step 4: Re-run `npm run lint:design-tokens`; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining hardcoded list with recommendations; never loop forever.

## Common Pitfalls

- Wrapping a hardcoded value in a token variable (e.g. `--color-x: #fff`) to fake compliance, without truly adopting the design system.
- Adding tokens that break naming conventions or are unregistered, bloating and duplicating the token set.
- Picking the wrong token semantic during replacement (e.g. brand color for a neutral), diverging from design intent.
- Ignoring dynamic/theme-related values, breaking dark mode or theme switching.

## Notes

- Replace only visual literals with tokens; do not change component behavior or layout logic.
- New tokens must be registered in the token source file and follow naming conventions.
- Inline styles in third-party components that cannot be replaced must be explicitly documented and excluded, not silently ignored.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

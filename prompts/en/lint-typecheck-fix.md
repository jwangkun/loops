---
name: "lint-typecheck-fix"
description: "lint and typecheck report zero issues"
---

# Lint & Typecheck Fix

**Category:** Code Quality  
**Slug:** `lint-typecheck-fix`  
**Max Iterations:** 5

## Goal
Get lint and typecheck fully green with exit code 0 and no remaining warnings or errors. Every reported issue is fixed with a minimal, targeted diff — never by suppressing rules or bypassing the type system. Success means the code is merge-ready.

## When to Use
Before merging or committing a change, especially when types were added/changed or lint rules started firing.

## Check Command

```bash
npm run lint && npx tsc --noEmit
```

## Exit Condition
- Both `npm run lint` and `npx tsc --noEmit` exit 0
- No new warnings, errors, or type errors remain

## Steps
Step 1: Run the check and capture the full output (errors grouped by file/rule).
Step 2: Analyze each failure: separate lint style issues, potential-bug warnings, and type errors; find the root cause per report, not just the symptom.
Step 3: Fix the code itself with the smallest possible diff; never mask issues via `eslint-disable`, `@ts-ignore`, loosened rules, or `any`.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report the remaining blockers (file, rule, error summary); do not loop forever.

## Common Pitfalls
- Forcing a pass with `eslint-disable`, `@ts-ignore`, or `as any`, which hides real problems.
- Fixing one type error triggers a cascade of downstream errors — re-run to confirm full green.
- Mistaking pre-existing baseline warnings for newly introduced ones, widening the diff to historical code.

## Notes
- Only modify files relevant to this change; avoid opportunistically reformatting unrelated code.
- If a rule itself seems wrong, note it for separate discussion instead of changing config inside this loop.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

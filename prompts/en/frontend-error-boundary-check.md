---
name: "frontend-error-boundary-check"
description: "every route has an error boundary and fallback UI"
---

# Frontend Error Boundary Check

**Category:** Frontend
**Slug:** `frontend-error-boundary-check`
**Max Iterations:** 8

## Goal

Ensure every route in the app (including lazy-loaded async routes) is covered by an Error Boundary with a user-visible fallback UI and a recovery path. The final lint check must pass with zero violations, so users never see a full-page white screen when a route throws during render.

## When to Use

Use after adding new routes, restructuring routing, or introducing async components that may throw, to confirm error boundary coverage has no gaps.

## Check Command

```bash
npm run lint:error-boundaries
```

## Exit Condition

- `npm run lint:error-boundaries` exits with code 0.
- The lint report shows every route is covered by an error boundary.
- New/changed routes have a corresponding fallback UI implementation.

## Steps

Step 1: Run `npm run lint:error-boundaries`, capture the output, and list the uncovered routes.
Step 2: Analyze gaps — distinguish root-level from page-level boundaries; confirm high-risk areas (lazy-loaded chunks, Suspense subtrees, forms) have nearby coverage.
Step 3: Make the smallest fix: wrap uncovered routes with an error boundary component and implement a fallback UI (error message plus a recovery/retry entry). Never use an empty fallback or try/catch to swallow errors.
Step 4: Re-run the check command; if violations remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining uncovered routes; never loop forever.

## Common Pitfalls

- Placing a single error boundary at the app root, so a child route error unmounts the whole subtree and loses navigation state.
- Empty or `null` fallback UI — technically "covered" but equivalent to a white screen for the user.
- Assuming error boundaries catch async errors (e.g. rejected promises in `useEffect`); those need separate handling.
- Using `try/catch` inside the component body to swallow exceptions and "pass" the lint, masking real defects.

## Notes

- Error boundaries should capture render-time exceptions and provide a recovery path (retry / go home / report), not silently degrade.
- Do not remove routes or comment out throwing components just to make the lint pass.
- Restrict changes to error boundary and fallback code; avoid unrelated refactors.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

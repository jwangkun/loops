---
name: "error-handling-audit"
description: "Consistent error handling across public functions"
---

# Error Handling Audit

**Category:** Code Quality
**Slug:** `error-handling-audit`
**Max Iterations:** 8

## Goal

Ensure every public function has consistent, explicit error handling: no swallowed exceptions, no unhandled promise rejections, and errors logged and propagated in a uniform way. Final verification is done by lint plus tests.

## When to Use

Use when a module's error handling is inconsistent (mixed try/catch, bare catch, unhandled `async/await` rejections, silently swallowed errors) as a robustness gate before release.

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition

- Both `npm run lint` and `npm test` exit with code 0.
- None of these patterns remain: empty catch, swallowed errors, `async` functions with no rejection handling, returning `undefined` in place of an error.
- Every newly added or corrected error path has corresponding test coverage.
- If 8 iterations are reached with leftovers, stop and report.

## Steps

Step 1: Run `npm run lint && npm test`, capturing failures and warnings.
Step 2: Scan flagged functions and similarly suspect ones; for each, decide: should the error propagate, be logged then propagated, or be recovered locally? State the strategy explicitly.
Step 3: Apply the smallest change per function to implement that strategy (add catch, convert error type, add logging, fix the test); never erase an error via `catch {}` or `Promise.catch(() => {})`.
Step 4: Re-run the check; if failures remain and you are under 8 iterations, go back to Step 2.
Step 5: If 8 iterations are reached with leftovers, stop and list the remaining unhandled paths plus recommended strategies.

## Common Pitfalls

- Swallowing an exception into silent success, so upstream cannot detect failure.
- Logging inside catch without re-throwing, so callers wrongly assume success.
- Wrapping every error into a generic Error, losing the original type and stack.
- Adding only happy-path tests, leaving error paths unverified.

## Notes

- Error-handling strategy must be consistent within a module: pick propagate, log, or recover, and declare it explicitly.
- Preserve the original error chain (cause / wrapped error) for debugging.
- Do not place rule exemptions at the top of a function just to pass lint.
- Changing error behavior is a semantic change; update callers and tests accordingly.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

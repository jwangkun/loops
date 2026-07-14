---
name: "de-sloppify-pass"
description: "this change is clean and minimal"
---

# De-Sloppify Pass

**Category:** Code Quality  
**Slug:** `de-sloppify-pass`  
**Max Iterations:** 3

## Goal
Ensure the code in this diff is clean, minimal, and free of leftover draft artifacts. Remove all debugging code, dead branches, placeholder implementations, and careless naming; lint and tests must stay green. Success means the change reads like intentional final code, not a one-off scratch pass.

## When to Use
Run this on the latest set of changes before committing or requesting review, to ensure no draft code reaches the main branch.

## Check Command

```bash
npm run lint && npm test
```

## Exit Condition
- No debugging code, commented-out code, dead branches, or `TODO/FIXME` placeholders in this diff
- Both `npm run lint` and `npm test` exit 0

## Steps
Step 1: Run the checks and capture output; also review the full uncommitted diff with `git diff`.
Step 2: Scan the diff item by item: look for `console.*`/print statements, hardcoded temp values, commented-out code blocks, unreachable dead branches, misleading names, and duplicated or redundant implementations.
Step 3: Fix each with the smallest possible change: remove debug code, delete dead branches, rename for clarity, deduplicate; do not loosen lint rules to bypass issues.
Step 4: Re-run lint and tests; if issues remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without a clean pass, stop and report the remaining sloppiness list; do not loop forever.

## Common Pitfalls
- Missing `console.log`/print calls, `debugger` statements, or debug toggles that only run locally.
- Leaving a "just for now" placeholder as if it were finished, without real logic or removal.
- Doing a large rename or refactor at once that exceeds "minimal" scope and makes review hard to follow.

## Notes
- Scope changes to this change only; do not opportunistically rewrite unrelated historical code.
- Before deleting code, confirm it is truly unreferenced to avoid removing a live branch or helper.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

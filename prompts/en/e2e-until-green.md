---
name: "e2e-until-green"
description: "Fix failing specs until the E2E suite passes"
---

# E2E Until Green

**Category:** Testing
**Slug:** `e2e-until-green`
**Max Iterations:** 10

## Goal

Make the end-to-end suite pass in a clean run with exit code 0. Success means fixing real defects or brittle specs — not masking them with sleeps, weakened assertions, or skipped cases.

## When to Use

When the E2E suite fails in CI and you need to fix specs one by one and stabilize the pipeline. Best when case count is manageable and specs can run in isolation.

## Check Command

```bash
npm run test:e2e
```

## Exit Condition

- `npm run test:e2e` exits 0.
- All specs pass with no skips, no timeouts, no pass-only-after-retry cases.
- Max iterations not reached.

## Steps

Step 1: Run `npm run test:e2e`, collecting the failure list, screenshots, traces, and console errors per spec.
Step 2: Take the first failing spec and root-cause it: broken selector, timing race, real product defect, or inherent test brittleness.
Step 3: Make the smallest fix: update the broken selector, add a reliable wait (not a fixed sleep), fix the real defect, or correct the test itself; never skip a case or loosen assertions just to pass.
Step 4: Re-run `npm run test:e2e`; if failures remain and under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining failing specs, fixes attempted, and suspected root causes; never loop forever.

## Common Pitfalls

- Using fixed sleeps instead of deterministic waits: they hide issues and make the suite slow and flaky.
- Brittle selectors: depending on generated classes or nth-child breaks on minor UI changes.
- Treating environment/data issues as spec defects: DB residue or flaky external APIs create false failures.

## Notes

- Do not achieve green by skipping, commenting out, or loosening assertion strictness.
- Distinguish real failures from flaky ones: when unsure, re-run that spec in isolation to verify.
- Focus each iteration on the minimal change for one spec to avoid regressions.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "flaky-test-triage"
description: "Classify failing tests as flaky or real defects"
---

# Flaky Test Triage

**Category:** Testing
**Slug:** `flaky-test-triage`
**Max Iterations:** 8

## Goal

For every failing case in the target suite, produce a clear classification: flaky (non-deterministic) or real (true defect). Real defects must be fixed to stable passing; flaky cases must have their non-determinism source identified and stabilized, not simply skipped.

## When to Use

When a suite fails and you cannot tell whether it is a real bug or an intermittent issue (timing, order, shared state, external dependencies). Use it to classify before fixing, then act on each category.

## Check Command

```bash
npm test -- --testPathPattern=<failing-suite>
```

## Exit Condition

- Every failing case in the suite is classified flaky or real.
- Cases marked real are fixed and pass; cases marked flaky are stabilized or have a documented non-determinism source.
- Max iterations not reached.

## Steps

Step 1: Run `npm test -- --testPathPattern=<failing-suite>` multiple times (at least 5), recording the pass/fail combination of each run.
Step 2: Analyze the failure pattern: consistent failure → real; intermittent failure → flaky. For flaky cases, investigate timing, shared state, execution order, random data, and external API/time/timezone dependencies.
Step 3: Apply the smallest root-cause fix to real cases; eliminate non-determinism in flaky cases (deterministic waits, isolated state, fixed random seeds) rather than skipping or adding sleeps.
Step 4: Re-run the suite multiple times to verify stability; if any case remains unclassified or unstable and under max iterations, go to Step 2.
Step 5: If max iterations are reached with cases still unclassified/unstable, stop and report each remaining case's evidence (failure pattern, reproduction conditions) and suspected root cause; never loop forever.

## Common Pitfalls

- Calling something flaky after a single failure: a single failure is more likely a real defect; multiple runs are required to distinguish.
- Verifying only in isolation: flakiness is often triggered by order/shared state; the full suite must run multiple times.
- Treating external API jitter as test stability: it masks the real non-determinism source.

## Notes

- Do not "solve" flakiness via retry thresholds or skipping cases.
- Classification must be evidence-based (failure pattern, reproduction conditions), not a hunch.
- Prefer stabilization over skipping; only document for human follow-up when stabilization is genuinely infeasible.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

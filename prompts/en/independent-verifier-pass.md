---
name: "independent-verifier-pass"
description: "Build, lint, and tests pass under independent check"
---

# Independent Verifier Pass

**Category:** Maintenance
**Slug:** `independent-verifier-pass`
**Max Iterations:** 1

## Goal

Act as an independent verifier to run a single full build, lint, and test pass and confirm they all pass. The verdict relies solely on the real exit codes and output of the commands, never on "should be fine" assumptions or cached results.

## When to Use

Use before merge, release, or delivery to perform one clean, trusted end-to-end verification of the repository. This loop is a single verification pass and does not iterate on fixes.

## Check Command

```bash
npm run build && npm run lint && npm test
```

## Exit Condition

- `npm run build`, `npm run lint`, and `npm test` each exit with code 0, in sequence.
- Skipping any step or substituting cache for a real run is not acceptable.
- Any step failing means the whole pass failed; the failure point must be recorded truthfully.

## Steps

Step 1: As verifier, run `npm run build && npm run lint && npm test` in order, capturing each command's exit code and output.
Step 2: If all exit codes are 0, record a pass and finish.
Step 3: If any command fails, pinpoint the first failing stage (build / lint / test) and its error message; do not attempt fixes within this loop.
Step 4: Report the failing stage, exit code, and key error excerpt truthfully, handing off to a later fix loop.
Step 5: Do not retry or run a self-soothing second pass; a single failure is reported as-is.

## Common Pitfalls

- Skipping verification because "it passed last time", ignoring that the environment or code changed.
- Treating build cache or incremental results as equivalent to a full verification.
- Dismissing lint/test failures as "not important" on personal judgment.
- Fixing issues inline during this loop, blurring the line between "verify" and "fix".

## Notes

- This loop only verifies, never fixes; preserve the verifier's independence.
- Must run from a clean state so cache does not mask real problems.
- On any step failure, later steps are short-circuited by `&&`; stop and report clearly.
- The report must include the command, exit code, and failure summary for downstream decisions.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

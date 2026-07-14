---
name: "security-audit-weekly"
description: "Deliver a weekly dependency audit summary and fix plan"
---

# Security Audit Weekly

**Category:** Security
**Slug:** `security-audit-weekly`
**Max Iterations:** 1

## Goal

Using the structured output of `npm audit --json`, produce a weekly dependency vulnerability audit summary: grouped by severity, listing affected packages and exploitability, with an actionable remediation priority and plan. The summary targets engineering and security owners for decision-making.

## When to Use

Run as a recurring weekly security review. Not for automated remediation (use npm-audit-fix-loop for that) and not a replacement for CI gates.

## Check Command

```bash
npm audit --json
```

## Exit Condition

- A structured audit summary has been produced covering every high and critical advisory.
- Each advisory is annotated with severity, affected path, exploitability/reachability, suggested fixed version, and recommended action.
- A prioritized fix plan for the week is provided (fix now / next iteration / accept risk with stated justification).

## Steps

Step 1: Run the check command and capture the JSON output; parse `metadata.vulnerabilities` and the `advisories`/`vulnerabilities` nodes.
Step 2: Group by severity; for each high/critical advisory assess the affected dependency path, whether it reaches the production runtime, and whether a fixed version exists. Low/info items can be summarized in aggregate.
Step 3: Write a recommended action for each high-priority item (upgrade version / replace package / temporarily accept with a documented risk rationale). Never fabricate a fixed version that does not exist.
Step 4: Re-run the check command to confirm the output matches the summary (only 1 iteration, so this is validation rather than a loop).
Step 5: If the max iteration count (1) is reached without a complete summary, stop and report what is missing. Never loop forever.

## Common Pitfalls

- Reproducing the human-readable `npm audit` output instead of parsing the JSON misses nested dependencies and reachability information.
- Treating "an advisory exists" as "it is exploitable": you must judge whether the vulnerable code path actually reaches the production runtime.
- Fabricating an "upgrade to x.y.z" recommendation for an advisory with no fixed version misleads downstream remediation work.
- Omitting high-severity devDependency items can be valid, but the rationale must be stated explicitly in the summary rather than silently dropped.

## Notes

- The summary should be understandable to engineers without a security background; lead with the key conclusions.
- Where a genuinely exploitable vulnerability exists, flag in the summary whether a human security owner must be engaged.
- Do not include plaintext secrets or sensitive environment information in the summary.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

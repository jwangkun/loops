---
name: "compliance-checklist-loop"
description: "Satisfy every compliance checklist item with evidence"
---

# Compliance Checklist Loop

**Category:** Security & Compliance
**Slug:** `compliance-checklist-loop`
**Max Iterations:** 15

## Goal

Make `python scripts/compliance_check.py` report a compliance score of 100%, with every check backed by traceable real evidence (configuration, logs, documentation, or code) rather than passing on a checkbox alone.

## When to Use

Use around compliance audits, certification prep (e.g. SOC 2, ISO 27001), or before/after major architectural changes, to close gaps in the checklist item by item. Not for bypassing checks or fabricating compliance status.

## Check Command

```bash
python scripts/compliance_check.py
```

## Exit Condition

- Compliance score is 100% with every checklist item in a passing state.
- Every pass has corresponding real evidence (file path, config item, log, or document) that can be traced during an audit.
- No score was achieved by temporarily editing the check script, hardcoding return values, or disabling checks.

## Steps

Step 1: Run the check command, capturing the output and recording each failing item's ID, requirement, and the reason it is missing.
Step 2: For each failing item, analyze the root cause: a missing control (e.g. audit logging not enabled), an existing control that is misconfigured, or missing documentary evidence. Distinguish "needs to be implemented" from "only needs evidence".
Step 3: Apply the smallest genuine fix: implement the missing control, correct the misconfiguration, or add the corresponding documentary/config evidence. Never boost the score by editing the check script, hardcoding a pass value, or commenting out an assertion.
Step 4: Re-run the check command; if the score is not yet 100% and you are under the max iteration count, go to Step 2.
Step 5: If the max iteration count is reached without reaching 100%, stop and report the remaining failing items, missing evidence, and blocking reasons for a human compliance owner to handle. Never loop forever.

## Common Pitfalls

- Checking items off without retaining evidence makes them non-traceable during an audit, which is equivalent to failing.
- Editing the check script to return a pass, or commenting out a failing assertion, fabricates compliance status and is a serious violation.
- Treating "the check passes" as "the control is effective": confirm the control actually works (e.g. audit logs are truly being recorded), not just that the config exists.
- Many checks depend on the same infrastructure (e.g. SSO, log aggregation); fixing one may affect several items at once, so verify holistically.

## Notes

- Gaps involving real compliance obligations (regulation, certification) are human-escalation events; have a compliance owner confirm the disposition.
- Do not provide guidance that helps fabricate compliance evidence or bypass the check script; evidence must be real and independently auditable.
- When a fix changes production controls (e.g. access policy, log retention), implement it only after review and through the change-management process.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

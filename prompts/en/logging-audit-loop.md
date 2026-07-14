---
name: "logging-audit-loop"
description: "all critical paths produce structured logs"
---

# Logging Audit Loop

**Category:** Backend
**Slug:** `logging-audit-loop`
**Max Iterations:** 8

## Goal

Ensure every critical business path (auth, payments, state changes, error branches) produces structured, machine-parseable logs instead of scattered string concatenation or bare `console.log`. Success means `lint:logging` passes cleanly and every new or modified log carries the required fields (level, event name, traceable id).

## When to Use

Use after adding or changing critical-path logic, when investigating incidents requires searchable logs, or to enforce a team structured-logging standard.

## Check Command

```bash
npm run lint:logging
```

## Exit Condition

- `lint:logging` exits with code 0.
- All critical-path logging uses the approved structured logger.
- No bare `console.log`, string-concatenated logs, or statements missing required fields.

## Steps

Step 1: Run `npm run lint:logging`; capture full output and failing files/line numbers.
Step 2: Analyze each failure by type — bare `console.*`, string-concatenated logs, missing `level`/`event`/`traceId` fields, or logging sensitive data.
Step 3: Replace with the team-approved structured logger, add missing fields, ensure no PII/secrets; make the smallest change, do not rewrite unrelated code.
Step 4: Re-run `npm run lint:logging`; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining failure list and causes; never loop forever.

## Common Pitfalls

- Logging passwords, tokens, PII, or full request bodies, violating compliance and security.
- Missing `traceId`/`requestId`, so cross-service traces cannot be correlated.
- Stringifying exception objects, losing stack and fields; record `error.message` and `stack` as structured values.
- Downgrading or deleting logs just to pass lint, masking real issues.

## Notes

- Replace only log statements; do not opportunistically change business logic or log thresholds.
- Structured field names must match the team logging spec and ingestion pipeline.
- Redact sensitive data before logging, or filter via an allowlist at a higher layer.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "dependency-audit-weekly"
description: "deliver a weekly dependency audit summary"
---

# Dependency Audit Weekly

**Category:** Dependencies
**Slug:** `dependency-audit-weekly`
**Max Iterations:** 1

## Goal

Produce a structured weekly dependency audit summary: list outdated dependencies, group them by risk and category, and recommend a phased upgrade plan (security items first). Success means the team knows exactly what to upgrade this week and where the risks are.

## When to Use

For the weekly routine dependency health check, or to assess dependency risk and tech debt before a release.

## Check Command

```bash
npm outdated || true
```

## Exit Condition

- The audit summary is delivered and covers all outdated dependencies.
- Each entry includes current version, latest version, major versions behind, risk rating, and recommended action.

## Steps

Step 1: Run `npm outdated || true` (the `|| true` prevents the command from aborting when outdated entries exist), capturing the full output table.
Step 2: Cross-reference `npm audit` (if available) to flag security vulnerabilities; categorize: security/compliance, major versions behind (high breakage risk), minor/patch (low risk). Surface hazards in peer and transitive dependencies.
Step 3: Write a minimal but complete report — a phased upgrade plan (security first, then breaking, then low-risk), each item tagged with priority and likely impact; don't inflate or fabricate risk just to fill the report.
Step 4: Re-verify version and vulnerability data for accuracy; this is a single-pass loop (max 1), so do not repeat fix work.
Step 5: If critical data is missing (e.g. audit unavailable), stop and report what's missing plus a fallback; never fill gaps from memory.

## Common Pitfalls

- Equating "outdated" with "risky": a patch version behind is usually low risk; distinguish them.
- Ignoring the security dimension: looking only at `npm outdated` and missing `npm audit` vulnerabilities.
- Reports that pile up version numbers without priorities: the team can't tell where to start.
- Overlooking peer/transitive deps: direct deps look fine while transitive deps hide known vulnerabilities.

## Notes

- This loop only produces a report and recommendations; it does not perform upgrades (use `dependency-upgrade-one-by-one` for that).
- Use the actual command output for data; never fill version numbers from memory or cache.
- Clearly state the audit time window and data sources for traceability.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "npm-audit-fix-loop"
description: "No high or critical vulnerabilities in npm audit"
---

# NPM Audit Fix Loop

**Category:** Security
**Slug:** `npm-audit-fix-loop`
**Max Iterations:** 10

## Goal

Drive `npm audit --audit-level=high` to report zero high/critical vulnerabilities while keeping `npm test` green. Each fix must remove the root cause of the vulnerability, not mask it behind an override.

## When to Use

Use when newly introduced or lingering high/critical advisories appear in dependencies. Not for low/info-level advisories or for release branches with a frozen lockfile.

## Check Command

```bash
npm audit --audit-level=high && npm test
```

## Exit Condition

- `npm audit --audit-level=high` exits with code 0 (no high or critical vulnerabilities).
- `npm test` fully passes.
- No new `overrides`/`resolutions` added to mask advisories, or any new entry carries a traceable justification.

## Steps

Step 1: Run the check command, capturing the full `npm audit` output and test results; record each failing advisory (package, version, CVE, severity, fixed version).
Step 2: Sort by severity and pick the top advisory; analyze its dependency path and available fixed versions, noting whether the upgrade touches other packages' peer deps.
Step 3: Apply the smallest safe fix (prefer `npm update` or upgrading the direct dependency; use `npm audit fix` if needed). Never use `overrides`/`resolutions` to force-pin a version and hide a vulnerability.
Step 4: Re-run the check command; if high/critical advisories remain and you are under the max iteration count, go to Step 2.
Step 5: If the max iteration count is reached without a clean state, stop and report remaining advisories, blocking reasons, and items needing a human decision. Never loop forever.

## Common Pitfalls

- `npm audit fix --force` upgrades across major versions and can break APIs and runtime behavior; always verify against the test suite.
- Peer-dependency conflicts "resolved" with an override make the advisory disappear from the report but leave the root cause intact — that is masking.
- Some advisories originate in devDependencies; their remediation value differs from production dependencies and must be assessed separately.
- Inconsistent lockfiles or multiple `package-lock.json` files can make audit results diverge from what is actually installed.

## Notes

- Prefer fixing on an isolated branch and running the full test suite before merging.
- Record, for every change, "why this is a genuine fix" so it can be traced during audit.
- If no fixed version is available (the vulnerable dependency is unmaintained), report it and evaluate a replacement — do not force a downgrade or override.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

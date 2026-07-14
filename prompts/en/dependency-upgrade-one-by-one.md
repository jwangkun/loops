---
name: "dependency-upgrade-one-by-one"
description: "outdated deps upgraded one by one, tests green"
---

# Dependency Upgrade One By One

**Category:** Dependencies
**Slug:** `dependency-upgrade-one-by-one`
**Max Iterations:** 10

## Goal

Upgrade critical outdated dependencies to the latest available version one at a time, with `npm test` and `npm run build` passing after each upgrade. Success means dependencies are modernized while the trunk stays green, and each step is independently revertible for easy bisection.

## When to Use

When aging dependencies are building tech debt, after security advisories land, or before a major framework upgrade, to modernize steadily.

## Check Command

```bash
npm outdated && npm test && npm run build
```

## Exit Condition

- `npm test` and `npm run build` both exit 0.
- The outdated dependencies in scope are all upgraded (or explicitly documented as deferred with a reason).

## Steps

Step 1: Run the check command, capturing the `npm outdated` output and the test/build results.
Step 2: Pick a single package to upgrade first (security advisories, then major versions behind, then minors), and review its CHANGELOG/migration guide to anticipate breaking changes. Upgrade one package at a time — upgrading several at once defeats bisection.
Step 3: Upgrade that single package and make the smallest code changes to adapt to breaking APIs; never downgrade, pin old versions, or skip tests just to pass.
Step 4: Re-run `npm test && npm run build`; if it fails and you're under max iterations (10), return to Step 2 to keep fixing the current package. Commit each package separately once green, so it can be reverted.
Step 5: If max iterations are reached with packages still failing, stop and report the upgraded packages, the stuck packages, and the blocking reasons; never loop forever.

## Common Pitfalls

- Upgrading several packages at once: when tests fail you can't tell which package caused it, defeating bisection.
- Skipping the CHANGELOG: missing breaking changes and required migration steps.
- Pinning old versions or deleting tests to pass: fakes green and hides real incompatibilities.
- Ignoring peer/transitive deps: a direct dep upgrade leaves peers mismatched, surfacing only at runtime.

## Notes

- Commit one package at a time with the package name and version in the message, for easy revert and audit.
- Commit the lockfile too, so others don't install inconsistent versions.
- Prioritize packages with security advisories, but still follow one-at-a-time.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

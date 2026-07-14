---
name: "build-until-green"
description: "production build exits successfully"
---

# Build Until Green

**Category:** CI/CD
**Slug:** `build-until-green`
**Max Iterations:** 5

## Goal

Make the production build command complete successfully with exit code 0 and produce a usable artifact (e.g. `dist/`, `build/`). Success means the full chain — type checking, compilation, bundling, tree-shaking — is error-free, not merely skipping errors.

## When to Use

To validate releasability locally or in CI; suited to iteratively fixing after dependency upgrades, config changes, or large code changes until the build output is clean and usable.

## Check Command

```bash
npm run build
```

## Exit Condition

- `npm run build` exits with code 0.
- The build artifact exists and is non-empty (e.g. `dist/` or `build/` contains expected files).
- No errors, no unresolved imports, and no type errors in the output.

## Steps

Step 1: Run the check command; capture full stdout/stderr and the exit code, and confirm the build artifact directory.
Step 2: Analyze the first error: determine whether it is a type error, an import-path error, a missing dependency, a build-config (webpack/vite/tsconfig) issue, or an environment-variable/platform (Node version) issue. Fix the first error first, since later errors are often cascades.
Step 3: Make the smallest fix — correct types/imports, install or pin dependency versions, or adjust build config. Never force the build green with `// @ts-ignore`, disabling type checking, stub implementations, or swallowing errors in try/catch.
Step 4: Re-run the check command; if it still fails and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining errors and their files, tagging each suspected root-cause type (type/dependency/config/environment). Never loop forever.

## Common Pitfalls

- Masking type errors with `// @ts-ignore`, `as any`, or disabling type checking: the build goes green but crashes at runtime.
- Dependency version drift (inconsistent lockfile) causing local-green/CI-red or vice versa.
- Ignoring build warnings (circular deps, unused exports) that often foreshadow the next error.
- Fixing a surface error without recognizing it as a cascade root, looping on the same file.

## Notes

- The artifact is for production; do not introduce dev-only logic to fix the build.
- Do not temporarily downgrade dependencies or disable safety/optimization options just to pass.
- If errors stem from environment differences such as Node version, align the environment rather than working around it.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

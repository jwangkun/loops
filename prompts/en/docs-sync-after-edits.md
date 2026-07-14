---
name: "docs-sync-after-edits"
description: "Keep docs consistent with the current code changes"
---

# Docs Sync After Edits

**Category:** Documentation
**Slug:** `docs-sync-after-edits`
**Max Iterations:** 5

## Goal

Keep documentation consistent with the code changes on this branch relative to `main`: newly added public APIs, behaviors, or config options are findable in the docs, and removed or renamed items are deleted or updated so nothing stays stale.

## When to Use

After a round of code edits, ensure README, API docs, and actual code behavior match before merging.

## Check Command

```bash
git diff main...HEAD --name-only
```

## Exit Condition

- Every code change in the diff has had its corresponding documentation checked and updated as needed.
- The docs no longer describe APIs, parameters, or config options that were removed or renamed.

## Steps

Step 1: Run the check command to list every file changed on this branch relative to `main`, separating code files from doc files.
Step 2: For each code change, decide whether it affects public behavior (API signatures, parameters, config, CLI usage, README examples) and locate the affected doc sections.
Step 3: Make the smallest accurate doc update: add notes for new items, delete or rewrite for removed/renamed items, and never leave invalid examples in place.
Step 4: Re-run the check command and re-review the docs to confirm every code change is covered; if not and under max iterations, go to Step 2.
Step 5: If max iterations are hit with inconsistencies remaining, stop and report the uncovered code changes and their corresponding doc locations; never loop forever.

## Common Pitfalls

- Docs describe an API that was deleted or renamed in code without being updated, misleading users.
- Only adding new content while missing syncs for default values, error codes, or parameter order.
- Pasting code examples without verifying they match the current code, leaving examples invalid.
- Writing internal implementation details into user-facing docs and adding noise.

## Notes

- Doc examples must match real signatures/output in the code and be directly copy-pasteable.
- Prioritize user-facing docs; internal architecture notes can be handled as needed.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

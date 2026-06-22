---
name: "post-edit-test-guard"
description: "related tests must pass after edits"
---

# Post-Edit Test Guard

**Category:** Testing
**Slug:** `post-edit-test-guard`
**Max Iterations:** 3

## Goal

After each code edit, run only the tests related to the changed files and ensure those tests all pass with exit code 0. This is a lightweight guard against regressions from local edits; the goal is to confirm, at minimal cost, that "what I changed did not break."

## When to Use

During a development session with frequent code edits, as a final quick defense before commit or merge; especially suited to automatic triggering on every save/edit.

## Check Command

```bash
npm test -- --findRelatedTests <files>
```

## Exit Condition

- All related tests for the changed files pass with exit code 0.
- No failing case has been turned into a skip or comment to force a "pass".
- The command actually executed (not a dry run) and the related test set is non-empty.

## Steps

Step 1: Determine the list of files `<files>` changed in this edit, run the check command, and capture output and exit code.
Step 2: Analyze failures: separate regressions introduced by this edit (changed logic/signature/exports) from pre-existing failures (already broken before the edit). If a pre-existing failure is suspected, verify against the pre-edit version to confirm.
Step 3: Make the smallest fix for regressions introduced by this edit — typically completing a missed type/export, correcting callers, or updating the corresponding test. Never mask a real failure point with `.skip`, relaxed assertions, or mocking it out.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining failures, clearly separating "regressions introduced by this edit" from "pre-existing failures." Never loop forever.

## Common Pitfalls

- The `<files>` list is inaccurate (a changed file is missed or omitted), so related tests never run and produce a false green.
- Misjudging a pre-existing failure as a current regression, wasting iterations fixing something not caused by this edit.
- Forcing a "pass" with `.skip` or relaxed assertions, masking a real regression.
- Changing a public API but running only the directly related files, missing tests of indirect dependents.

## Notes

- This is a local guard and does not replace the full test suite; run the full suite before commit.
- Fix only issues directly related to this edit; do not opportunistically refactor unrelated code.
- If the related test set is empty, be alert — it may mean dependencies were not detected, not that there are truly no tests.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

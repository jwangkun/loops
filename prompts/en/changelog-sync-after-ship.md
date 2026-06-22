---
name: "changelog-sync-after-ship"
description: "Maintain an accurate [Unreleased] changelog"
---

# Changelog Sync After Ship

**Category:** Documentation
**Slug:** `changelog-sync-after-ship`
**Max Iterations:** 1

## Goal

Keep the `CHANGELOG.md` `[Unreleased]` section an accurate record of user-visible changes since the last release, following Keep-a-Changelog format, with nothing missed, nothing duplicated, and no unrelated internal refactors included.

## When to Use

A release or a batch of commits just landed and the changelog must be completed before shipping so users can understand what changed.

## Check Command

```bash
git log -5 --oneline
```

## Exit Condition

- The `[Unreleased]` section exists and covers every user-visible change in the recent commits.
- Each change is categorized correctly (Added/Changed/Deprecated/Removed/Fixed/Security) with no duplicate entries.

## Steps

Step 1: Run the check command to review recent commits; use `git show` where needed to confirm each commit's actual impact.
Step 2: Separate user-visible changes from pure internal refactors/formatting/tests and keep only the former.
Step 3: Write an entry for each change under the correct Keep-a-Changelog category, phrased for users rather than implementation details.
Step 4: Re-check the `[Unreleased]` section to confirm no duplicates, no omissions, and no empty section or placeholder text.
Step 5: If inconsistencies remain (max iterations is 1, a single pass), stop and report the commits still uncovered.

## Common Pitfalls

- Leaving `[Unreleased]` empty or only a placeholder, so users cannot see what this update contains.
- Splitting one change into multiple entries or duplicating it across categories.
- Logging internal refactors, dependency bumps, or code style changes that are not user-visible.
- Misclassifying changes (e.g. placing a breaking change under Changed rather than a more prominent spot).

## Notes

- Entries must be traceable to a specific commit for later verification.
- Do not invent features that are not yet implemented; verify the diff before writing an uncertain change.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

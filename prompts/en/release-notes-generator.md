---
name: "release-notes-generator"
description: "Generate and review complete, accurate release notes"
---

# Release Notes Generator

**Category:** Operations & Marketing
**Slug:** `release-notes-generator`
**Max Iterations:** 5

## Goal

Produce structured release notes from commit history, merged PRs, and tickets, covering new features, improvements, bug fixes, breaking changes, and known issues. Every user-visible change must be accurately categorized and written for end users, not for developers.

## When to Use

Before shipping any release (major, minor, or patch), to ensure the notes are customer-ready and safe to publish.

## Check Command

```bash
python scripts/release_notes_check.py
```

## Exit Condition

- Check script exits 0.
- Notes cover every merged commit since the previous release tag.
- Breaking changes are explicitly flagged and surfaced at the top.
- No placeholders or TBD items remain.

## Steps

Step 1: Run the check command and capture its output and missing-item list.
Step 2: Diff the commits/PRs/tickets since the last tag and identify three failure classes: missing changes, misclassified entries, and developer-facing wording. Pay special attention to breaking changes wrongly folded into "improvements."
Step 3: Make the smallest fix: add missing entries, fix categories, rewrite wording for users; never hide or merge genuine breaking changes.
Step 4: Re-run the check; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining blockers (e.g., missing ticket links, ambiguous classifications); never loop forever.

## Common Pitfalls

- Silently lumping breaking changes into "improvements" or "other," hiding upgrade risk from users.
- Copying commit titles (developer-facing) instead of translating them into user-facing language.
- Missing commits that were merged into the release branch but never tagged.
- Inventing features or fixes that do not exist in the material.

## Notes

- Write only from verifiable commits, PRs, and tickets; never fabricate features.
- Breaking changes must be surfaced at the top with migration guidance.
- When critical info is missing (e.g., ticket links), stop and report rather than guess.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

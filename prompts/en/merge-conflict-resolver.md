---
name: "merge-conflict-resolver"
description: "branch rebases onto main clean with passing tests"
---

# Merge Conflict Resolver

**Category:** Pull Request  
**Slug:** `merge-conflict-resolver`  
**Max Iterations:** 10

## Goal

Rebase the current branch onto the latest main, resolving every conflict one by one, and get the full test suite to pass. On completion the branch history is linear, free of leftover conflict markers, and semantically correct rather than merely textually stitched together.

## When to Use

Use when main has new commits and the current branch needs to sync. Prefer rebase to keep a linear history; when conflicts are many, resolve them in batches.

## Check Command

```bash
npm test
```

## Exit Condition

The rebase completes successfully (no unresolved conflicts, no leftover conflict markers <<<<<<< / ======= / >>>>>>>), and the check command exits 0.

## Steps

Step 1: Run git fetch then git rebase main; if conflicts arise, list the conflicted files with git status.
Step 2: Resolve one file at a time: read the intent of both sides and decide whether to keep ours, incoming, or a real merge of both; avoid blindly picking one side.
Step 3: Ensure semantic correctness when resolving: sync renamed symbols, adjust call sites, restore logic needed by both sides; delete all conflict markers.
Step 4: git add each resolved file; once all are resolved, run the check command; on failure, isolate the first failing case and fix it.
Step 5: If conflicts remain or tests still fail and under 10 iterations, return to Step 2; if the rebase cannot progress (e.g., a historical fork requiring human judgment), run git rebase --abort and stop, reporting the blocker to the user; do not loop forever.

## Common Pitfalls

- Blindly keeping one side: choosing ours or theirs mechanically and losing a critical change from the other side.
- Deleting conflict markers without resolving semantics: the text looks clean but it still fails at runtime.
- git add -A ingesting everything at once: mixing unresolved files into the commit and hiding problems.
- Not re-testing after resolving: assuming "no markers" means "done" and ignoring semantic regressions.

## Notes

- Prefer to understand both sides' intent before deciding; on an uncertain semantic conflict, abort (--abort) and ask rather than guess the merge.
- After resolving each file, verify it compiles/loads before moving to the next.
- Do not bundle unrelated refactors into the conflict-resolution work; keep changes traceable.
- If conflicts stem from large-scale renames/moves, trace the history with git log --follow before deciding.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

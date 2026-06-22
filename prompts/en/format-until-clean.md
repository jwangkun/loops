---
name: "format-until-clean"
description: "formatter runs with zero changes"
---

# Format Until Clean

**Category:** Code Quality  
**Slug:** `format-until-clean`  
**Max Iterations:** 3

## Goal
After the formatter runs, there are no pending changes (exit code 0 and an empty diff). Any issues the tool cannot auto-fix are resolved with minimal manual edits so that re-running stays idempotent. Success means the code fully conforms to the project's formatting standard.

## When to Use
Before committing or merging, or whenever the formatter reports files that need changes.

## Check Command

```bash
npm run format
```

## Exit Condition
- `npm run format` exits 0
- Re-running yields no file changes (idempotent, empty diff)

## Steps
Step 1: Run the formatter and capture the output; list the files it changed.
Step 2: Separate what the tool auto-fixed from what still errors or cannot parse; for unparseable cases, find the root cause (syntax error, conflicting config, file type not covered).
Step 3: Make minimal manual edits only for what the tool cannot fix (typically fixing syntax or correcting config); never hand-edit code that fights the formatter.
Step 4: Re-run the formatter; if it still changes files and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without a clean run, stop and report the remaining unparseable files and causes; do not loop forever.

## Common Pitfalls
- Fighting the formatter by hand-writing code it will then revert, causing infinite churn.
- The formatter silently skips a file due to a syntax error, leading you to think formatting passed.
- Multiple formatters (e.g. Prettier and ESLint formatting rules) with conflicting configs that overwrite each other.

## Notes
- Commit only formatting-related changes; avoid sneaking logic changes into a formatting pass.
- If you must change the formatter config, do it outside this loop and assess global impact.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

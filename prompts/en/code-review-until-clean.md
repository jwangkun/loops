---
name: "code-review-until-clean"
description: "Code passes structured review checklist"
---

# Code Review Until Clean

**Category:** Code Quality
**Slug:** `code-review-until-clean`
**Max Iterations:** 5

## Goal

Make the target code pass every item in `review_checklist.py`, producing mergeable code with no outstanding warnings. Each iteration's verdict must be based on real command output, not subjective impression.

## When to Use

Use before opening a PR or merging to trunk, as a structured quality gate over new/changed code.

## Check Command

```bash
python scripts/review_checklist.py
```

## Exit Condition

- The review command exits with code 0.
- No WARNING / ERROR / FAIL markers remain in the output.
- If max iterations are reached without success, stop and report remaining blockers.

## Steps

Step 1: Run `python scripts/review_checklist.py`, capturing stdout/stderr and the exit code in full.
Step 2: Parse each flagged issue, group by file/rule/line, and separate "must fix" from "style suggestions".
Step 3: Apply the smallest fix to each must-fix item; fix only the issue itself, do not rewrite unrelated code in passing.
Step 4: Re-run the check; if failures remain and you are under 5 iterations, go back to Step 2.
Step 5: If 5 iterations are reached without a clean result, stop, list the remaining failing items and their causes, and never loop further.

## Common Pitfalls

- Suppressing warnings with comments or `// eslint-disable` instead of fixing the root cause.
- Bundling many issues into one large change, making review output hard to attribute and roll back.
- Fixing only the first failure before re-running, ignoring other issues of the same kind and wasting iterations.

## Notes

- Each iteration targets only the real issues in the current output; do not invent or preemptively refactor.
- Keep changes focused on what the review checklist covers; do not expand scope.
- Fix over suppress; if an exemption is truly needed, document the reason.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

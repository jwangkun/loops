---
name: "design-review-loop"
description: "design meets guidelines and accessibility standards"
---

# Design Review Loop

**Category:** Product & Design  
**Slug:** `design-review-loop`  
**Max Iterations:** 8

## Goal
Make the design under review (mockup or component) pass every check in `design_check.py`, covering design token usage, spacing rules, and accessibility (WCAG). Success means the check command exits with zero failures.

## When to Use
After adding or modifying a UI component, redesigning a page, or importing third-party visual assets — run this loop before submission to confirm the design aligns with system guidelines.

## Check Command

```bash
python scripts/design_check.py
```

## Exit Condition
- The check command passes with exit code 0 and no warnings or errors.
- All checks for tokens, spacing, contrast, focus visibility, etc. are satisfied.

## Steps
Step 1: Run `python scripts/design_check.py`, capturing the full stdout/stderr and exit code.
Step 2: Analyze each failure, grouping by type (hardcoded colors, spacing drift, low contrast, missing alt/aria, missing focus), and locate the exact file and line.
Step 3: Make the smallest fix: prefer reusing existing design tokens and components over inventing new values; never mask a failure with a comment, an ignored rule, or a loosened threshold.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining blockers (file, failure reason, suggestion); never loop forever.

## Common Pitfalls
- Using hardcoded hex colors instead of design tokens, breaking theming and consistency checks.
- Using approximate spacing (e.g. 13px) rather than token multiples (4/8), triggering spacing-rule warnings.
- Judging contrast by eye instead of verifying WCAG AA (4.5:1 for body text).
- Adding alt text to decorative images, or omitting aria-label on functional icons, causing false positives or missed accessibility issues.

## Notes
- Fix only the failures the check command actually reports; do not opportunistically refactor unrelated styles.
- Distinguish a real violation from an intentional exception; exceptions must be documented explicitly, never silently ignored.
- Do not lower thresholds or temporarily disable rules just to make the check pass.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "weekly-review-loop"
description: "Generate a review reflecting the actual week"
---

# Weekly Review Loop

**Category:** Productivity
**Slug:** `weekly-review-loop`
**Max Iterations:** 3

## Goal

Produce a weekly review report that reflects the actual week: accomplishments, blockers, goal progress, and a concrete plan for next week, with the checker passing. Success means the report is grounded in real weekly data rather than a generic template, ready for retrospective and planning.

## When to Use

Use at the end of a week to review progress and plan the week ahead.

## Check Command

```bash
python scripts/weekly_review_check.py
```

## Exit Condition

- Report covers goal progress, this week's tasks, and next week's plan.
- Accomplishments and blockers are based on real records, not placeholders.
- Next week's plan has concrete items, not generic filler.

## Steps

Step 1: Run `python scripts/weekly_review_check.py` and capture missing sections (goals/tasks/next-week plan) or spots still holding placeholders or generic filler.
Step 2: Analyze the gaps — find sections that are placeholders without real data, places that list tasks without assessing progress against goals, and next-week plans lacking concrete items or owners.
Step 3: Make the smallest fix: fill content with real accomplishments/blockers, assess progress against goals, and write next week's plan as concrete actionable items. Never copy template filler to pass the check.
Step 4: Re-run the check; if gaps remain and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining blockers (e.g. the week's records are missing, so progress can't be assessed). Never loop forever.

## Common Pitfalls

- Filling a generic template with placeholders that don't reflect the actual week.
- Listing completed tasks without assessing real progress against goals.
- A vague next-week plan (e.g. "keep pushing") with no concrete items or dates.
- Downplaying or glossing over the week's blockers and unfinished items.

## Notes

- Content must be based on real weekly records; never invent accomplishments or hide blockers.
- Quantify goal progress (percent complete / milestones) to enable week-over-week comparison.
- Next-week items should be actionable and verifiable, and connect to this week's leftover blockers.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

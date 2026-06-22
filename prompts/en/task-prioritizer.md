---
name: "task-prioritizer"
description: "Rank tasks by impact and effort"
---

# Task Prioritizer

**Category:** Productivity
**Slug:** `task-prioritizer`
**Max Iterations:** 20

## Goal

Give every task in the backlog an impact score, an effort estimate, and a derived priority so the top of the list is unambiguous, with the checker passing. Success means anyone reading the list can immediately tell what to do next.

## When to Use

Use when a task list/backlog needs ranking, before planning a sprint or a day.

## Check Command

```bash
python scripts/task_check.py
```

## Exit Condition

- All tasks have an impact score, an effort estimate, and a priority.
- The list is ordered by priority with an unambiguous top item (no ties).
- Each score is traceable to a basis (linked goal / breakdown rationale).

## Steps

Step 1: Run `python scripts/task_check.py` and capture the list of tasks missing a score, an estimate, or a decided priority.
Step 2: Take one unresolved task and analyze its impact (which goal, how much) and effort (based on a breakdown, not a gut guess), and check whether a priority tie needs breaking.
Step 3: Make the smallest fix: fill in impact and effort, compute priority, and reorder to break ties if needed. Never dodge trade-offs by giving every task the same score.
Step 4: Re-run the check; if unresolved tasks remain and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining blockers (e.g. tasks lack enough info to estimate). Never loop forever.

## Common Pitfalls

- Estimating effort by gut without any breakdown, producing unreliable numbers.
- Scoring impact detached from concrete goals, reducing it to subjective guesswork.
- Leaving priority ties unbroken, so the top item stays ambiguous.
- Reordering without recomputing scores, so order contradicts the numbers.

## Notes

- Scores must be based on the task's objective information; never inflate/deflate to pass the check.
- Effort estimates should state the unit (hours/person-days) and assumptions.
- For high-impact, high-effort tasks, consider splitting before ranking.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

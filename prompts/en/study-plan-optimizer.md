---
name: "study-plan-optimizer"
description: "Optimize the study plan to be realistic and topic-complete"
---

# Study Plan Optimizer

**Category:** Learning & Knowledge
**Slug:** `study-plan-optimizer`
**Max Iterations:** 5

## Goal

Make the study plan realistic within the given time budget while fully covering every target topic. Daily and weekly workloads match actual available time, difficulty ramps sensibly, and slack is reserved for review and buffer.

## When to Use

When an existing study plan is overloaded, missing topics, or poorly time-allocated.

## Check Command

```bash
python scripts/study_plan_check.py
```

## Exit Condition

- Check script exits 0.
- The plan covers all required topics.
- Total estimated time does not exceed the available budget.
- Daily load is balanced, with no empty or overloaded days.

## Steps

Step 1: Run the check command and capture the list of coverage gaps, overloads, and imbalances.
Step 2: Find root causes: which topics are unscheduled, which days exceed available time, which topic dependencies are out of order, whether review/buffer is missing.
Step 3: Make the smallest adjustment: move overloaded tasks to days with slack, fill in missing topics, keep review and buffer; do not reshuffle parts that are already sound.
Step 4: Re-run the check; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining blockers (e.g., total budget too small, conflicting topics); never loop forever.

## Common Pitfalls

- Overestimating daily available hours so the plan is doomed to fail.
- Stuffing in topics while skipping review and rest buffer.
- Ignoring topic dependencies (practicing advanced material before the foundations).
- Scheduling down to the minute, leaving no room for the unexpected.

## Notes

- Use the provided real available-time budget; never fabricate study hours.
- Always reserve buffer for review and surprises; never fill the schedule to 100%.
- Topic order must respect dependencies.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "quiz-validator"
description: "Verify quiz questions are clear with one correct answer"
---

# Quiz Validator

**Category:** Learning & Knowledge
**Slug:** `quiz-validator`
**Max Iterations:** 10

## Goal

Ensure every quiz question has an unambiguous stem, exactly one correct answer, and plausible distractors, with the checker passing at zero violations. Success means the question set is publishable with no manual rework needed.

## When to Use

Use after generating or importing a quiz/question bank and before publishing, to guarantee quality before it reaches learners.

## Check Command

```bash
python scripts/quiz_check.py
```

## Exit Condition

- All quiz items pass validation with exit code 0.
- Each question has a single correct answer and reasonable distractors.
- No ambiguous stems, duplicate options, or logical contradictions.

## Steps

Step 1: Run `python scripts/quiz_check.py` and capture the full output plus the list of failing items.
Step 2: Analyze each failure — focus on ambiguous stems (multiple defensible answers), distractors that are obviously wrong or near-identical to the answer, missing rationales, and "all/none of the above" crutch options.
Step 3: Make the smallest fix: rewrite ambiguous stems, replace weak distractors, complete the answer and rationale. Never weaken validation or leave a TODO to paper over a failure.
Step 4: Re-run the check; if still failing and under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining blockers (e.g. fundamentally flawed items). Never loop forever.

## Common Pitfalls

- Stems with multiple defensible answers, so the "correct" one is not unique.
- Overuse of "all of the above" / "none of the above" as filler options.
- Correct answer always in the same position (e.g. always B/C), making it guessable.
- Distractors either obviously wrong or nearly identical to the answer, removing discriminating power.

## Notes

- Do not lower question difficulty or delete valuable items just to make the script pass.
- Preserve the knowledge point each item tests; change only wording and option quality.
- Rationales should explain why the answer is right and why others are wrong.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

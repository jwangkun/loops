---
name: "translation-review-loop"
description: "translation is accurate, natural, locale-aware"
---

# Translation Review Loop

**Category:** Content Creation
**Slug:** `translation-review-loop`
**Max Iterations:** 10

## Goal

Bring the translation to a fully passing state on `translation_check.py` across accuracy, fluency, and fit for the target locale. Each draft makes only the minimal edits reported by the check — fixing mistranslations, removing machine-translation tone, aligning terminology and voice — rather than retranslating wholesale. Success means the check is clean and the meaning matches the source.

## When to Use

During localization or cross-language delivery (UI strings, docs, marketing content), especially when a target locale, regional convention, or brand glossary applies.

## Check Command

```bash
python scripts/translation_check.py
```

## Exit Condition

- `translation_check.py` exits 0 with no open issues.
- No mistranslations, omissions, or over-adaptations.
- Terminology and voice match the target locale's conventions.

## Steps

Step 1: Run the check and capture the full output (per-segment mistranslations, awkward phrasing, term inconsistencies, length overruns).
Step 2: Analyze each failure: separate literal translation losing idiom, regional-wording errors, terminology drift, and UI/layout length overruns; localize to the specific segment and cause.
Step 3: Rewrite that segment minimally, following the glossary and target-locale conventions; never mask or skip the issue.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report remaining blockers (segment, issue type, source vs. target text); do not loop forever.

## Common Pitfalls

- Word-for-word translation that loses idiom, pun, or tone, making output stilted or misleading.
- Aligning language (e.g. "Spanish") but ignoring locale (Castilian vs. Latin American), so conventions don't fit.
- Inconsistent terminology, or coining translations that depart from the agreed glossary.
- Length overruns breaking UI containers yet still marked as passing.

## Notes

- Locale and glossary are provided by the requester; confirm first if missing, do not assume.
- Preserve the source's facts, numbers, and brand voice; never fabricate or "localize" data.
- For high-risk content (legal/medical/compliance), keep changes traceable.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

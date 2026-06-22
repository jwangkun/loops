---
name: "ad-copy-optimizer"
description: "ad copy variants pass conversion checklist"
---

# Ad Copy Optimizer

**Category:** Content Creation
**Slug:** `ad-copy-optimizer`
**Max Iterations:** 10

## Goal

Bring every copy variant to a fully passing state on `ad_copy_check.py` across appeal, value proposition, credibility, and conversion guidance. Each pass makes only the minimal edits to variants that fail — sharpening the CTA, removing over-claims, focusing a single benefit — rather than rewriting all variants wholesale. Success means all variants pass.

## When to Use

When producing or iterating ad copy variants (headline, body, CTA), especially for A/B testing or under brand and compliance guidelines.

## Check Command

```bash
python scripts/ad_copy_check.py
```

## Exit Condition

- `ad_copy_check.py` exits 0 with all variants passing.
- Every variant has an explicit CTA and a single core benefit.
- No over-claims or unverifiable statements remain.

## Steps

Step 1: Run the check and capture the full output (per-variant missing CTA, vague benefit, over-claim, length breach, brand mismatch).
Step 2: Analyze each failure: separate missing CTA, unclear value proposition, over-claiming, character/length limit breaches, and tone-vs-brand mismatch; localize to the specific variant and cause.
Step 3: Improve that variant minimally — add a clear CTA, focus one benefit, remove over-claims — rather than rewriting all variants.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report remaining blockers (variant, issue type); do not loop forever.

## Common Pitfalls

- Variants lacking an explicit CTA, leaving the user unsure of the next step.
- Stacking multiple benefits dilutes focus and lowers conversion.
- Over-claims or unsupported promises that trigger compliance risk and hurt credibility.
- Ignoring platform character/format limits, so copy gets truncated at delivery.

## Notes

- Use only facts and benefits provided by the requester; never fabricate data or fake offers.
- Compliance and brand voice must be explicit; confirm first if missing, do not assume.
- Preserve genuine differences between variants to support later A/B testing.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

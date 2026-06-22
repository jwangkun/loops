---
name: "video-script-loop"
description: "video script meets target duration and clarity"
---

# Video Script Loop

**Category:** Content Creation
**Slug:** `video-script-loop`
**Max Iterations:** 8

## Goal

Bring the video script to a shootable state within the target duration, with an effective opening hook, clear narration, and tight pacing. Each draft is validated by `script_review.py`, and every fix is a minimal, targeted edit that addresses a reported defect rather than a broad rewrite. Success means the check passes and the duration lands inside target.

## When to Use

When writing or revising a video script (voiceover, tutorial, short explainer), especially when a target duration or retention/completion metric applies.

## Check Command

```bash
python scripts/script_review.py
```

## Exit Condition

- `script_review.py` exits 0 with no open issues.
- Total script duration falls inside the target window.
- Hook, structure, and pacing checks all pass.

## Steps

Step 1: Run the check and capture the full output (duration drift, hook strength, clarity issues listed per segment).
Step 2: Analyze each failure: separate duration overrun, weak hook, low information density, and logic gaps; localize to the specific segment and cause.
Step 3: Fix that segment with the smallest change — trim redundancy, rewrite a weak hook, add a missing transition — not a full rewrite.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report remaining blockers (segment, issue type, duration delta); do not loop forever.

## Common Pitfalls

- Cutting words mechanically to hit duration, sacrificing necessary information or logical continuity.
- Leaving the opening hook as a factual statement, with no curiosity or tension in the first 5 seconds.
- Estimating duration by word count rather than real spoken pace, causing severe overrun on actual recording.
- Fixating on one weak segment while ignoring the overall pacing curve (setup, peak, payoff).

## Notes

- Preserve given facts, brand voice, and spoken style; never fabricate data.
- The target duration must be stated by the requester; confirm first if missing, do not assume.
- Keep the script shootable — avoid long written-form sentences.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

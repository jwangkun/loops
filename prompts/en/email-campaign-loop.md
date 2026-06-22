---
name: "email-campaign-loop"
description: "email campaign passes review and links are valid"
---

# Email Campaign Loop

**Category:** Operations & Marketing  
**Slug:** `email-campaign-loop`  
**Max Iterations:** 5

## Goal
Make the email campaign pass every check in `email_check.py`, covering subject line, body content, link validity, images, and compliance. Success means the check command exits with zero failures and the campaign is safe to send.

## When to Use
Before launching a new or modified email template, an A/B test variant, or any promotional/lifecycle email — run this loop to confirm the content, link, and compliance baseline is met.

## Check Command

```bash
python scripts/email_check.py
```

## Exit Condition
- The check command passes with exit code 0 and no errors.
- Subject line, body, all links (including unsubscribe), and images with alt text are valid and reachable, and compliance items (unsubscribe, sender info) are present.

## Steps
Step 1: Run `python scripts/email_check.py`, capturing the full output and exit code, recording the failing module (subject/body/links/images/compliance) for each failure.
Step 2: Analyze and classify failures: subject too long or triggering spam words, broken or expired links, images missing alt or oversized, missing unsubscribe/sender info, single-huge-image body; locate the exact template fragment.
Step 3: Make the smallest fix: correct a single field or link, add alt text and control image size, ensure the unsubscribe link exists and is reachable; never remove the unsubscribe or replace text body with an image just to pass the check.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining failures (module, reason, suggestion); never loop forever.

## Common Pitfalls
- Building the whole body as one huge image, leaving the email blank when images are blocked and hurting deliverability.
- Images missing alt text, so recipients see nothing when images are suppressed.
- Subject lines in all caps or using spam trigger words (e.g. "FREE", "LIMITED"), sharply lowering deliverability.
- Missing or buried unsubscribe links, breaching compliance and raising complaint rates.
- Verifying links only in a desktop browser, ignoring click-tracking distortion from email client prefetching.

## Notes
- Never remove or weaken the unsubscribe mechanism or sender identity information to pass the check.
- Link fixes must point to a real, reachable target; do not paper over a dead link with a placeholder or 301 redirect.
- Keep content consistent with the landing page; avoid subject/body promises that mismatch the destination.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

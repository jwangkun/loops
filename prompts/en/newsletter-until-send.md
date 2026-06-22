---
name: "newsletter-until-send"
description: "newsletter passes review and links are valid"
---

# Newsletter Until Send

**Category:** Content Creation
**Slug:** `newsletter-until-send`
**Max Iterations:** 5

## Goal

Get the newsletter through content review with all links valid before sending—no typos, no dead links, no factual errors, and a plain-text fallback in place. Success means the check command exits cleanly.

## When to Use

Use for final quality control right before a newsletter ships; covers link validation, content review, and format fallback.

## Check Command

```bash
python scripts/newsletter_check.py
```

## Exit Condition

- The check command completes with exit code 0 and no errors.
- All links are reachable (no 404/timeout/redirect to a wrong page).
- Content is reviewed: no typos, no factual errors, no unattributed quotes; a plain-text fallback has been generated.

## Steps

Step 1: Run the check command, capturing the dead-link list and each content/format warning.
Step 2: Analyze the issues—distinguish dead links (removed/changed address), redirect anomalies, typos, factual doubts, and missing plain-text fallback.
Step 3: Make the smallest fix: update or remove dead links, correct typos, verify suspect facts, add the plain-text fallback; never bypass validation by commenting out or hiding links.
Step 4: Re-run the check command; if errors remain and you're under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining dead links and items still needing review; never loop forever.

## Common Pitfalls

- Skipping the plain-text fallback, so links are lost or layout breaks in plain-text clients.
- Using short links/redirects to mask a destination that's actually dead—passing the check but failing after send.
- Validating only visible links in the HTML and missing buttons, image alt links, and the unsubscribe link.
- Editing the body without re-checking, introducing new dead links or typos.

## Notes

- A human must give final confirmation of recipients, subject, and send time before sending.
- Never fabricate data or quotes; attribute uncertain facts to a source or remove them.
- Re-run the full check after each edit to avoid introducing new issues.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "inbox-zero-loop"
description: "Process inbox actionable emails down to zero"
---

# Inbox Zero Loop

**Category:** Productivity
**Slug:** `inbox-zero-loop`
**Max Iterations:** 50

## Goal

Triage every unread actionable email in the inbox to zero: each is replied to, archived, delegated, or scheduled as a to-do, with nothing left in an "undecided" state. Success means no actionable items are piling up in the inbox.

## When to Use

Use during a dedicated email-processing session where the goal is true inbox zero, not merely "fewer unread."

## Check Command

```bash
python scripts/inbox_check.py
```

## Exit Condition

- Inbox actionable email count is zero with exit code 0.
- Every email has a clear disposition (reply/archive/delegate/schedule).
- No "read but undecided" emails remain.

## Steps

Step 1: Run `python scripts/inbox_check.py` and capture the remaining count and list of actionable emails.
Step 2: Take one unprocessed email and decide the disposition: needs a reply, can be archived (no action), should be delegated, or must be scheduled as a to-do with a due date.
Step 3: Execute the smallest disposition: send the reply, archive, forward to delegate, or create a to-do with a due date, then move it out of the inbox. Never bulk-archive to hide undecided items.
Step 4: Re-run the check; if actionable emails remain and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without hitting zero, stop and report the remaining blockers (e.g. emails awaiting someone else's input). Never loop forever.

## Common Pitfalls

- Archiving without deciding, which hides work rather than achieving real zero.
- Defaulting to replying to everything instead of delegating or scheduling.
- Getting stuck reading long threads verbatim instead of deciding a disposition.
- Treating "read" as "handled," leaving undecided emails behind.

## Notes

- "Zero" means zero actionable items, not zero unread (pure notifications/newsletters can be bulk-archived).
- Delegated or scheduled to-dos must have a clear owner and due date.
- Handle sensitive or confidential content according to the relevant compliance rules.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

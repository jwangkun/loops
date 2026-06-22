---
name: "meeting-notes-cleaner"
description: "Structure meeting notes and extract action items"
---

# Meeting Notes Cleaner

**Category:** Productivity
**Slug:** `meeting-notes-cleaner`
**Max Iterations:** 3

## Goal

Transform raw meeting notes or transcripts into a structured document with a concise summary, an explicit list of decisions, and action items each carrying an owner and a due date, with the checker passing. Success means the notes are ready to share with attendees for execution.

## When to Use

Use right after a meeting when you have rough notes or a verbatim transcript that must become shareable, trackable minutes.

## Check Command

```bash
python scripts/meeting_check.py
```

## Exit Condition

- Notes contain summary, decisions, and action items sections.
- Every action item has a clear owner and a due date.
- Decisions are explicitly extracted from discussion, not buried in prose.

## Steps

Step 1: Run `python scripts/meeting_check.py` and capture what is missing (no summary/decisions/action items, or action items lacking owner or due date).
Step 2: Analyze the gaps — locate decisions buried in discussion, to-dos without owners, overly long or verbatim summaries, and places where discussion is conflated with decisions.
Step 3: Make the smallest fix: write a concise summary, extract decisions into a list, and give every action item an owner and due date. Do not trim content just to pass the check.
Step 4: Re-run the check; if still incomplete and under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining blockers (e.g. the source notes lack enough info to assign owners). Never loop forever.

## Common Pitfalls

- Action items without an owner or due date, so nothing gets followed up.
- Decisions buried in narrative discussion rather than explicitly extracted.
- Summaries that are too long or near-verbatim, defeating the purpose of a summary.
- Confusing "we discussed X" with "we decided X".

## Notes

- Owners and due dates must come from actual meeting information; never invent them.
- Keep the raw record as an attachment; share the structured version.
- Refine vague to-dos (e.g. "follow up") into concrete, executable actions.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

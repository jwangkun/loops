---
name: "note-organizer"
description: "Tag, link, and structure notes for easy retrieval"
---

# Note Organizer

**Category:** Learning & Knowledge
**Slug:** `note-organizer`
**Max Iterations:** 20

## Goal

Give every note consistent tags, bidirectional links, and a clear heading structure so it is easy to retrieve and connect. The tag scheme stays consistent, links point to notes that actually exist, and hierarchy matches the original intent.

## When to Use

When a notebook is messy, untagged, or unlinked, and cross-note connections are hard to establish.

## Check Command

```bash
python scripts/note_check.py
```

## Exit Condition

- Check script exits 0.
- All notes are tagged and linked.
- No broken links, no duplicate synonymous tags.
- Every non-orphan note has at least one connection.

## Steps

Step 1: Run the check command and capture the list of broken links, untagged notes, and orphans.
Step 2: Classify problems: heading references to nonexistent targets, one-directional links missing their backlink, synonymous duplicate tags, notes that should be connected but sit orphaned.
Step 3: Make the smallest fix: add tags following the existing naming convention, complete bidirectional links, merge synonymous tags, and repair links broken by renames; never create empty placeholder notes just to satisfy a link.
Step 4: Re-run the check; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining blockers (e.g., circular references, naming conflicts); never loop forever.

## Common Pitfalls

- Over-tagging, creating many synonymous tags that each appear only once.
- Building a link in only one direction, breaking the connection.
- Renaming a heading without updating the links that reference it.
- Forcing structure onto notes that are meant to be free-form logs.

## Notes

- Tags must follow the existing naming convention; do not invent near-synonyms.
- Link targets must really exist; never create empty placeholder notes.
- Preserve the original meaning; do not rewrite notes until they distort.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

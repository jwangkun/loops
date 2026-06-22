---
name: "flashcard-generator"
description: "Generate memorable Q&A flashcards for key concepts"
---

# Flashcard Generator

**Category:** Learning & Knowledge
**Slug:** `flashcard-generator`
**Max Iterations:** 20

## Goal

Generate concise, self-testable Q&A flashcards for every key concept in the source material. Each card has a clear question and a self-contained answer, tests a single atomic concept, and demands active recall rather than passive recognition.

## When to Use

When you need to turn a document, lecture notes, or notebook into a spaced-repetition flashcard set.

## Check Command

```bash
python scripts/flashcard_check.py
```

## Exit Condition

- Check script exits 0.
- Every extracted concept has at least one card.
- No duplicate cards, no empty answers, no placeholders.

## Steps

Step 1: Run the check command and capture the list of missing concepts and quality warnings.
Step 2: Analyze gaps item by item: which concepts have no card, which cards are yes/no only, which pack multiple concepts, which questions already reveal the answer.
Step 3: Make the smallest fix: add one atomic Q&A card for each missing concept and rewrite trivial or leading questions; do not delete valid cards or pile on redundancy.
Step 4: Re-run the check; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are reached without success, stop and report remaining uncovered concepts or quality issues; never loop forever.

## Common Pitfalls

- Making yes/no trivia that fails to trigger active recall.
- Cramming multiple concepts into one card so the answer is ambiguous.
- Leading questions that give away the answer.
- Pasting long source passages instead of compressing them into atomic facts.

## Notes

- Cards must be grounded in the source material; never invent facts not present.
- Each card tests exactly one atomic concept.
- Answers must trace back to a source location for verification.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

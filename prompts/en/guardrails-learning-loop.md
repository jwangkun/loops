---
name: "guardrails-learning-loop"
description: "tests and lint pass without repeating previous failure patterns"
---

# Guardrails Learning Loop

**Category:** Git Hooks  
**Slug:** `guardrails-learning-loop`  
**Max Iterations:** 5

## Goal

tests and lint pass without repeating previous failure patterns

## Check Command

```bash
npm test && npm run lint
```

## Exit Condition

checks pass without repeat failures

## Steps

Step 1: Read guardrails.md. Run checks. If failing repeatedly, log then fix.

## Recommended Agents

Claude Code, Cursor, Trae

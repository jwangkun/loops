---
name: "generate-unit-tests"
description: "target function has passing unit tests for edge cases"
---

# Generate Unit Tests

**Category:** Code Generation  
**Slug:** `generate-unit-tests`  
**Max Iterations:** 5

## Goal

target function has passing unit tests for edge cases

## Check Command

```bash
npm test -- <target-file>
```

## Exit Condition

new tests pass and cover edge cases

## Steps

Step 1: Analyze function. Generate tests for normal, edge, and error cases. Run. Fix.

## Recommended Agents

Claude Code, Cursor, Trae

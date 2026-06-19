---
name: "reflexion-debug-loop"
description: "failing test or repro passes"
---

# Reflexion Debug Loop

**Category:** Development Process  
**Slug:** `reflexion-debug-loop`  
**Max Iterations:** 10

## Goal

failing test or repro passes

## Check Command

```bash
npm test -- --testNamePattern=<test>
```

## Exit Condition

test or repro passes

## Steps

Step 1: Reproduce bug. If failing, record in reflexion file, then try new fix.

## Recommended Agents

Claude Code, Cursor, Trae

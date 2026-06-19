---
name: "flaky-test-triage"
description: "classify failing tests as flaky or real"
---

# Flaky Test Triage

**Category:** Testing  
**Slug:** `flaky-test-triage`  
**Max Iterations:** 8

## Goal

classify failing tests as flaky or real

## Check Command

```bash
npm test -- --testPathPattern=<failing-suite>
```

## Exit Condition

each failure is classified

## Steps

Step 1: Rerun failing test suite multiple times. Classify each failure. Fix real issues.

## Recommended Agents

Claude Code, Cursor, Trae

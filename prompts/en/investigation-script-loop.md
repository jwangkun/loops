---
name: "investigation-script-loop"
description: "prove root cause with minimal repro script"
---

# Investigation Script Loop

**Category:** Development Process  
**Slug:** `investigation-script-loop`  
**Max Iterations:** 10

## Goal

prove root cause with minimal repro script

## Check Command

```bash
node scripts/investigate.mjs
```

## Exit Condition

root cause reproduced

## Steps

Step 1: Write a small temporary script to reproduce the issue. Run it. Iterate output.

## Recommended Agents

Claude Code, Cursor, Trae

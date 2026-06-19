---
name: "query-performance-loop"
description: "slow queries optimized below threshold"
---

# Query Performance Loop

**Category:** Database  
**Slug:** `query-performance-loop`  
**Max Iterations:** 8

## Goal

slow queries optimized below threshold

## Check Command

```bash
npm run benchmark:queries
```

## Exit Condition

all queries below threshold

## Steps

Step 1: Identify slowest query. Add index or rewrite. Benchmark. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

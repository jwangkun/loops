---
name: "query-performance-loop"
description: "slow queries optimized below threshold"
---

# Query Performance Loop

**Category:** Database
**Slug:** `query-performance-loop`
**Max Iterations:** 8

## Goal

Optimize every query that exceeds the threshold in `benchmark:queries` below the threshold, without introducing new performance or correctness regressions. Success means the full benchmark passes and the slowest queries' execution time, rows scanned, and I/O are all within acceptable range.

## When to Use

Use after adding a query or changing schema, when a benchmark regresses, or to guard a query-latency budget before release.

## Check Command

```bash
npm run benchmark:queries
```

## Exit Condition

- `benchmark:queries` reports all queries below their thresholds (exit 0).
- No query triggers a full-table scan or N+1 pattern.
- Optimizations are verified against the execution plan, not guesswork.

## Steps

Step 1: Run `npm run benchmark:queries`; capture over-threshold queries, timings, call frequency, and code locations.
Step 2: For each slow query obtain and read the execution plan (`EXPLAIN`): confirm missing index, implicit type conversion, N+1, or wrong index choice.
Step 3: Apply the smallest correct fix: a targeted index, query rewrite (avoid `SELECT *`, limit returned rows, eliminate subqueries), or fix the ORM's eager-loading strategy; index naming and migration must follow conventions.
Step 4: Re-run `npm run benchmark:queries`; if still over threshold and under max iterations, go to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining slow queries with execution-plan evidence and recommendations; never loop forever.

## Common Pitfalls

- Adding indexes blindly without reading the plan, causing redundant indexes, slower writes, and no gain.
- Adding an index but missing the migration script, so production diverges from local.
- Changing result-set semantics while optimizing (e.g. wrong `JOIN` type or filter), introducing correctness regressions.
- Focusing only on single-run time, ignoring cumulative load from high-frequency calls.

## Notes

- All index changes must land via a reviewed migration script, never manual DB edits.
- Verify the benchmark data volume is representative before optimizing, to avoid wrong conclusions on tiny datasets.
- Never disable safety mechanisms (parameterization, permission filters) to pass the benchmark.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

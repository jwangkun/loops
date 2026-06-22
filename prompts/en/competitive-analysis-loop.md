---
name: "competitive-analysis-loop"
description: "competitor report is complete with credible sources"
---

# Competitive Analysis Loop

**Category:** Operations & Marketing  
**Slug:** `competitive-analysis-loop`  
**Max Iterations:** 10

## Goal
Produce a structurally complete competitive analysis report in which every conclusion is traceable, passing all checks in `competitor_check.py`. Success means the report contains all required sections and every data point carries an accessible original source link plus a collection date.

## When to Use
Use this loop when entering a new market, planning a product roadmap, adjusting pricing, or shaping marketing strategy and you need a credible, citable competitive baseline.

## Check Command

```bash
python scripts/competitor_check.py
```

## Exit Condition
- The check command passes with exit code 0.
- All required sections are present (overview, positioning, feature comparison, pricing, strengths/weaknesses, conclusion).
- Every data point has a valid source link, and that source is still accessible within its collection date.

## Steps
Step 1: Run `python scripts/competitor_check.py`, capturing the full output and exit code.
Step 2: Analyze failures, separating them into three gap types: missing sections, missing/broken sources, and stale data; locate the corresponding spot in the report for each gap.
Step 3: Make the smallest addition: fill in the missing section, and add an accessible original source link with collection date to any unsourced conclusion; never fabricate data or pass a secondhand restatement off as a primary source.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining gaps (sections, sources, stale data); never loop forever.

## Common Pitfalls
- Using stale data (last quarter's pricing, discontinued features) without checking the collection date.
- Confusing correlation with strategy (e.g. "competitor X raised prices, so should we") without causal backing.
- Citing secondhand aggregators instead of original sources, leaving claims unverifiable or distorted by the aggregator.
- Focusing only on top competitors and overlooking niche entrants or substitutes.

## Notes
- Every conclusion must be traceable; unverifiable opinions should be labeled as inferences, not facts.
- Annotate each source with its collection date and re-check link accessibility during iteration.
- Stay objective; avoid cherry-picking data to support a predetermined conclusion.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

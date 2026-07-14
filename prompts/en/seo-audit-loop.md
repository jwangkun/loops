---
name: "seo-audit-loop"
description: "page passes the SEO checklist"
---

# SEO Audit Loop

**Category:** Operations & Marketing  
**Slug:** `seo-audit-loop`  
**Max Iterations:** 10

## Goal
Make the target page pass every check in `seo_check.py`, covering meta tags, heading hierarchy, links, structured data, and page performance. Success means the check command exits with zero failures and the page satisfies indexability and baseline ranking factors.

## When to Use
Before launching a new page, after a template redesign, a major content change, or when indexing/ranking drops unexpectedly — run this loop to confirm the technical SEO baseline is met.

## Check Command

```bash
python scripts/seo_check.py
```

## Exit Condition
- The check command passes with exit code 0 and no errors.
- meta, canonical, heading hierarchy, link validity, structured data, and the Core Web Vitals baseline all pass.

## Steps
Step 1: Run `python scripts/seo_check.py`, capturing the full output and exit code, and record the page and field for each failure.
Step 2: Analyze failures by impact (missing/duplicate title and description, wrong canonical, broken links, skipped heading levels, missing structured data, failing Core Web Vitals), and locate the exact page and markup.
Step 3: Make the smallest fix: complete or correct a single field; tackle high-impact items affecting indexability and crawl first, and avoid masking problems with gimmicks like keyword stuffing.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining failures (page, field, reason, suggestion); never loop forever.

## Common Pitfalls
- Keyword stuffing title/description, triggering stuffing detection and lowering click-through rate.
- Ignoring Core Web Vitals (LCP/CLS/INP), only tweaking copy without solving the performance bottleneck.
- Skipping heading levels (e.g. h1 straight to h3), breaking content structure semantics.
- Omitting canonical or pointing it at the wrong URL, causing duplicate content and split indexing.
- Auditing only the homepage and overlooking pagination, filter pages, and noindex pages.

## Notes
- Fix only the failures the check command reports; do not opportunistically rewrite large swaths of content.
- Changes to noindex and canonical must match real intent; never mis-block a page just to silence a warning.
- Solve performance issues at the root (asset size, render-blocking) rather than masking them with parameter tweaks.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

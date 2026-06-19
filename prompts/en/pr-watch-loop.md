---
name: "pr-watch-loop"
description: "codex-watch PRs stay healthy and unblocked"
---

# PR Watch Loop

**Category:** CI/CD  
**Slug:** `pr-watch-loop`  
**Max Iterations:** 10

## Goal

codex-watch PRs stay healthy and unblocked

## Check Command

```bash
gh pr list --label codex-watch ...
```

## Exit Condition

no blocking issues

## Steps

Step 1: List codex-watch PRs. Check CI and reviews. Report or fix simple blockers.

## Recommended Agents

Claude Code, Cursor, Trae

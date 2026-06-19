---
name: "pr-babysitter"
description: "PRs labeled codex-watch stay healthy"
---

# PR Babysitter

**Category:** CI/CD  
**Slug:** `pr-babysitter`  
**Max Iterations:** 10

## Goal

PRs labeled codex-watch stay healthy

## Check Command

```bash
gh pr list --label "codex-watch"
```

## Exit Condition

no blocking CI failures

## Steps

Step 1: List watched PRs. Fix CI. Rebase stale PRs. Comment on stale items.

## Recommended Agents

Claude Code, Cursor, Trae

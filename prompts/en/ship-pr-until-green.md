---
name: "ship-pr-until-green"
description: "PR is open with all CI checks passing"
---

# Ship PR Until Green

**Category:** CI/CD  
**Slug:** `ship-pr-until-green`  
**Max Iterations:** 15

## Goal

PR is open with all CI checks passing

## Check Command

```bash
gh pr checks
```

## Exit Condition

all CI checks pass

## Steps

Step 1: Implement changes. Test locally. Push. Open PR. Fix CI until all checks pass.

## Recommended Agents

Claude Code, Cursor, Trae

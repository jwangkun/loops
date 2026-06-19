---
name: "security-audit-weekly"
description: "deliver weekly npm audit summary and fix plan"
---

# Security Audit Weekly

**Category:** Security  
**Slug:** `security-audit-weekly`  
**Max Iterations:** 1

## Goal

deliver weekly npm audit summary and fix plan

## Check Command

```bash
npm audit --json
```

## Exit Condition

audit summary delivered

## Steps

Step 1: Run npm audit. Categorize by severity. Suggest fix steps.

## Recommended Agents

Claude Code, Cursor, Trae

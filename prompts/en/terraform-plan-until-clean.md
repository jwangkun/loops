---
name: "terraform-plan-until-clean"
description: "terraform plan has no unexpected changes"
---

# Terraform Plan Until Clean

**Category:** System & DevOps  
**Slug:** `terraform-plan-until-clean`  
**Max Iterations:** 8

## Goal

terraform plan has no unexpected changes

## Check Command

```bash
terraform plan -detailed-exitcode
```

## Exit Condition

plan is clean or expected

## Steps

Step 1: Run terraform plan. Review unexpected changes. Fix. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

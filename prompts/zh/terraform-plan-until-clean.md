---
name: "terraform-plan-until-clean"
description: "terraform plan无意外变更"
---

# Terraform Plan直到干净

**分类:** 系统与DevOps  
**标识符:** `terraform-plan-until-clean`  
**最大迭代次数:** 8

## 目标

terraform plan无意外变更

## 检查命令

```bash
terraform plan -detailed-exitcode
```

## 退出条件

plan干净或符合预期

## 执行步骤

Step 1: 运行terraform plan。审查意外变更。修复。重复。

## 推荐代理

Claude Code、Cursor、Trae

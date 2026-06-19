---
name: "access-review-loop"
description: "所有用户访问权限都有正当理由"
---

# 访问权限审查循环

**分类:** 安全与合规  
**标识符:** `access-review-loop`  
**最大迭代次数:** 20

## 目标

所有用户访问权限都有正当理由

## 检查命令

```bash
python scripts/access_review.py
```

## 退出条件

所有权限已审查并记录

## 执行步骤

Step 1: 审查一个用户/角色。验证理由。删除或记录。

## 推荐代理

Claude Code、Cursor、Trae

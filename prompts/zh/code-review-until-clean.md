---
name: "code-review-until-clean"
description: "代码通过结构化审查清单"
---

# 代码审查直到干净

**分类:** 代码生成与重构  
**标识符:** `code-review-until-clean`  
**最大迭代次数:** 5

## 目标

代码通过结构化审查清单

## 检查命令

```bash
python scripts/review_checklist.py
```

## 退出条件

所有审查检查通过

## 执行步骤

Step 1: 运行审查清单。修复每个标记的问题。重复直到干净。

## 推荐代理

Claude Code、Cursor、Trae

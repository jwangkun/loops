---
name: "lint-typecheck-fix"
description: "lint和typecheck干净"
---

# Lint和Typecheck修复

**分类:** 代码质量  
**标识符:** `lint-typecheck-fix`  
**最大迭代次数:** 5

## 目标

lint和typecheck干净

## 检查命令

```bash
npm run lint && npx tsc --noEmit
```

## 退出条件

lint和typecheck退出码为0

## 执行步骤

Step 1: 运行lint和typecheck。用最小diff修复报告的问题。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "frontend-error-boundary-check"
description: "所有路由都有错误边界和fallback UI"
---

# 前端错误边界检查

**分类:** 前端与UI  
**标识符:** `frontend-error-boundary-check`  
**最大迭代次数:** 8

## 目标

所有路由都有错误边界和fallback UI

## 检查命令

```bash
npm run lint:error-boundaries
```

## 退出条件

每个路由都有错误边界覆盖

## 执行步骤

Step 1: 审计路由。添加缺失的错误边界。测试fallback UI。

## 推荐代理

Claude Code、Cursor、Trae

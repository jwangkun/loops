---
name: "bundle-size-budget"
description: "客户端bundle保持在预算内"
---

# Bundle大小预算

**分类:** 性能  
**标识符:** `bundle-size-budget`  
**最大迭代次数:** 5

## 目标

客户端bundle保持在预算内

## 检查命令

```bash
npm run build && npm run size-limit
```

## 退出条件

bundle在预算内

## 执行步骤

Step 1: 构建并测量bundle大小。如果超过预算则懒加载或削减依赖。

## 推荐代理

Claude Code、Cursor、Trae

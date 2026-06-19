---
name: "error-handling-audit"
description: "所有公共函数有一致的错误处理"
---

# 错误处理审计

**分类:** 代码生成与重构  
**标识符:** `error-handling-audit`  
**最大迭代次数:** 8

## 目标

所有公共函数有一致的错误处理

## 检查命令

```bash
npm run lint && npm test
```

## 退出条件

未发现未处理的错误模式

## 执行步骤

Step 1: 扫描缺少错误处理的函数。添加一致的处理。测试。

## 推荐代理

Claude Code、Cursor、Trae

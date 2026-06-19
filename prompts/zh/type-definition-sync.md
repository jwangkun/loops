---
name: "type-definition-sync"
description: "TypeScript类型与运行时API和数据库schema匹配"
---

# 类型定义同步

**分类:** 代码生成与重构  
**标识符:** `type-definition-sync`  
**最大迭代次数:** 8

## 目标

TypeScript类型与运行时API和数据库schema匹配

## 检查命令

```bash
npx tsc --noEmit
```

## 退出条件

typecheck通过且无强制类型转换

## 执行步骤

Step 1: 找到不匹配的type。更新定义。运行typecheck。重复。

## 推荐代理

Claude Code、Cursor、Trae

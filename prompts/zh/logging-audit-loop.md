---
name: "logging-audit-loop"
description: "所有关键路径产生结构化日志"
---

# 日志审计循环

**分类:** 后端与API开发  
**标识符:** `logging-audit-loop`  
**最大迭代次数:** 8

## 目标

所有关键路径产生结构化日志

## 检查命令

```bash
npm run lint:logging
```

## 退出条件

关键路径无非结构化日志语句

## 执行步骤

Step 1: 审计关键路径。替换非结构化日志。测试日志输出。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "guardrails-learning-loop"
description: "测试和lint通过且不重复之前的失败模式"
---

# Guardrails学习循环

**分类:** Git钩子  
**标识符:** `guardrails-learning-loop`  
**最大迭代次数:** 5

## 目标

测试和lint通过且不重复之前的失败模式

## 检查命令

```bash
npm test && npm run lint
```

## 退出条件

检查通过且无重复失败

## 执行步骤

Step 1: 读取guardrails.md。运行检查。如果失败重复则记录再修复。

## 推荐代理

Claude Code、Cursor、Trae

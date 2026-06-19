---
name: "refactor-until-clean"
description: "目标模块达到整洁代码标准"
---

# 重构直到干净

**分类:** 代码生成与重构  
**标识符:** `refactor-until-clean`  
**最大迭代次数:** 10

## 目标

目标模块达到整洁代码标准

## 检查命令

```bash
npm run lint && npm test
```

## 退出条件

lint和测试通过且指标改善

## 执行步骤

Step 1: 识别一个坏味道。重构。运行检查。重复直到指标改善。

## 推荐代理

Claude Code、Cursor、Trae

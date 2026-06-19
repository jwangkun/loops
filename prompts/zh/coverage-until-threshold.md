---
name: "coverage-until-threshold"
description: "覆盖率达标（默认80%）"
---

# 覆盖率直到达标

**分类:** 测试  
**标识符:** `coverage-until-threshold`  
**最大迭代次数:** 10

## 目标

覆盖率达标（默认80%）

## 检查命令

```bash
npm test -- --coverage
```

## 退出条件

覆盖率达标

## 执行步骤

Step 1: 运行覆盖率测试。为最大的未覆盖缺口添加针对性测试。

## 推荐代理

Claude Code、Cursor、Trae

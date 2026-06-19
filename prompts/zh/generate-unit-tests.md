---
name: "generate-unit-tests"
description: "目标函数对边界条件有通过的单元测试"
---

# 生成单元测试

**分类:** 代码生成与重构  
**标识符:** `generate-unit-tests`  
**最大迭代次数:** 5

## 目标

目标函数对边界条件有通过的单元测试

## 检查命令

```bash
npm test -- <target-file>
```

## 退出条件

新测试通过并覆盖边界条件

## 执行步骤

Step 1: 分析函数。为正常、边界和错误情况生成测试。运行。修复。

## 推荐代理

Claude Code、Cursor、Trae

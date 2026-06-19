---
name: "flaky-test-triage"
description: "将失败测试分类为flaky或real"
---

# Flaky测试分类

**分类:** 测试  
**标识符:** `flaky-test-triage`  
**最大迭代次数:** 8

## 目标

将失败测试分类为flaky或real

## 检查命令

```bash
npm test -- --testPathPattern=<failing-suite>
```

## 退出条件

每个失败测试已分类

## 执行步骤

Step 1: 多次运行失败的测试套件。对每个失败进行分类。修复真实问题。

## 推荐代理

Claude Code、Cursor、Trae

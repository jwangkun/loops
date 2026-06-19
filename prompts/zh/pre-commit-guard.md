---
name: "pre-commit-guard"
description: "测试失败时阻止git提交"
---

# Pre-commit守卫

**分类:** 持续集成/持续部署  
**标识符:** `pre-commit-guard`  
**最大迭代次数:** 3

## 目标

测试失败时阻止git提交

## 检查命令

```bash
npm test
```

## 退出条件

测试退出码为0才允许提交

## 执行步骤

Step 1: 在每次git提交前运行测试。修复失败后再提交。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "fix-ci-until-green"
description: "当前分支的最新CI运行通过"
---

# 修复CI直到通过

**分类:** 持续集成/持续部署  
**标识符:** `fix-ci-until-green`  
**最大迭代次数:** 10

## 目标

当前分支的最新CI运行通过

## 检查命令

```bash
gh run list ...
```

## 退出条件

CI运行退出码为0

## 执行步骤

Step 1: 找到最新失败的CI运行。读取日志。本地复现。修复根因。推送。验证。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "ci-failure-watcher"
description: "当前分支的最新CI运行是绿色的"
---

# CI失败监控

**分类:** 持续集成/持续部署  
**标识符:** `ci-failure-watcher`  
**最大迭代次数:** 10

## 目标

当前分支的最新CI运行是绿色的

## 检查命令

```bash
gh run list ...
```

## 退出条件

CI运行是绿色的

## 执行步骤

Step 1: 检查CI状态。如果失败，读取日志、修复根因、必要时推送。

## 推荐代理

Claude Code、Cursor、Trae

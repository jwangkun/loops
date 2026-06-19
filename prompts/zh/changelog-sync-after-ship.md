---
name: "changelog-sync-after-ship"
description: "CHANGELOG.md有准确的[Unreleased]条目"
---

# Changelog同步

**分类:** 开发流程  
**标识符:** `changelog-sync-after-ship`  
**最大迭代次数:** 1

## 目标

CHANGELOG.md有准确的[Unreleased]条目

## 检查命令

```bash
git log -5 --oneline
```

## 退出条件

changelog已更新

## 执行步骤

Step 1: 审查最近提交。为用户可见的变更写Keep-a-Changelog条目。

## 推荐代理

Claude Code、Cursor、Trae

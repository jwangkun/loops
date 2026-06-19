---
name: "pr-watch-loop"
description: "codex-watch PR保持健康且无阻碍"
---

# PR监控循环

**分类:** 持续集成/持续部署  
**标识符:** `pr-watch-loop`  
**最大迭代次数:** 10

## 目标

codex-watch PR保持健康且无阻碍

## 检查命令

```bash
gh pr list --label codex-watch ...
```

## 退出条件

无阻塞问题

## 执行步骤

Step 1: 列出codex-watch PR。检查CI和reviews。报告或修复简单的阻碍。

## 推荐代理

Claude Code、Cursor、Trae

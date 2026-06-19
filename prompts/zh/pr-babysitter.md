---
name: "pr-babysitter"
description: "标记为codex-watch的PR保持健康"
---

# PR保姆

**分类:** 持续集成/持续部署  
**标识符:** `pr-babysitter`  
**最大迭代次数:** 10

## 目标

标记为codex-watch的PR保持健康

## 检查命令

```bash
gh pr list --label "codex-watch"
```

## 退出条件

无阻塞CI失败

## 执行步骤

Step 1: 列出监控的PR。修复CI。rebase过期的PR。评论过期项。

## 推荐代理

Claude Code、Cursor、Trae

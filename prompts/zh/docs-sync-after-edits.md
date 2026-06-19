---
name: "docs-sync-after-edits"
description: "文档与当前代码变更匹配"
---

# 文档同步

**分类:** 文档  
**标识符:** `docs-sync-after-edits`  
**最大迭代次数:** 5

## 目标

文档与当前代码变更匹配

## 检查命令

```bash
git diff main...HEAD --name-only
```

## 退出条件

文档与代码一致

## 执行步骤

Step 1: 审查diff。找到过时的文档。更新它们。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "npm-audit-fix-loop"
description: "没有高危或严重npm审计漏洞"
---

# NPM审计修复循环

**分类:** 依赖管理  
**标识符:** `npm-audit-fix-loop`  
**最大迭代次数:** 10

## 目标

没有高危或严重npm审计漏洞

## 检查命令

```bash
npm audit --audit-level=high && npm test
```

## 退出条件

无漏洞

## 执行步骤

Step 1: 选择一个高危/严重advisory。应用最安全的修复。

## 推荐代理

Claude Code、Cursor、Trae

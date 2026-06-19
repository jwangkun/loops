---
name: "secret-scan-loop"
description: "仓库中无密钥或凭证"
---

# 密钥扫描循环

**分类:** 安全与合规  
**标识符:** `secret-scan-loop`  
**最大迭代次数:** 5

## 目标

仓库中无密钥或凭证

## 检查命令

```bash
npx secretlint --maskSecrets "**/*"
```

## 退出条件

密钥扫描通过

## 执行步骤

Step 1: 运行密钥扫描。删除或轮换泄露的密钥。重复。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "ship-pr-until-green"
description: "PR已打开且所有CI检查通过"
---

# Ship PR直到通过

**分类:** 持续集成/持续部署  
**标识符:** `ship-pr-until-green`  
**最大迭代次数:** 15

## 目标

PR已打开且所有CI检查通过

## 检查命令

```bash
gh pr checks
```

## 退出条件

所有CI检查通过

## 执行步骤

Step 1: 实现变更。本地测试。推送。打开PR。修复CI直到全部通过。

## 推荐代理

Claude Code、Cursor、Trae

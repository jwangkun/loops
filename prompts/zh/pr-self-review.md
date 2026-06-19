---
name: "pr-self-review"
description: "当前diff上完成三轮干净的自我审查"
---

# PR自我审查

**分类:** 持续集成/持续部署  
**标识符:** `pr-self-review`  
**最大迭代次数:** 6

## 目标

当前diff上完成三轮干净的自我审查

## 检查命令

```bash
git diff main...HEAD
```

## 退出条件

三轮审查均无问题

## 执行步骤

Step 1: 像资深审查员一样审查diff。修复发现的问题，然后重新审查。

## 推荐代理

Claude Code、Cursor、Trae

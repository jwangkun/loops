---
name: "post-merge-regression-guard"
description: "每次合并或rebase后冒烟测试立即通过"
---

# 合并后回归守卫

**分类:** Pull Request  
**标识符:** `post-merge-regression-guard`  
**最大迭代次数:** 3

## 目标

每次合并或rebase后冒烟测试立即通过

## 检查命令

```bash
npm run test:smoke
```

## 退出条件

冒烟测试通过

## 执行步骤

Step 1: 合并后运行冒烟测试。在继续其他工作前修复回归。

## 推荐代理

Claude Code、Cursor、Trae

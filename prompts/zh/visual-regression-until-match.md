---
name: "visual-regression-until-match"
description: "视觉回归测试通过，仅保留有意的UI变更"
---

# 视觉回归直到匹配

**分类:** 测试  
**标识符:** `visual-regression-until-match`  
**最大迭代次数:** 6

## 目标

视觉回归测试通过，仅保留有意的UI变更

## 检查命令

```bash
npx playwright test --grep @visual
```

## 退出条件

视觉测试退出码为0

## 执行步骤

Step 1: 运行视觉测试。修复无意的UI差异；只为有意的设计变更更新基准。

## 推荐代理

Claude Code、Cursor、Trae

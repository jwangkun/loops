---
name: "responsive-until-match"
description: "UI在所有目标断点正确渲染"
---

# 响应式直到匹配

**分类:** 前端与UI  
**标识符:** `responsive-until-match`  
**最大迭代次数:** 8

## 目标

UI在所有目标断点正确渲染

## 检查命令

```bash
npx playwright test --grep @responsive
```

## 退出条件

响应式测试通过

## 执行步骤

Step 1: 测试每个断点。修复布局问题。重复直到全部通过。

## 推荐代理

Claude Code、Cursor、Trae

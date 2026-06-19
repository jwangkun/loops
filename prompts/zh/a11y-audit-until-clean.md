---
name: "a11y-audit-until-clean"
description: "变更的UI上没有严重的无障碍访问违规"
---

# 无障碍审计

**分类:** 无障碍  
**标识符:** `a11y-audit-until-clean`  
**最大迭代次数:** 10

## 目标

变更的UI上没有严重的无障碍访问违规

## 检查命令

```bash
npm run test:a11y
```

## 退出条件

无a11y违规

## 执行步骤

Step 1: 在变更的路由上运行a11y审计。修复每个违规。

## 推荐代理

Claude Code、Cursor、Trae

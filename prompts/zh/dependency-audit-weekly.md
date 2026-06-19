---
name: "dependency-audit-weekly"
description: "交付每周依赖审计摘要"
---

# 每周依赖审计

**分类:** 依赖管理  
**标识符:** `dependency-audit-weekly`  
**最大迭代次数:** 1

## 目标

交付每周依赖审计摘要

## 检查命令

```bash
npm outdated || true
```

## 退出条件

过期报告已交付

## 执行步骤

Step 1: 运行npm outdated。按类别更新。建议安全升级计划。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "seed-data-validator"
description: "种子数据干净加载且引用有效"
---

# 种子数据验证器

**分类:** 数据库与数据  
**标识符:** `seed-data-validator`  
**最大迭代次数:** 5

## 目标

种子数据干净加载且引用有效

## 检查命令

```bash
npm run db:seed && npm run test:seed
```

## 退出条件

种子数据无错误加载

## 执行步骤

Step 1: 运行seed脚本。修复损坏的引用或数据问题。重复。

## 推荐代理

Claude Code、Cursor、Trae

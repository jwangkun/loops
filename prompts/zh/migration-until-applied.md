---
name: "migration-until-applied"
description: "所有数据库迁移应用干净"
---

# 迁移直到应用

**分类:** 依赖管理  
**标识符:** `migration-until-applied`  
**最大迭代次数:** 5

## 目标

所有数据库迁移应用干净

## 检查命令

```bash
npx prisma migrate status
```

## 退出条件

迁移已应用

## 执行步骤

Step 1: 运行迁移。修复schema或SQL错误。

## 推荐代理

Claude Code、Cursor、Trae

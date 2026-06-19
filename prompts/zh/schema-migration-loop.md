---
name: "schema-migration-loop"
description: "数据库schema变更已迁移且测试通过"
---

# Schema迁移循环

**分类:** 数据库与数据  
**标识符:** `schema-migration-loop`  
**最大迭代次数:** 8

## 目标

数据库schema变更已迁移且测试通过

## 检查命令

```bash
npx prisma migrate dev && npm test
```

## 退出条件

迁移干净应用且测试通过

## 执行步骤

Step 1: 更新schema。生成迁移。应用。运行测试。修复问题。

## 推荐代理

Claude Code、Cursor、Trae

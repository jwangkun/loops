---
name: "data-consistency-check"
description: "无孤立记录或约束违规"
---

# 数据一致性检查

**分类:** 数据库与数据  
**标识符:** `data-consistency-check`  
**最大迭代次数:** 5

## 目标

无孤立记录或约束违规

## 检查命令

```bash
npm run db:consistency
```

## 退出条件

所有一致性检查通过

## 执行步骤

Step 1: 运行一致性检查。修复每个违规。重复直到干净。

## 推荐代理

Claude Code、Cursor、Trae

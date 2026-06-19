---
name: "query-performance-loop"
description: "慢查询优化到阈值以下"
---

# 查询性能循环

**分类:** 数据库与数据  
**标识符:** `query-performance-loop`  
**最大迭代次数:** 8

## 目标

慢查询优化到阈值以下

## 检查命令

```bash
npm run benchmark:queries
```

## 退出条件

所有查询低于阈值

## 执行步骤

Step 1: 识别最慢的查询。添加索引或重写。基准测试。重复。

## 推荐代理

Claude Code、Cursor、Trae

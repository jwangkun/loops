---
name: "backup-verify-loop"
description: "最新数据库备份成功恢复"
---

# 备份验证循环

**分类:** 数据库与数据  
**标识符:** `backup-verify-loop`  
**最大迭代次数:** 3

## 目标

最新数据库备份成功恢复

## 检查命令

```bash
npm run db:backup:verify
```

## 退出条件

备份恢复且基本查询通过

## 执行步骤

Step 1: 执行备份。恢复到临时实例。运行冒烟查询。修复问题。

## 推荐代理

Claude Code、Cursor、Trae

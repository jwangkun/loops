---
name: "backup-routine-loop"
description: "所有关键数据已备份并验证"
---

# 备份例行循环

**分类:** 系统与DevOps  
**标识符:** `backup-routine-loop`  
**最大迭代次数:** 5

## 目标

所有关键数据已备份并验证

## 检查命令

```bash
python scripts/backup_check.py
```

## 退出条件

所有备份完成并验证

## 执行步骤

Step 1: 运行备份任务。验证完整性。修复失败。重复。

## 推荐代理

Claude Code、Cursor、Trae

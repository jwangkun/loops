---
name: "dashboard-sync-loop"
description: "仪表盘反映最新数据和指标"
---

# 仪表盘同步循环

**分类:** 数据科学与分析  
**标识符:** `dashboard-sync-loop`  
**最大迭代次数:** 5

## 目标

仪表盘反映最新数据和指标

## 检查命令

```bash
python scripts/refresh_dashboard.py
```

## 退出条件

仪表盘数据已更新

## 执行步骤

Step 1: 刷新仪表盘。修复损坏的查询或过时的缓存。重复。

## 推荐代理

Claude Code、Cursor、Trae

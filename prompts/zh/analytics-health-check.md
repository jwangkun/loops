---
name: "analytics-health-check"
description: "所有关键事件正确追踪"
---

# 分析健康检查

**分类:** 运营与市场  
**标识符:** `analytics-health-check`  
**最大迭代次数:** 8

## 目标

所有关键事件正确追踪

## 检查命令

```bash
python scripts/analytics_check.py
```

## 退出条件

所有事件正确触发

## 执行步骤

Step 1: 审计事件。修复缺失或错误的追踪。测试。重复。

## 推荐代理

Claude Code、Cursor、Trae

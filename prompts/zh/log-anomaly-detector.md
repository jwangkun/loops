---
name: "log-anomaly-detector"
description: "近期日志无严重异常"
---

# 日志异常检测器

**分类:** 系统与DevOps  
**标识符:** `log-anomaly-detector`  
**最大迭代次数:** 10

## 目标

近期日志无严重异常

## 检查命令

```bash
python scripts/log_anomaly.py
```

## 退出条件

未检测到严重异常

## 执行步骤

Step 1: 扫描日志。调查异常。修复根因。重复。

## 推荐代理

Claude Code、Cursor、Trae

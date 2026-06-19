---
name: "experiment-tracker"
description: "实验结果已记录且可复现"
---

# 实验追踪器

**分类:** 数据科学与分析  
**标识符:** `experiment-tracker`  
**最大迭代次数:** 8

## 目标

实验结果已记录且可复现

## 检查命令

```bash
python scripts/check_experiments.py
```

## 退出条件

所有实验都有元数据和输出

## 执行步骤

Step 1: 运行缺失的实验。记录参数和指标。验证可复现性。

## 推荐代理

Claude Code、Cursor、Trae

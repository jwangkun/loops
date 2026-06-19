---
name: "data-pipeline-until-green"
description: "数据管道端到端无错误运行"
---

# 数据管道直到绿色

**分类:** 数据科学与分析  
**标识符:** `data-pipeline-until-green`  
**最大迭代次数:** 10

## 目标

数据管道端到端无错误运行

## 检查命令

```bash
python scripts/run_pipeline.py
```

## 退出条件

管道成功完成

## 执行步骤

Step 1: 运行管道。修复第一个失败。重复直到完成。

## 推荐代理

Claude Code、Cursor、Trae

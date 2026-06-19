---
name: "model-training-loop"
description: "模型在验证集上达到目标准确率"
---

# 模型训练循环

**分类:** 数据科学与分析  
**标识符:** `model-training-loop`  
**最大迭代次数:** 20

## 目标

模型在验证集上达到目标准确率

## 检查命令

```bash
python scripts/train.py --validate
```

## 退出条件

验证准确率达标

## 执行步骤

Step 1: 训练模型。评估。调整超参数。重复直到达标。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "dead-code-removal"
description: "无未使用的导出、变量或函数残留"
---

# 死代码清理

**分类:** 代码生成与重构  
**标识符:** `dead-code-removal`  
**最大迭代次数:** 5

## 目标

无未使用的导出、变量或函数残留

## 检查命令

```bash
npx knip --no-exit-code && npm test
```

## 退出条件

knip报告无死代码

## 执行步骤

Step 1: 运行死代码分析器。删除或使用标记项。测试。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "test-until-green"
description: "所有测试通过"
---

# 测试直到通过

**分类:** 测试  
**标识符:** `test-until-green`  
**最大迭代次数:** 10

## 目标

所有测试通过

## 检查命令

```bash
npm test
```

## 退出条件

测试退出码为0

## 执行步骤

Step 1: 运行测试。如果有失败，修复最小的根因，然后重复。

## 推荐代理

Claude Code、Cursor、Trae

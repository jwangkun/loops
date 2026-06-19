---
name: "e2e-until-green"
description: "E2E测试套件通过"
---

# E2E测试直到通过

**分类:** 测试  
**标识符:** `e2e-until-green`  
**最大迭代次数:** 10

## 目标

E2E测试套件通过

## 检查命令

```bash
npm run test:e2e
```

## 退出条件

E2E测试退出码为0

## 执行步骤

Step 1: 运行E2E测试。修复第一个失败的spec，然后重复直到全部通过。

## 推荐代理

Claude Code、Cursor、Trae

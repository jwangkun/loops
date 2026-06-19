---
name: "independent-verifier-pass"
description: "构建、lint和测试在独立验证下通过"
---

# 独立验证通过

**分类:** 维护  
**标识符:** `independent-verifier-pass`  
**最大迭代次数:** 1

## 目标

构建、lint和测试在独立验证下通过

## 检查命令

```bash
npm run build && npm run lint && npm test
```

## 退出条件

所有验证通过

## 执行步骤

Step 1: 作为验证者运行构建、lint和测试。只信任命令输出。

## 推荐代理

Claude Code、Cursor、Trae

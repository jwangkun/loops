---
name: "api-contract-until-match"
description: "API实现与发布的契约匹配"
---

# API契约匹配

**分类:** API/规范  
**标识符:** `api-contract-until-match`  
**最大迭代次数:** 10

## 目标

API实现与发布的契约匹配

## 检查命令

```bash
npm run test:contract
```

## 退出条件

契约测试通过

## 执行步骤

Step 1: 运行契约测试。用最小diff修复每个schema/response不匹配。

## 推荐代理

Claude Code、Cursor、Trae

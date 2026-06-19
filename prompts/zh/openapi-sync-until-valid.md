---
name: "openapi-sync-until-valid"
description: "openapi.yaml lint干净且与实现的路由匹配"
---

# OpenAPI同步

**分类:** API/规范  
**标识符:** `openapi-sync-until-valid`  
**最大迭代次数:** 10

## 目标

openapi.yaml lint干净且与实现的路由匹配

## 检查命令

```bash
npx @redocly/cli lint openapi.yaml
```

## 退出条件

openapi lint退出码为0

## 执行步骤

Step 1: Lint openapi.yaml。修复spec错误和处理程序漂移。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "authz-policy-loop"
description: "所有敏感端点都实施授权"
---

# 授权策略循环

**分类:** 后端与API开发  
**标识符:** `authz-policy-loop`  
**最大迭代次数:** 10

## 目标

所有敏感端点都实施授权

## 检查命令

```bash
npm run test:authz
```

## 退出条件

授权测试通过

## 执行步骤

Step 1: 审计端点。添加授权检查。编写测试。重复。

## 推荐代理

Claude Code、Cursor、Trae

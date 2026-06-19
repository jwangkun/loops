---
name: "deploy-verification-loop"
description: "所有部署后健康和冒烟端点返回成功"
---

# 部署验证循环

**分类:** 部署  
**标识符:** `deploy-verification-loop`  
**最大迭代次数:** 5

## 目标

所有部署后健康和冒烟端点返回成功

## 检查命令

```bash
curl -fsS <your-health-url>
```

## 退出条件

端点返回0

## 执行步骤

Step 1: 访问健康/冒烟URL。如果失败则检查部署日志。

## 推荐代理

Claude Code、Cursor、Trae

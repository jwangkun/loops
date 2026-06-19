---
name: "staging-smoke-test"
description: "预发布环境冒烟测试通过"
---

# 预发布冒烟测试

**分类:** 测试  
**标识符:** `staging-smoke-test`  
**最大迭代次数:** 5

## 目标

预发布环境冒烟测试通过

## 检查命令

```bash
npm run smoke:staging
```

## 退出条件

预发布环境冒烟测试退出码为0

## 执行步骤

Step 1: 运行预发布环境冒烟测试清单。修复第一个失败项。

## 推荐代理

Claude Code、Cursor、Trae

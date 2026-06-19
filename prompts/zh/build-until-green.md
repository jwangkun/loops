---
name: "build-until-green"
description: "生产构建成功"
---

# 构建直到成功

**分类:** 持续集成/持续部署  
**标识符:** `build-until-green`  
**最大迭代次数:** 5

## 目标

生产构建成功

## 检查命令

```bash
npm run build
```

## 退出条件

构建退出码为0

## 执行步骤

Step 1: 运行构建。如果失败，修复第一个错误，然后重复直到成功。

## 推荐代理

Claude Code、Cursor、Trae

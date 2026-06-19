---
name: "dependency-upgrade-one-by-one"
description: "关键过时依赖升级且测试绿色"
---

# 依赖逐个升级

**分类:** 依赖管理  
**标识符:** `dependency-upgrade-one-by-one`  
**最大迭代次数:** 10

## 目标

关键过时依赖升级且测试绿色

## 检查命令

```bash
npm outdated && npm test && npm run build
```

## 退出条件

过时依赖已升级且全部绿色

## 执行步骤

Step 1: 选择一个过时的包。升级它。修复破坏性变更。提交。

## 推荐代理

Claude Code、Cursor、Trae

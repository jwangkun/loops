---
name: "knip-until-clean"
description: "knip报告没有未使用代码或依赖"
---

# Knip清理

**分类:** 代码质量  
**标识符:** `knip-until-clean`  
**最大迭代次数:** 5

## 目标

knip报告没有未使用代码或依赖

## 检查命令

```bash
npx knip
```

## 退出条件

knip退出码为0

## 执行步骤

Step 1: 运行knip。删除死代码和未使用依赖。验证测试仍然通过。

## 推荐代理

Claude Code、Cursor、Trae

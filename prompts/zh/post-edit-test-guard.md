---
name: "post-edit-test-guard"
description: "编辑后相关测试必须通过"
---

# 编辑后测试守卫

**分类:** 测试  
**标识符:** `post-edit-test-guard`  
**最大迭代次数:** 3

## 目标

编辑后相关测试必须通过

## 检查命令

```bash
npm test -- --findRelatedTests <files>
```

## 退出条件

相关测试通过

## 执行步骤

Step 1: 编辑后运行相关测试。修复失败后再继续。

## 推荐代理

Claude Code、Cursor、Trae

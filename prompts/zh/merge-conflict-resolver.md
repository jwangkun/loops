---
name: "merge-conflict-resolver"
description: "分支在main上rebase成功且测试通过"
---

# 合并冲突解决

**分类:** Pull Request  
**标识符:** `merge-conflict-resolver`  
**最大迭代次数:** 10

## 目标

分支在main上rebase成功且测试通过

## 检查命令

```bash
npm test
```

## 退出条件

rebase成功且测试通过

## 执行步骤

Step 1: 在main上rebase。一次一个文件解决冲突。运行测试。

## 推荐代理

Claude Code、Cursor、Trae

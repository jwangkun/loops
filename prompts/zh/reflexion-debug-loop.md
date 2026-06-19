---
name: "reflexion-debug-loop"
description: "失败的测试或复现通过"
---

# Reflexion调试循环

**分类:** 开发流程  
**标识符:** `reflexion-debug-loop`  
**最大迭代次数:** 10

## 目标

失败的测试或复现通过

## 检查命令

```bash
npm test -- --testNamePattern=<test>
```

## 退出条件

测试或复现通过

## 执行步骤

Step 1: 复现bug。如果失败则在反思文件中记录后再尝试新修复。

## 推荐代理

Claude Code、Cursor、Trae

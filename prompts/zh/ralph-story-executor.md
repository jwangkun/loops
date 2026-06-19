---
name: "ralph-story-executor"
description: "每个story都有passes: true"
---

# Ralph故事执行器

**分类:** 开发流程  
**标识符:** `ralph-story-executor`  
**最大迭代次数:** 20

## 目标

每个story都有passes: true

## 检查命令

```bash
npm test && npm run lint && npm run build
```

## 退出条件

所有story通过

## 执行步骤

Step 1: 读取.rhal/prd.json。选择一个未完成的story。实现它。更新状态。

## 推荐代理

Claude Code、Cursor、Trae

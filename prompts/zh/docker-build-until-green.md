---
name: "docker-build-until-green"
description: "Docker镜像构建并通过健康检查"
---

# Docker构建直到成功

**分类:** 系统与DevOps  
**标识符:** `docker-build-until-green`  
**最大迭代次数:** 8

## 目标

Docker镜像构建并通过健康检查

## 检查命令

```bash
docker build -t app . && docker run --rm app healthcheck
```

## 退出条件

镜像构建且健康检查通过

## 执行步骤

Step 1: 构建镜像。修复Dockerfile问题。运行健康检查。重复。

## 推荐代理

Claude Code、Cursor、Trae

---
name: "docker-build-until-green"
description: "Docker image builds and passes health check"
---

# Docker Build Until Green

**Category:** System & DevOps  
**Slug:** `docker-build-until-green`  
**Max Iterations:** 8

## Goal

Docker image builds and passes health check

## Check Command

```bash
docker build -t app . && docker run --rm app healthcheck
```

## Exit Condition

image builds and healthcheck passes

## Steps

Step 1: Build image. Fix Dockerfile issues. Run healthcheck. Repeat.

## Recommended Agents

Claude Code, Cursor, Trae

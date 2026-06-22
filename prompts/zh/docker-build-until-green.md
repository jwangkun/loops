---
name: "docker-build-until-green"
description: "镜像构建且健康检查通过"
---

# Docker 构建直到成功

**分类:** 系统与DevOps
**标识符:** `docker-build-until-green`
**最大迭代次数:** 8

## 目标

让 Docker 镜像成功构建，且启动后健康检查（healthcheck）通过、容器以退出码 0 退出。成功意味着 Dockerfile、基础镜像、依赖安装、应用启动与健康探针全链路正常，产出的镜像可实际运行。

## 适用场景

修改 Dockerfile、依赖清单、启动入口或健康检查逻辑后使用；适合在镜像化部署前迭代修复构建与运行时问题。

## 检查命令

```bash
docker build -t app . && docker run --rm app healthcheck
```

## 退出条件

- `docker build -t app .` 退出码为 0，镜像 `app` 已生成。
- `docker run --rm app healthcheck` 退出码为 0。
- 构建过程中无错误，运行时无 crash、无健康检查超时。

## 执行步骤

Step 1: 运行检查命令，分别捕获 build 与 run 阶段的 stdout/stderr 及退出码；记录失败发生在哪一阶段。
Step 2: 分析失败：build 阶段区分基础镜像拉取失败、指令错误（COPY 路径、RUN 命令）、依赖安装失败、磁盘/层缓存问题；run 阶段区分入口缺失、端口/卷未挂载、应用启动失败、healthcheck 命令本身错误或超时。
Step 3: 做最小修复——修正 Dockerfile 指令/路径、补全依赖、调整入口或 healthcheck 配置（如 `start-period`、重试次数）。绝不要通过让 healthcheck 恒返回 0、注释掉检查或 `|| true` 来伪造健康。
Step 4: 重新运行检查命令；若仍失败且未超过最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未通过时停止，分别列出 build 阶段与 run 阶段的剩余问题及根因。不要无限循环。

## 常见陷阱

- 让 healthcheck 命令恒返回 0（如 `CMD ["true"]` 或 `|| exit 0`），镜像看似健康实则未真正探测。
- 应用启动慢但 healthcheck 未设 `start-period`/重试，容器在就绪前被判为不健康。
- 依赖在构建期与运行期不一致（构建期装了 dev 依赖，运行期缺失），导致 build 绿但 run 崩。
- `COPY` 路径或 `.dockerignore` 配置错误，运行时缺文件；或层缓存掩盖了真实改动，需 `--no-cache` 复现。

## 注意事项

- 不要为通过构建而用 `latest` 基础镜像或关闭多阶段构建的安全/瘦身优化。
- healthcheck 必须真实探测应用可用性（如探 `/health` 接口），而非空操作。
- 涉及密钥时使用构建参数/挂载，不要把密钥烤进镜像层。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

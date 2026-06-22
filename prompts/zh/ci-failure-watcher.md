---
name: "ci-failure-watcher"
description: "监控CI状态，失败时修复根因"
---

# CI失败监控

**分类:** 持续集成/持续部署
**标识符:** `ci-failure-watcher`
**最大迭代次数:** 10

## 目标

持续观察当前分支最新 CI 运行的状态，一旦失败就定位根因并修复，使运行在无需人为介入的情况下回到绿色。与主动修复不同，该循环以"观察—判断—必要时介入"为主。

## 适用场景

适合在长任务期间持续盯守某个分支的 CI，出现失败时自动处理，而无需手动反复检查。

## 检查命令

```bash
gh run list --branch "$(git rev-parse --abbrev-ref HEAD)" --limit 1 --json status,conclusion,databaseId
```

## 退出条件

- 当前分支最新运行 `status` 为 `completed` 且 `conclusion` 为 `success`。

## 执行步骤

Step 1: 运行检查命令，获取最新运行的 ID、状态与结论；若仍在进行中（`in_progress`），等待后重新检查，不急于行动。
Step 2: 若 `conclusion` 为失败/取消，用 `gh run view <id> --log-failed` 读取日志，判断这是真实代码失败还是基础设施抖动（超时、限流、flaky test、上游 main 故障）。
Step 3: 若为真实失败，做最小根因修复并在本地复现验证后推送；若是抖动或仅因运行被取消，优先触发 `gh run rerun` 而非改代码。
Step 4: 重新运行检查命令；若仍未绿且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代次数仍未绿时，停止并报告剩余失败、日志关键报错与已尝试的处理，不要无限循环。

## 常见陷阱

- 把抖动性失败（flaky/网络/限流）误当代码缺陷去改实现，正确做法是重跑运行。
- 在运行还没结束（`in_progress`）时就急于"修复"，导致基于过时结论行动。
- 只读了运行总结而没看具体失败 job 的日志，误判失败范围。
- 失败其实来自上游 main 的破坏，却在本分支反复折腾。

## 注意事项

- 默认以观察为主，只有确认是本分支真实失败才改代码。
- 禁止靠跳过测试或放宽校验制造虚假绿色。
- 触发重跑前确认运行确为可重跑状态（`incomplete`/失败），避免重复触发同一运行。
- 修复提交要聚焦根因，一次只改一处，避免混入无关改动。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

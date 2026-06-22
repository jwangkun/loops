---
name: "fix-ci-until-green"
description: "修复CI失败直到当前分支CI变绿"
---

# 修复CI直到通过

**分类:** 持续集成/持续部署
**标识符:** `fix-ci-until-green`
**最大迭代次数:** 10

## 目标

让当前分支的最新一次 CI 运行变绿。成功意味着失败根因被真正修复、变更已推送，且远端最新运行以退出码 0 结束，而非用跳过、取消或临时绕过的方式掩盖问题。

## 适用场景

当前分支已推送代码，但 CI 正在失败，需要一个能定位根因、修复并验证的自动化循环时使用。

## 检查命令

```bash
gh run list --branch "$(git rev-parse --abbrev-ref HEAD)" --limit 1 --json status,conclusion,databaseId
```

## 退出条件

- 当前分支最新运行 `status` 为 `completed` 且 `conclusion` 为 `success`。

## 执行步骤

Step 1: 运行检查命令，捕获最新运行的 ID、状态与结论；若 `status` 仍为 `in_progress`，等待后重查。
Step 2: 若 `conclusion` 不是 `success`，用 `gh run view <id> --log-failed` 读取失败日志，定位失败的 job、测试或步骤；区分是本分支代码导致的真实失败，还是基础设施抖动（flaky test、网络、上游 main 故障）。
Step 3: 针对真实根因做最小修复：本地复现失败，改代码或配置（绝不注释掉测试、绝不放宽校验、绝不跳过检查来制造"绿色"）。
Step 4: 本地复跑相关测试通过后 `git commit` 并推送；等待新一轮 CI，回到 Step 1。
Step 5: 若达到最大迭代次数仍未变绿，停止并报告：剩余失败的 job、日志关键报错、已尝试的修复及未解决的阻碍，不要无限循环。

## 常见陷阱

- 把 flaky 测试或临时网络/基础设施故障误判为代码缺陷而改动代码；这类应重跑运行而非改实现。
- 修复只让本地通过，但未覆盖 CI 真正执行的矩阵、环境变量或 lint/typecheck 步骤。
- 只盯着报错行而忽略构建产物缓存陈旧导致的假失败（清除缓存或 bump cache key）。
- 上游 main 已经坏了，误以为是本分支的问题。

## 注意事项

- 只修复本分支引入的问题；若失败来自上游 main，先同步 main 或上报，不要替别人改代码。
- 禁止用跳过测试、强制退出码 0、`|| true` 等方式制造虚假绿色。
- 每次只推送聚焦于根因的小提交，避免在一次修复中混入无关改动。
- 推送前确认本地能复现失败，否则修复无从验证。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

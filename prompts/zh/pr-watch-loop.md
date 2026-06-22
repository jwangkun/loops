---
name: "pr-watch-loop"
description: "巡检codex-watch PR并报告或修复阻碍"
---

# PR监控循环

**分类:** 持续集成/持续部署
**标识符:** `pr-watch-loop`
**最大迭代次数:** 10

## 目标

定期巡检带 `codex-watch` 标签的 PR，掌握每条 PR 的 CI 与评审状态，修复其中简单可解的阻碍，对其余问题给出清晰报告，确保没有 PR 因被忽略的细节而卡住。

## 适用场景

适合需要对外汇报一批 PR 进度、或定期确认它们未被 CI 失败或缺少评审所阻塞的轻量巡检场景。

## 检查命令

```bash
gh pr list --label codex-watch --json number,title,mergeable,mergeStateStatus
```

## 退出条件

- 所有 `codex-watch` PR 中没有可由本循环解决的阻塞问题。
- 仍存在的阻塞（等待人工评审、需决策、上游故障）均已写入报告。

## 执行步骤

Step 1: 运行检查命令，获取 `codex-watch` PR 列表，并对每条 PR 查询 CI 检查状态（`gh pr checks <N>`）与评审状态（review/requested-reviewers）。
Step 2: 把每条 PR 归类为：健康、CI 失败、缺评审、与 base 冲突/陈旧、阻塞于外部依赖。
Step 3: 只修复简单且低风险的阻碍（如重启失败的 flaky 检查、补一处明显的 lint 修复）；对涉及逻辑改动或需决策的问题不擅自改，改为记录。
Step 4: 汇总每条 PR 的状态与下一步动作，生成简明报告；若刚做了修复，回到 Step 1 重新确认是否已解除阻塞。
Step 5: 若达到最大迭代次数，停止并输出最终报告：每条 PR 的健康度、未解决阻塞及建议处理方式，不要无限循环。

## 常见陷阱

- 把 flaky 或上游故障误判为 PR 自身 CI 失败，并对实现做不必要改动。
- 越界处理需要人工评审或产品决策的问题，留下未经评审的改动。
- 报告只罗列"失败"而不给下一步动作，导致问题依旧无人跟进。
- 只看 CI 而忽略 review 缺失、mergeable=false 等同样会阻塞合并的因素。

## 注意事项

- 以观察与报告为主，修复仅限简单、低风险、可自验证的项。
- 不得通过跳过测试或放宽校验让 CI "变绿"再上报。
- 报告需可执行：每条 PR 给出明确的下一步（谁需做什么），而非泛泛的"有问题"。
- 不改动未被 `codex-watch` 标签覆盖的 PR。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

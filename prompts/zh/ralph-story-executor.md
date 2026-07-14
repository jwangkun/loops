---
name: "ralph-story-executor"
description: "让每个 story 都达成 passes: true"
---

# Ralph 故事执行器

**分类:** 开发流程
**标识符:** `ralph-story-executor`
**最大迭代次数:** 20

## 目标

从 `.rhal/prd.json` 中逐个推进未完成的 story，直到每个 story 的状态均为 `passes: true`。每完成一个 story 都要让测试、lint 与构建同时通过。

## 适用场景

项目以 `.rhal/prd.json` 驱动故事列表，需要按顺序实现 story 并用统一的检查命令验收。

## 检查命令

```bash
npm test && npm run lint && npm run build
```

## 退出条件

- `.rhal/prd.json` 中所有 story 均标记为 `passes: true`。
- 检查命令一次通过，无失败、无 lint 报错、构建成功。

## 执行步骤

Step 1: 读取 `.rhal/prd.json`，列出所有 story 及其当前状态。
Step 2: 选择下一个 `passes` 不为 `true` 的 story，确认其验收标准与依赖关系。
Step 3: 实现该 story 所需的最小代码；不引入 story 范围外的功能。
Step 4: 运行检查命令；通过后将该 story 置为 `passes: true`，再回到 Step 2 选下一个 story。
Step 5: 达到最大迭代仍有未通过 story 时停止，报告剩余 story 及其失败原因，不得无限循环。

## 常见陷阱

- 在检查命令未全绿时就把 story 标为 `passes: true`，造成状态与实际不符。
- 一次性实现多个 story，定位不到是哪个 story 导致失败。
- 跳过 lint 或构建失败，仅靠测试通过判断 story 完成。
- 为通过测试而硬编码 story 输出，破坏后续 story 的实现。

## 注意事项

- 严格按顺序推进，避免并行实现造成冲突。
- story 状态变更需可追溯，便于回滚单个 story 的实现。

- 收敛保护：若同一检查以相同根因连续两次迭代失败，应更换思路或停止上报，而非机械地原样重试。
- 预算纪律：遵守宿主 harness 的 token / 成本 / 时间预算；预算耗尽视为「停止并上报」信号，而非重试信号。
- 终态明确：循环只能以「成功 / 受阻 / 耗尽」三种终态结束；停滞或预算耗尽绝不能被报告为成功。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

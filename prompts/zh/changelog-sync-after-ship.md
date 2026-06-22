---
name: "changelog-sync-after-ship"
description: "维护准确的 [Unreleased] 变更记录"
---

# Changelog 同步

**分类:** 文档
**标识符:** `changelog-sync-after-ship`
**最大迭代次数:** 1

## 目标

让 `CHANGELOG.md` 的 `[Unreleased]` 区块准确反映自上次发布以来的用户可见变更，遵循 Keep-a-Changelog 格式，不漏项、不重复、不记录无关的内部重构。

## 适用场景

刚完成一次发布或一批提交，需要在发布前补全变更日志，确保用户能据此了解本次更新。

## 检查命令

```bash
git log -5 --oneline
```

## 退出条件

- `[Unreleased]` 区块已存在，且包含最近提交中所有用户可见变更。
- 每条变更归类正确（Added/Changed/Deprecated/Removed/Fixed/Security），无重复条目。

## 执行步骤

Step 1: 运行检查命令，查看最近提交；必要时结合 `git show` 确认每条提交的实际影响。
Step 2: 区分用户可见变更与纯内部重构/格式化/测试，只保留前者。
Step 3: 按 Keep-a-Changelog 分类为每条变更写条目，措辞面向使用者而非实现细节。
Step 4: 重新检查 `[Unreleased]` 区块，确认无重复、无遗漏、无空区块或占位文字。
Step 5: 若仍存在不一致（最大迭代为 1，仅一次），停止并报告剩余未覆盖的提交。

## 常见陷阱

- `[Unreleased]` 留空或仅写占位符，用户看不到本次更新内容。
- 同一变更被拆成多条或在不同分类下重复出现。
- 把内部重构、依赖升级、代码风格等非用户可见变更也写进日志。
- 分类错误（例如把破坏性改动放进 Changed 而非更显眼的位置）。

## 注意事项

- 条目需可追溯到具体提交，便于后续核验。
- 不臆造尚未实现的特性；不确定的变更应核对 diff 后再写入。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

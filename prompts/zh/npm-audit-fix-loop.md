---
name: "npm-audit-fix-loop"
description: "消除高危与严重依赖漏洞"
---

# NPM 审计修复循环

**分类:** 安全
**标识符:** `npm-audit-fix-loop`
**最大迭代次数:** 10

## 目标

让 `npm audit --audit-level=high` 报告零高危/严重漏洞，同时保持 `npm test` 全绿。每次修复都应真正消除漏洞根因，而非用 override 掩盖。

## 适用场景

依赖项中出现新增或残留的高危/严重 advisory 时使用；不适用于低危/提示级漏洞，也不适用于锁文件被冻结的发布分支。

## 检查命令

```bash
npm audit --audit-level=high && npm test
```

## 退出条件

- `npm audit --audit-level=high` 退出码为 0（无高危或严重漏洞）。
- `npm test` 全部通过。
- 未新增 `overrides`/`resolutions` 来掩盖 advisory，或新增项已附带可追溯的说明。

## 执行步骤

Step 1: 运行检查命令，捕获完整 `npm audit` 输出与测试结果，记录每条失败的 advisory（包名、版本、CVE、严重性、修复版本）。
Step 2: 按严重性排序，挑取优先级最高的一条；分析其依赖路径与可用的修复版本，确认该升级是否触及其他包的 peer dep。
Step 3: 实施最小且安全的修复（优先 `npm update` 或升级直接依赖；必要时 `npm audit fix`）；严禁用 `overrides`/`resolutions` 强制锁定版本来掩盖漏洞。
Step 4: 重新运行检查命令；若仍有高危/严重漏洞且未达最大迭代次数，回到 Step 2。
Step 5: 若达到最大迭代次数仍未清零，停止并报告剩余 advisory、阻塞原因与建议的人工决策项，不得无限循环。

## 常见陷阱

- `npm audit fix --force` 会跨主版本升级，可能破坏 API 与运行时行为，务必配合测试验证。
- 出现 peer dep 冲突时直接 override 会让漏洞"在报告里消失"但根因仍在，属掩盖行为。
- 某些 advisory 来自开发依赖（devDependencies），修复价值与生产依赖不同，需分别评估。
- 锁文件不一致或存在多个 `package-lock.json` 时，审计结果可能与实际安装不符。

## 注意事项

- 优先在隔离分支上修复并跑完整测试套件后再合入。
- 对每个变更记录"为什么这是真正的修复"，便于审计回溯。
- 若 advisory 无可用修复版本（漏洞依赖已停止维护），报告并评估替换方案，不要强行降级或 override。

- 收敛保护：若同一检查以相同根因连续两次迭代失败，应更换思路或停止上报，而非机械地原样重试。
- 预算纪律：遵守宿主 harness 的 token / 成本 / 时间预算；预算耗尽视为「停止并上报」信号，而非重试信号。
- 终态明确：循环只能以「成功 / 受阻 / 耗尽」三种终态结束；停滞或预算耗尽绝不能被报告为成功。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

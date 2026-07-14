---
name: "terraform-plan-until-clean"
description: "terraform plan 无意外变更"
---

# Terraform Plan 直到干净

**分类:** 系统与DevOps
**标识符:** `terraform-plan-until-clean`
**最大迭代次数:** 8

## 目标

使 `terraform plan` 无意外变更：退出码 0（无 diff），或 diff 已完全核实且为有意为之。任何意外漂移都在代码或状态中纠正，每个资源变更在循环结束前都被理解。成功即 plan 干净，或其剩余 diff 100% 符合预期。

## 适用场景

应用基础设施变更前、合并 IaC PR 后，或确认代码与真实基础设施之间无漂移时使用。

## 检查命令

```bash
terraform plan -detailed-exitcode
```

## 退出条件

- `terraform plan -detailed-exitcode` 退出码 0（无变更），或
- 退出码 2（存在变更）且每个资源变更均已审查并确认为有意。
- 退出码 1（错误）绝不作为可接受的结束状态。

## 执行步骤

Step 1: 运行 `terraform plan -detailed-exitcode`，完整捕获 diff；记录退出码（0 干净、2 有变更、1 错误）。
Step 2: 逐项分析变更与错误：区分有意的代码驱动变更与漂移（控制台手动改动）、陈旧状态或 provider/版本不一致；绝不把破坏性变更当作常规处理。
Step 3: 采取最小且正确的修复——更新代码以匹配现实、将漂移资源刷新/导入状态，或对齐版本；不要用 `--target` 或忽略变更来掩盖漂移。
Step 4: 重新运行 plan；若仍有变更或错误且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未得到干净或完全符合预期的 plan 则停止，报告剩余无法解释的 diff 及任何破坏性动作，不要无限循环。

## 常见陷阱

- 控制台手动改动造成的真实漂移以 diff 形式出现——应通过导入/修正状态修复，而非忽略。
- 本地状态不同步（漏跑 `terraform init`/refresh 或后端陈旧）产生虚假 diff。
- 破坏性变更（`force-replace`、`destroy`）藏在大 plan 中，未经审查即被自动确认。
- 团队成员之间 provider 版本不一致，产生无意义的虚假 diff。

## 注意事项

- 切勿在本循环内运行 `terraform apply`——本循环只做 plan 并对齐代码/状态。
- 在认定 plan 可接受前，必须向人工明确标记任何 `force-replace` 或 `destroy`。

- 收敛保护：若同一检查以相同根因连续两次迭代失败，应更换思路或停止上报，而非机械地原样重试。
- 预算纪律：遵守宿主 harness 的 token / 成本 / 时间预算；预算耗尽视为「停止并上报」信号，而非重试信号。
- 终态明确：循环只能以「成功 / 受阻 / 耗尽」三种终态结束；停滞或预算耗尽绝不能被报告为成功。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

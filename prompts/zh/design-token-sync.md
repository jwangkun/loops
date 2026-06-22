---
name: "design-token-sync"
description: "所有UI使用批准的设计token"
---

# 设计 Token 同步

**分类:** 前端与UI
**标识符:** `design-token-sync`
**最大迭代次数:** 8

## 目标

让所有 UI 的颜色、间距、字号、圆角、阴影等视觉值统一来自批准的设计 token 集合，消除硬编码字面量。成功意味着 `lint:design-tokens` 通过，且样式完全可由设计系统驱动、可主题化、可统一变更。

## 适用场景

接入或升级设计系统后、重构样式以支持主题（如深色模式）时、或在 CI 中需要守住设计规范一致性时使用。

## 检查命令

```bash
npm run lint:design-tokens
```

## 退出条件

- `lint:design-tokens` 通过（exit 0）。
- 无硬编码颜色、间距、字号、圆角或阴影字面量。
- 所有视觉值均可追溯到某个设计 token。

## 执行步骤

Step 1: 运行 `npm run lint:design-tokens`，捕获硬编码值的文件、行号与具体值（颜色、间距等）。
Step 2: 分类分析硬编码值：颜色、间距、字号、圆角、阴影或 z-index；确认每个值在现有 token 集合中是否有等价项，或是否需要新增 token。
Step 3: 用对应的 token 变量/工具类替换硬编码值；若确需新值，先在 token 源文件登记并评审后再使用；保持最小改动。
Step 4: 重新运行 `npm run lint:design-tokens`；若仍有失败且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代次数仍未通过，停止并报告剩余硬编码清单与建议，不要无限循环。

## 常见陷阱

- 用 token 变量包裹硬编码值（如 `--color-x: #fff`）假装合规，未真正接入设计系统。
- 新增 token 不符合命名规范或未登记，造成 token 集合膨胀与重复。
- 替换时选错 token 语义（如用品牌色替代中性色），导致视觉与设计意图不符。
- 忽略动态/主题相关值，导致深色模式或主题切换失效。

## 注意事项

- 仅替换视觉字面量为 token，不改动组件行为或布局逻辑。
- 新增 token 必须在 token 源文件登记并符合命名规范。
- 第三方组件内联样式若无法替换，需显式记录并排除，不静默忽略。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

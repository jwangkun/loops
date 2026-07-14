---
name: "component-library-update"
description: "组件库新增变体并补充文档，Storybook 构建通过"
---

# 组件库更新

**分类:** 前端与UI
**标识符:** `component-library-update`
**最大迭代次数:** 8

## 目标

在组件库中新增或调整组件变体（variant），并同步更新对应的 story、props 文档与用法示例。最终 Storybook 静态构建必须零错误通过，且新增变体可被使用者查阅和复用。

## 适用场景

需要在设计系统/组件库中增加新形态的组件（如新的 size、state、主题变体）或补全缺失的变体文档时使用。

## 检查命令

```bash
npm run storybook:build
```

## 退出条件

- `npm run storybook:build` 退出码为 0。
- Storybook 控制台无 error，仅有可接受的警告。
- 新增变体已出现在对应 story 中并渲染正常。

## 执行步骤

Step 1: 运行 `npm run storybook:build`，完整捕获构建日志。
Step 2: 分析失败原因——常见为 story 文件缺失/导出错误、props 类型不匹配、MDX 文档语法错误、资源路径错误。逐条定位。
Step 3: 做最小修复：先实现组件变体的源码与 props，再补全 story（`args`/`argTypes`）与 MDX 文档，不要用 `// eslint-disable` 或注释掩盖构建错误。
Step 4: 重新运行检查命令；若仍失败且未达到最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未通过时停止，汇报剩余的构建错误清单，不要无限循环。

## 常见陷阱

- 只改组件源码却忘记同步 story 的 `args`/`argTypes`，导致文档面板为空或类型报错。
- 新变体依赖的 token/样式未导出，构建期不报错但运行时渲染异常——需在浏览器中肉眼确认。
- MDX 中使用了未导入的组件或错误的 frontmatter，触发 `storybook:build` 静默失败。
- 在 story 内硬编码本应来自 props 的值，使文档失去示例意义。

## 注意事项

- 保持组件 API 向后兼容；如必须引入破坏性变更，需同步更新所有使用点与变更日志。
- 不要为通过构建而删除已有的合法 story 或变体。
- 仅修改与目标变体相关的文件，避免大规模无关改动。

- 收敛保护：若同一检查以相同根因连续两次迭代失败，应更换思路或停止上报，而非机械地原样重试。
- 预算纪律：遵守宿主 harness 的 token / 成本 / 时间预算；预算耗尽视为「停止并上报」信号，而非重试信号。
- 终态明确：循环只能以「成功 / 受阻 / 耗尽」三种终态结束；停滞或预算耗尽绝不能被报告为成功。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

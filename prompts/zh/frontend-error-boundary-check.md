---
name: "frontend-error-boundary-check"
description: "每个路由均具备错误边界与 fallback UI"
---

# 前端错误边界检查

**分类:** 前端与UI
**标识符:** `frontend-error-boundary-check`
**最大迭代次数:** 8

## 目标

确保应用中每一个路由（含异步路由懒加载）都被错误边界（Error Boundary）覆盖，并具备用户可见的 fallback UI 与恢复机制。最终 lint 检查零违规，即用户在任意路由遇到渲染异常时不会看到整页白屏。

## 适用场景

在引入新路由、调整路由结构或新增可能抛错的异步组件后，用来确认错误边界覆盖无遗漏。

## 检查命令

```bash
npm run lint:error-boundaries
```

## 退出条件

- `npm run lint:error-boundaries` 退出码为 0。
- lint 报告显示所有路由均已覆盖错误边界。
- 新增/变更路由均有对应的 fallback UI 实现。

## 执行步骤

Step 1: 运行 `npm run lint:error-boundaries`，捕获 lint 输出，列出未覆盖路由清单。
Step 2: 分析缺口——区分根级错误边界与页面级错误边界；确认懒加载 chunk、Suspense 子树、表单等高风险区域是否有就近覆盖。
Step 3: 做最小修复：为缺失路由包裹错误边界组件，并实现 fallback UI（含错误提示与恢复/重试入口），不要用空 fallback 或 try/catch 吞掉错误。
Step 4: 重新运行检查命令；若仍有违规且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未通过时停止，汇报剩余未覆盖路由清单，不要无限循环。

## 常见陷阱

- 仅在应用根节点放一个错误边界，导致子路由报错时整棵子树卸载、丢失导航状态。
- fallback UI 为空或仅 `null`——技术上"覆盖"了但用户体验等同白屏。
- 对异步错误（如 `useEffect` 内 promise 拒绝）误以为错误边界能捕获；这类错误需额外处理。
- 用 `try/catch` 在组件体内吞掉异常以"绕过"lint，掩盖真实缺陷。

## 注意事项

- 错误边界应捕获渲染期异常并提供恢复路径（重试/返回首页/上报），而非静默降级。
- 不要为了让 lint 通过而移除路由或注释掉报错组件。
- 修改仅限错误边界与 fallback 相关代码，避免无关重构。

- 收敛保护：若同一检查以相同根因连续两次迭代失败，应更换思路或停止上报，而非机械地原样重试。
- 预算纪律：遵守宿主 harness 的 token / 成本 / 时间预算；预算耗尽视为「停止并上报」信号，而非重试信号。
- 终态明确：循环只能以「成功 / 受阻 / 耗尽」三种终态结束；停滞或预算耗尽绝不能被报告为成功。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

---
name: "bundle-size-budget"
description: "客户端bundle保持在预算内"
---

# Bundle 大小预算

**分类:** 性能
**标识符:** `bundle-size-budget`
**最大迭代次数:** 5

## 目标

将客户端构建产物控制在 `size-limit` 预算之内，保证首屏加载与运行时性能。成功意味着 `npm run build && npm run size-limit` 通过，且每条预算项（主包、异步 chunk、按路由/入口拆分）均在阈值内，而非仅主包达标。

## 适用场景

引入或升级大型依赖后、新增页面/特性导致产物膨胀时、或在 CI 中需要守住性能预算时使用。

## 检查命令

```bash
npm run build && npm run size-limit
```

## 退出条件

- `size-limit` 报告所有条目均通过（exit 0）。
- 无任何 chunk 超出其对应预算。
- 首屏关键 bundle 达标且未以牺牲可维护性为代价。

## 执行步骤

Step 1: 运行 `npm run build && npm run size-limit`，捕获超出的条目、超出字节数与所在 chunk。
Step 2: 定位膨胀来源：分析最大依赖（构建报告/source-map-explorer）、重复打包、未 tree-shake 的具名导入或过大的 polyfill。
Step 3: 采用最小且正确的修复：按路由懒加载、替换为更轻量的等价库、修正导入路径以启用 tree-shaking，或剔除无用 polyfill；避免一刀切懒加载一切。
Step 4: 重新运行构建与 `size-limit`；若仍超预算且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代次数仍未达标，停止并报告剩余超出项与建议（如是否需上调预算），不要无限循环。

## 常见陷阱

- 把所有页面全部改为懒加载换取"达标"，反而增加交互延迟，制造虚假胜利。
- 只看主包大小，忽略异步 chunk 或共用 chunk 的真实膨胀。
- 替换依赖时遗漏功能等价性，引入行为回归。
- 通过下调预算阈值来"通过"，掩盖了真实膨胀。

## 注意事项

- 优先修复根因（依赖大小、tree-shaking），而非逐项拆包掩盖。
- 任何依赖替换需在测试通过后再合并。
- 构建配置改动需与团队约定一致，不破坏既有 chunk 策略。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

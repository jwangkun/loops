---
name: "schema-migration-loop"
description: "Schema 变更已迁移且测试通过"
---

# Schema 迁移循环

**分类:** 数据库与数据
**标识符:** `schema-migration-loop`
**最大迭代次数:** 8

## 目标

完成一次数据库 schema 变更的全流程：更新 `schema.prisma`、生成并干净应用迁移、使 `npx prisma migrate dev && npm test` 整体退出码为 0。迁移与测试必须同时通过，缺一不可。

## 适用场景

在 schema 有结构性变更（新增表/列、改类型、加索引/约束、调关系）后，用来驱动"改 schema → 生成迁移 → 应用 → 跑测试 → 修问题"的闭环，直到迁移与测试双双绿灯。

## 检查命令

```bash
npx prisma migrate dev && npm test
```

## 退出条件

- `npx prisma migrate dev` 成功生成并应用迁移，无漂移、无报错。
- `npm test` 退出码为 0，全部测试通过。
- 生成的客户端已重新生成（prisma client up to date）。

## 执行步骤

Step 1: 运行 `npx prisma migrate dev && npm test`，分别捕获迁移输出与测试输出。
Step 2: 分析失败点——区分迁移生成失败（schema 语法/不可逆变更/数据丢失风险）、应用失败（类型不兼容/约束冲突）、以及测试失败（旧 fixture 不再匹配新 schema、查询字段变更）。
Step 3: 做最小修复：先修正 schema.prisma 与迁移 SQL，再同步受影响的 fixture/种子数据/查询代码；不要为了让测试通过而删除合法测试或放宽断言。
Step 4: 重新运行检查命令；若迁移或测试仍失败且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未通过时停止，分别汇报迁移与测试的剩余阻塞项，不要无限循环。

## 常见陷阱

- 先改迁移 SQL 再回头改 schema，导致两者不一致，后续 `migrate dev` 反复生成漂移。
- 不可逆/有数据丢失风险的变更（如删列、缩窄类型）未先评估就被迁移工具拦截，误以为是 bug 而强行绕过。
- 测试 fixture/种子数据未随 schema 同步更新，导致迁移通过但测试大面积红。
- 用 `db push` 临时绕过迁移以让测试通过，留下未被版本化的 schema 差异。

## 注意事项

- schema 与迁移必须保持双向一致；任何 schema 改动都应通过正式迁移落地。
- 切勿为通过测试而禁用约束检查或删除真实测试用例。
- 含破坏性变更时优先评估对现有数据与下游消费者的影响，必要时新增补丁迁移。
- 仅修改 schema、迁移、prisma client 及直接相关的测试/fixture，避免无关重构。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

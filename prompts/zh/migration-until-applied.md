---
name: "migration-until-applied"
description: "所有数据库迁移已干净应用"
---

# 迁移直至应用

**分类:** 依赖管理
**标识符:** `migration-until-applied`
**最大迭代次数:** 5

## 目标

使 `npx prisma migrate status` 报告所有迁移均已成功应用、无漂移（drift）、无待执行（pending）迁移。过程中如遇到 schema 或 SQL 错误，需修复迁移本身，而非绕过校验或手动改库。

## 适用场景

新增/修改迁移文件后，或在多环境间同步数据库状态时，用来确认迁移链已完整落到目标数据库。

## 检查命令

```bash
npx prisma migrate status
```

## 退出条件

- `npx prisma migrate status` 退出码为 0。
- 输出显示"Database schema is up to date"，无 pending 迁移。
- 无漂移告警（migration history 与文件系统一致）。

## 执行步骤

Step 1: 运行 `npx prisma migrate status`，捕获输出，识别 pending 迁移、漂移或失败记录。
Step 2: 分析问题——区分未应用、应用中途失败、迁移历史与文件不一致、schema 与 SQL 类型不兼容等情形。
Step 3: 做最小修复：用 `prisma migrate deploy` 应用 pending 迁移；对失败迁移修正 SQL/schema 后重试；不要手动编辑已应用迁移的 down/历史记录。
Step 4: 重新运行检查命令；若仍非干净状态且未达最大迭代次数，回到 Step 2。
Step 5: 达到最大迭代仍未通过时停止，汇报剩余的 pending/漂移/失败迁移清单，不要无限循环。

## 常见陷阱

- 手动编辑 `_prisma_migrations` 表或已应用迁移文件以"抹平"漂移，埋下环境间不一致隐患。
- 在生产环境误用 `migrate dev`（会重置数据）；生产应使用 `migrate deploy`。
- 迁移顺序错误：在依赖该列的迁移之前删除/重命名了该列。
- down 迁移与 up 迁移不对称，回滚后再次前向应用时残留脏状态。

## 注意事项

- 修复迁移失败应改迁移文件或新增补丁迁移，不得篡改迁移历史。
- 切勿在未备份的情况下对已有数据的数据库执行破坏性迁移。
- 仅处理迁移与 schema 文件，避免无关改动。

## 推荐代理

Claude Code、Cursor、Trae、Windsurf、Cline

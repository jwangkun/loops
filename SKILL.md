---
name: "loops"
description: "AI驱动的自动化循环集合。覆盖软件开发、数据科学、内容创作、产品运营、学习管理等领域。当用户需要自动化工作流、修复问题、生成内容、分析数据或执行质量检查时使用。"
version: "2.0.0"
author: "Loops Community"
license: "MIT"
tags: ["automation", "testing", "ci", "quality", "workflow", "ai-agents", "data-science", "content-creation", "productivity"]
supported_agents: ["Claude Code", "Cursor", "Trae", "Windsurf", "Cline"]
---

# Loops - AI驱动的自动化循环集合

Loops 是一种用于 AI 编程助手（如 Claude Code、Cursor、Trae、Windsurf、Cline）的自动化工作流指令集。它通过"执行→检查→修复→重复"的闭环模式，让 AI 能够自主完成各类任务，直到达到预设目标。

> 本 Skill 提供 100 个经过验证的 AI 自动化循环，覆盖软件开发、测试、CI/CD、代码质量、数据科学、内容创作、产品运营、学习管理、系统运维、安全合规等场景。

---

## 目录

1. [安装 Skill](#1-安装-skill)
2. [在 Agent 中使用](#2-在-agent-中使用)
3. [快速开始](#3-快速开始)
4. [Loop 使用语法](#4-loop-使用语法)
5. [完整 Loop 目录](#5-完整-loop-目录)
6. [场景速查表](#6-场景速查表)
7. [最佳实践](#7-最佳实践)
8. [故障排除](#8-故障排除)
9. [创建自己的 Loop](#9-创建自己的-loop)
10. [中国区用户须知](#10-中国区用户须知)

---

## 1. 安装 Skill

> **默认推荐全局安装**。先把 Loops 放到 `~/.loops`，这样所有项目、所有 Agent 都能引用。只有需要项目隔离时，才按项目安装。
>
> 不同 Agent 的全局安装方式不同，请按你使用的 Agent 选择对应小节。

### 1.1 Claude Code 安装（推荐，全局可用）

Claude Code 通过 `/load` 命令显式加载技能文件。只要 Loops 仓库在本地任意位置即可工作，推荐放在 `~/.loops`。

**全局安装**

```bash
# 1. 克隆 Loops 到全局位置
git clone https://github.com/jwangkun/loops.git ~/.loops

# 2. 启动 Claude Code
claude

# 3. 加载 Skill（每个新会话第一次使用时执行）
/load ~/.loops/SKILL.md

# 4. 使用任意 Loop
/loop test-until-green
```

**加载单个 Loop**

```bash
/load ~/.loops/prompts/zh/test-until-green.md
/loop test-until-green
```

> Claude Code 目前不支持启动时自动 `/load`，所以每个新会话第一次使用 Loop 前，请手动执行 `/load ~/.loops/SKILL.md`。

### 1.2 Trae IDE 安装（全局 Skill）

Trae 支持基于 `.trae/skills/` 目录结构自动识别 Skill。全局路径为 `~/.trae/skills/loops/`。

```bash
# 1. 确保 Loops 已在 ~/.loops
git clone https://github.com/jwangkun/loops.git ~/.loops

# 2. 复制到 Trae 全局 Skill 目录
mkdir -p ~/.trae/skills/loops
cp ~/.loops/SKILL.md ~/.trae/skills/loops/
cp -r ~/.loops/prompts ~/.trae/skills/loops/
```

安装后在 Trae 的 AI 对话框中输入：

```
/loop test-until-green
```

或：

```
@loops /loop test-until-green
```

> Trae 全局 Skill 的支持取决于版本。如果全局不生效，请改用下面的项目级安装。

### 1.3 Cursor 安装（全局 `.cursorrules`）

Cursor 通过 `.cursorrules` 文件集成。把它放到用户主目录，即可对所有项目生效。

```bash
# 创建全局 .cursorrules
cat > ~/.cursorrules << 'EOF'
# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析、学习管理等任务时，请先查看 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按照 Loop 的"执行→检查→修复→重复"模式执行任务。

常用 Loop：
- 测试失败：/loop test-until-green
- CI修复：/loop fix-ci-until-green
- 代码质量：/loop lint-typecheck-fix
- PR审查：/loop pr-self-review
- TDD开发：/loop autoloop-tdd
- 文档同步：/loop docs-sync-after-edits
- 博客优化：/loop blog-post-until-publish
- 数据清洗：/loop data-cleaning-loop
- 会议纪要：/loop meeting-notes-cleaner
EOF
```

> 请确保已经执行过 `git clone https://github.com/jwangkun/loops.git ~/.loops`，否则 `~/.loops/prompts/zh/` 路径不存在。

### 1.4 Windsurf / Cline 安装（项目级）

Windsurf 和 Cline 目前按项目加载知识库文件，需要在每个项目中复制一次：

```bash
# 先确保 Loops 在 ~/.loops
git clone https://github.com/jwangkun/loops.git ~/.loops

# Windsurf
mkdir -p .windsurf/knowledge
cp ~/.loops/SKILL.md .windsurf/knowledge/loops.md
cp ~/.loops/prompts/zh/*.md .windsurf/knowledge/

# Cline
mkdir -p .cline
cp ~/.loops/SKILL.md .cline/loops.md
cp ~/.loops/prompts/zh/*.md .cline/
```

### 1.5 项目级安装（可选）

如果你希望某个项目使用独立的 Loops 版本，可以按项目安装：

```bash
cd your-project
mkdir -p .trae/skills/loops
cp ~/.loops/SKILL.md .trae/skills/loops/
cp -r ~/.loops/prompts .trae/skills/loops/
```

> `.trae/` 是本地 IDE 配置，不应提交到版本控制。建议将 `.trae/` 加入项目 `.gitignore`。

### 1.6 通过 Git 子模块安装（可选）

```bash
cd your-project
git submodule add https://github.com/jwangkun/loops.git .trae/skills/loops
```

---

## 2. 在 Agent 中使用

### 2.1 Claude Code

Claude Code 需要先 `/load ~/.loops/SKILL.md` 加载 Skill（每个新会话一次），然后：

```bash
claude
/load ~/.loops/SKILL.md
/loop test-until-green
```

或加载后用自然语言：

```
执行测试循环，修复失败的测试
```

### 2.2 Trae

Trae 会自动识别 `~/.trae/skills/loops/` 中的 Skill。在 AI 对话框中输入：

```
/loop test-until-green
```

或：

```
@loops /loop test-until-green
```

也可以直接用中文：

```
帮我运行 /loop test-until-green，修复所有失败的测试
```

### 2.3 Cursor

Cursor 会读取全局 `~/.cursorrules` 中的 Loops 配置。在 Composer 或 Chat 中：

```
运行 test-until-green loop 修复当前测试
```

### 2.4 Windsurf / Cline

Windsurf 和 Cline 按项目加载知识库。复制 `~/.loops` 中的文件到项目目录后，在 Chat 中输入：

```
/loop test-until-green
```

### 2.5 通用调用格式

```
/loop <loop-name> [上下文参数]

示例：
/loop test-until-green
/loop fix-ci-until-green
/loop pr-self-review
/loop data-cleaning-loop
/loop blog-post-until-publish
```

---

## 3. 快速开始

### 3.1 一分钟上手

1. 将本 Skill 安装到你的项目（见[安装 Skill](#1-安装-skill)）
2. 打开你的 AI 编程助手
3. 输入任意 Loop 命令，例如：

```
/loop test-until-green
```

4. AI 会自动：
   - 运行检查命令
   - 找到失败或不足
   - 修复最小根因
   - 重新运行检查
   - 重复直到目标达成

### 3.2 推荐入门 Loop

| 你是新手？ | 先试试这个 |
|-----------|-----------|
| 想确保测试通过 | `test-until-green` |
| 想清理代码 | `lint-typecheck-fix` |
| 想格式化代码 | `format-until-clean` |
| 想检查PR质量 | `pr-self-review` |
| 想自动修CI | `fix-ci-until-green` |
| 想清洗数据 | `data-cleaning-loop` |
| 想优化博客 | `blog-post-until-publish` |
| 想整理会议纪要 | `meeting-notes-cleaner` |

---

## 4. Loop 使用语法

### 4.1 基本语法

```
/loop <loop-slug>
```

### 4.2 带上下文参数

某些 Loop 支持上下文参数（Agent 会自动识别）：

```
/loop flaky-test-triage --suite=auth.test.ts
/loop coverage-until-threshold --threshold=85
/loop npm-audit-fix-loop --level=high
/loop generate-unit-tests --file=utils.ts
/loop blog-post-until-publish --file=draft.md
```

> 具体参数由 Agent 根据 Loop 描述自动推断，你也可以在提示词中明确指定。

### 4.3 组合使用

Loop 可以串联使用：

```
先运行 /loop lint-typecheck-fix，然后运行 /loop test-until-green
```

---

## 5. 完整 Loop 目录

### 分类总览

| 分类 | 数量 | 分类 | 数量 |
|------|------|------|------|
| [测试](#测试-testing) | 7 | [代码生成与重构](#代码生成与重构-code-generation) | 8 |
| [CI/CD](#cicd) | 9 | [数据库与数据](#数据库与数据-database) | 5 |
| [代码质量](#代码质量-code-quality) | 4 | [前端与UI](#前端与ui-frontend) | 4 |
| [API/规范](#api规范-apispecs) | 2 | [后端与API开发](#后端与api开发-backend) | 4 |
| [依赖管理](#依赖管理-dependencies) | 4 | [数据科学与分析](#数据科学与分析-data-science) | 6 |
| [安全](#安全-security) | 1 | [内容创作与写作](#内容创作与写作-content-creation) | 7 |
| [开发流程](#开发流程-development-process) | 5 | [产品与设计](#产品与设计-product--design) | 4 |
| [文档](#文档-documentation) | 1 | [运营与市场](#运营与市场-operations--marketing) | 4 |
| [性能](#性能-performance) | 1 | [学习与知识管理](#学习与知识管理-learning--knowledge) | 5 |
| [无障碍](#无障碍-accessibility) | 1 | [效率与生产力](#效率与生产力-productivity) | 4 |
| [Pull Request](#pull-request) | 2 | [系统与DevOps](#系统与devops-system--devops) | 5 |
| [部署](#部署-deployment) | 1 | [安全与合规](#安全与合规-security--compliance) | 4 |
| [维护](#维护-maintenance) | 1 | | |
| [Git钩子](#git钩子-git-hooks) | 1 | | |

### 测试 (Testing)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `test-until-green` | 所有测试通过 | `npm test` | [zh](prompts/zh/test-until-green.md) · [en](prompts/en/test-until-green.md) |
| `e2e-until-green` | E2E测试套件通过 | `npm run test:e2e` | [zh](prompts/zh/e2e-until-green.md) · [en](prompts/en/e2e-until-green.md) |
| `flaky-test-triage` | 将失败测试分类为flaky或real | `npm test -- --testPathPattern=<failing-suite>` | [zh](prompts/zh/flaky-test-triage.md) · [en](prompts/en/flaky-test-triage.md) |
| `visual-regression-until-match` | 视觉回归测试通过 | `npx playwright test --grep @visual` | [zh](prompts/zh/visual-regression-until-match.md) · [en](prompts/en/visual-regression-until-match.md) |
| `coverage-until-threshold` | 覆盖率达标 | `npm test -- --coverage` | [zh](prompts/zh/coverage-until-threshold.md) · [en](prompts/en/coverage-until-threshold.md) |
| `staging-smoke-test` | 预发布环境冒烟测试通过 | `npm run smoke:staging` | [zh](prompts/zh/staging-smoke-test.md) · [en](prompts/en/staging-smoke-test.md) |
| `post-edit-test-guard` | 编辑后相关测试必须通过 | `npm test -- --findRelatedTests <files>` | [zh](prompts/zh/post-edit-test-guard.md) · [en](prompts/en/post-edit-test-guard.md) |

### CI/CD

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `ship-pr-until-green` | PR已打开且所有CI检查通过 | `gh pr checks` | [zh](prompts/zh/ship-pr-until-green.md) · [en](prompts/en/ship-pr-until-green.md) |
| `fix-ci-until-green` | 当前分支的最新CI运行通过 | `gh run list ...` | [zh](prompts/zh/fix-ci-until-green.md) · [en](prompts/en/fix-ci-until-green.md) |
| `ci-failure-watcher` | 当前分支的最新CI运行是绿色的 | `gh run list ...` | [zh](prompts/zh/ci-failure-watcher.md) · [en](prompts/en/ci-failure-watcher.md) |
| `build-until-green` | 生产构建成功 | `npm run build` | [zh](prompts/zh/build-until-green.md) · [en](prompts/en/build-until-green.md) |
| `pre-commit-guard` | 测试失败时阻止git提交 | `npm test` | [zh](prompts/zh/pre-commit-guard.md) · [en](prompts/en/pre-commit-guard.md) |
| `pr-self-review` | 当前diff上完成三轮干净的自我审查 | `git diff main...HEAD` | [zh](prompts/zh/pr-self-review.md) · [en](prompts/en/pr-self-review.md) |
| `pr-babysitter` | 标记为codex-watch的PR保持健康 | `gh pr list --label "codex-watch"` | [zh](prompts/zh/pr-babysitter.md) · [en](prompts/en/pr-babysitter.md) |
| `pr-watch-loop` | codex-watch PR保持健康且无阻碍 | `gh pr list --label codex-watch ...` | [zh](prompts/zh/pr-watch-loop.md) · [en](prompts/en/pr-watch-loop.md) |
| `spec-first-ship` | spec.md中的每个需求都已实现并打勾 | `npm test` | [zh](prompts/zh/spec-first-ship.md) · [en](prompts/en/spec-first-ship.md) |

### 代码质量 (Code Quality)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `lint-typecheck-fix` | lint和typecheck干净 | `npm run lint && npx tsc --noEmit` | [zh](prompts/zh/lint-typecheck-fix.md) · [en](prompts/en/lint-typecheck-fix.md) |
| `format-until-clean` | 格式化工具运行干净 | `npm run format` | [zh](prompts/zh/format-until-clean.md) · [en](prompts/en/format-until-clean.md) |
| `de-sloppify-pass` | 最近的变更干净、最小化 | `npm run lint && npm test` | [zh](prompts/zh/de-sloppify-pass.md) · [en](prompts/en/de-sloppify-pass.md) |
| `knip-until-clean` | knip报告没有未使用代码或依赖 | `npx knip` | [zh](prompts/zh/knip-until-clean.md) · [en](prompts/en/knip-until-clean.md) |

### API/规范

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `api-contract-until-match` | API实现与发布的契约匹配 | `npm run test:contract` | [zh](prompts/zh/api-contract-until-match.md) · [en](prompts/en/api-contract-until-match.md) |
| `openapi-sync-until-valid` | openapi.yaml lint干净且与实现的路由匹配 | `npx @redocly/cli lint openapi.yaml` | [zh](prompts/zh/openapi-sync-until-valid.md) · [en](prompts/en/openapi-sync-until-valid.md) |

### 依赖管理

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `dependency-upgrade-one-by-one` | 关键过时依赖升级且测试绿色 | `npm outdated && npm test && npm run build` | [zh](prompts/zh/dependency-upgrade-one-by-one.md) · [en](prompts/en/dependency-upgrade-one-by-one.md) |
| `migration-until-applied` | 所有数据库迁移应用干净 | `npx prisma migrate status` | [zh](prompts/zh/migration-until-applied.md) · [en](prompts/en/migration-until-applied.md) |
| `dependency-audit-weekly` | 交付每周依赖审计摘要 | `npm outdated || true` | [zh](prompts/zh/dependency-audit-weekly.md) · [en](prompts/en/dependency-audit-weekly.md) |
| `npm-audit-fix-loop` | 没有高危或严重npm审计漏洞 | `npm audit --audit-level=high && npm test` | [zh](prompts/zh/npm-audit-fix-loop.md) · [en](prompts/en/npm-audit-fix-loop.md) |

### 安全 (Security)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `security-audit-weekly` | 交付每周npm审计摘要和修复计划 | `npm audit --json` | [zh](prompts/zh/security-audit-weekly.md) · [en](prompts/en/security-audit-weekly.md) |

### 开发流程 (Development Process)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `autoloop-tdd` | 测试优先地实现目标行为 | `npm test` | [zh](prompts/zh/autoloop-tdd.md) · [en](prompts/en/autoloop-tdd.md) |
| `changelog-sync-after-ship` | CHANGELOG.md有准确的[Unreleased]条目 | `git log -5 --oneline` | [zh](prompts/zh/changelog-sync-after-ship.md) · [en](prompts/en/changelog-sync-after-ship.md) |
| `investigation-script-loop` | 用最小复现脚本证明根因 | `node scripts/investigate.mjs` | [zh](prompts/zh/investigation-script-loop.md) · [en](prompts/en/investigation-script-loop.md) |
| `ralph-story-executor` | 每个story都有passes: true | `npm test && npm run lint && npm run build` | [zh](prompts/zh/ralph-story-executor.md) · [en](prompts/en/ralph-story-executor.md) |
| `reflexion-debug-loop` | 失败的测试或复现通过 | `npm test -- --testNamePattern=<test>` | [zh](prompts/zh/reflexion-debug-loop.md) · [en](prompts/en/reflexion-debug-loop.md) |

### 文档 (Documentation)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `docs-sync-after-edits` | 文档与当前代码变更匹配 | `git diff main...HEAD --name-only` | [zh](prompts/zh/docs-sync-after-edits.md) · [en](prompts/en/docs-sync-after-edits.md) |

### 性能 (Performance)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `bundle-size-budget` | 客户端bundle保持在预算内 | `npm run build && npm run size-limit` | [zh](prompts/zh/bundle-size-budget.md) · [en](prompts/en/bundle-size-budget.md) |

### 无障碍 (Accessibility)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `a11y-audit-until-clean` | 变更的UI上没有严重的无障碍访问违规 | `npm run test:a11y` | [zh](prompts/zh/a11y-audit-until-clean.md) · [en](prompts/en/a11y-audit-until-clean.md) |

### Pull Request

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `merge-conflict-resolver` | 分支在main上rebase成功且测试通过 | `npm test` | [zh](prompts/zh/merge-conflict-resolver.md) · [en](prompts/en/merge-conflict-resolver.md) |
| `post-merge-regression-guard` | 每次合并或rebase后冒烟测试立即通过 | `npm run test:smoke` | [zh](prompts/zh/post-merge-regression-guard.md) · [en](prompts/en/post-merge-regression-guard.md) |

### 部署 (Deployment)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `deploy-verification-loop` | 所有部署后健康和冒烟端点返回成功 | `curl -fsS <your-health-url>` | [zh](prompts/zh/deploy-verification-loop.md) · [en](prompts/en/deploy-verification-loop.md) |

### 维护 (Maintenance)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `independent-verifier-pass` | 构建、lint和测试在独立验证下通过 | `npm run build && npm run lint && npm test` | [zh](prompts/zh/independent-verifier-pass.md) · [en](prompts/en/independent-verifier-pass.md) |

### Git钩子

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `guardrails-learning-loop` | 测试和lint通过且不重复之前的失败模式 | `npm test && npm run lint` | [zh](prompts/zh/guardrails-learning-loop.md) · [en](prompts/en/guardrails-learning-loop.md) |

### 代码生成与重构 (Code Generation)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `code-review-until-clean` | 代码通过结构化审查清单 | `python scripts/review_checklist.py` | [zh](prompts/zh/code-review-until-clean.md) · [en](prompts/en/code-review-until-clean.md) |
| `refactor-until-clean` | 目标模块达到整洁代码标准 | `npm run lint && npm test` | [zh](prompts/zh/refactor-until-clean.md) · [en](prompts/en/refactor-until-clean.md) |
| `generate-unit-tests` | 目标函数对边界条件有通过的单元测试 | `npm test -- <target-file>` | [zh](prompts/zh/generate-unit-tests.md) · [en](prompts/en/generate-unit-tests.md) |
| `component-scaffold-loop` | 新UI组件已生成测试和stories | `npm test -- <component-name>` | [zh](prompts/zh/component-scaffold-loop.md) · [en](prompts/en/component-scaffold-loop.md) |
| `api-endpoint-generator` | 新API端点已实现handler、路由和测试 | `npm run test:api` | [zh](prompts/zh/api-endpoint-generator.md) · [en](prompts/en/api-endpoint-generator.md) |
| `error-handling-audit` | 所有公共函数有一致的错误处理 | `npm run lint && npm test` | [zh](prompts/zh/error-handling-audit.md) · [en](prompts/en/error-handling-audit.md) |
| `type-definition-sync` | TypeScript类型与运行时API和数据库schema匹配 | `npx tsc --noEmit` | [zh](prompts/zh/type-definition-sync.md) · [en](prompts/en/type-definition-sync.md) |
| `dead-code-removal` | 无未使用的导出、变量或函数残留 | `npx knip --no-exit-code && npm test` | [zh](prompts/zh/dead-code-removal.md) · [en](prompts/en/dead-code-removal.md) |

### 数据库与数据 (Database)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `schema-migration-loop` | 数据库schema变更已迁移且测试通过 | `npx prisma migrate dev && npm test` | [zh](prompts/zh/schema-migration-loop.md) · [en](prompts/en/schema-migration-loop.md) |
| `query-performance-loop` | 慢查询优化到阈值以下 | `npm run benchmark:queries` | [zh](prompts/zh/query-performance-loop.md) · [en](prompts/en/query-performance-loop.md) |
| `seed-data-validator` | 种子数据干净加载且引用有效 | `npm run db:seed && npm run test:seed` | [zh](prompts/zh/seed-data-validator.md) · [en](prompts/en/seed-data-validator.md) |
| `backup-verify-loop` | 最新数据库备份成功恢复 | `npm run db:backup:verify` | [zh](prompts/zh/backup-verify-loop.md) · [en](prompts/en/backup-verify-loop.md) |
| `data-consistency-check` | 无孤立记录或约束违规 | `npm run db:consistency` | [zh](prompts/zh/data-consistency-check.md) · [en](prompts/en/data-consistency-check.md) |

### 前端与UI (Frontend)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `responsive-until-match` | UI在所有目标断点正确渲染 | `npx playwright test --grep @responsive` | [zh](prompts/zh/responsive-until-match.md) · [en](prompts/en/responsive-until-match.md) |
| `design-token-sync` | 所有UI使用批准的设计token | `npm run lint:design-tokens` | [zh](prompts/zh/design-token-sync.md) · [en](prompts/en/design-token-sync.md) |
| `component-library-update` | 组件库已更新新变体和文档 | `npm run storybook:build` | [zh](prompts/zh/component-library-update.md) · [en](prompts/en/component-library-update.md) |
| `frontend-error-boundary-check` | 所有路由都有错误边界和fallback UI | `npm run lint:error-boundaries` | [zh](prompts/zh/frontend-error-boundary-check.md) · [en](prompts/en/frontend-error-boundary-check.md) |

### 后端与API开发 (Backend)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `rate-limit-enforcer` | 所有公共端点都实施限流 | `npm run test:rate-limit` | [zh](prompts/zh/rate-limit-enforcer.md) · [en](prompts/en/rate-limit-enforcer.md) |
| `authz-policy-loop` | 所有敏感端点都实施授权 | `npm run test:authz` | [zh](prompts/zh/authz-policy-loop.md) · [en](prompts/en/authz-policy-loop.md) |
| `api-validation-loop` | 所有API输入已验证和清理 | `npm run test:api-validation` | [zh](prompts/zh/api-validation-loop.md) · [en](prompts/en/api-validation-loop.md) |
| `logging-audit-loop` | 所有关键路径产生结构化日志 | `npm run lint:logging` | [zh](prompts/zh/logging-audit-loop.md) · [en](prompts/en/logging-audit-loop.md) |

### 数据科学与分析 (Data Science)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `data-cleaning-loop` | 数据集通过质量检查 | `python scripts/data_quality.py` | [zh](prompts/zh/data-cleaning-loop.md) · [en](prompts/en/data-cleaning-loop.md) |
| `model-training-loop` | 模型在验证集上达到目标准确率 | `python scripts/train.py --validate` | [zh](prompts/zh/model-training-loop.md) · [en](prompts/en/model-training-loop.md) |
| `feature-engineering-loop` | 特征集提升模型性能 | `python scripts/evaluate_features.py` | [zh](prompts/zh/feature-engineering-loop.md) · [en](prompts/en/feature-engineering-loop.md) |
| `data-pipeline-until-green` | 数据管道端到端无错误运行 | `python scripts/run_pipeline.py` | [zh](prompts/zh/data-pipeline-until-green.md) · [en](prompts/en/data-pipeline-until-green.md) |
| `experiment-tracker` | 实验结果已记录且可复现 | `python scripts/check_experiments.py` | [zh](prompts/zh/experiment-tracker.md) · [en](prompts/en/experiment-tracker.md) |
| `dashboard-sync-loop` | 仪表盘反映最新数据和指标 | `python scripts/refresh_dashboard.py` | [zh](prompts/zh/dashboard-sync-loop.md) · [en](prompts/en/dashboard-sync-loop.md) |

### 内容创作与写作 (Content Creation)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `blog-post-until-publish` | 博客文章已润色并准备发布 | `python scripts/blog_quality.py draft.md` | [zh](prompts/zh/blog-post-until-publish.md) · [en](prompts/en/blog-post-until-publish.md) |
| `readme-improvement-loop` | README清晰、完整并遵循最佳实践 | `python scripts/readme_lint.py` | [zh](prompts/zh/readme-improvement-loop.md) · [en](prompts/en/readme-improvement-loop.md) |
| `social-post-generator` | 为每个平台生成社交媒体帖子 | `python scripts/check_posts.py` | [zh](prompts/zh/social-post-generator.md) · [en](prompts/en/social-post-generator.md) |
| `newsletter-until-send` | Newsletter通过审查且链接有效 | `python scripts/newsletter_check.py` | [zh](prompts/zh/newsletter-until-send.md) · [en](prompts/en/newsletter-until-send.md) |
| `video-script-loop` | 视频脚本达到目标时长和清晰度 | `python scripts/script_review.py` | [zh](prompts/zh/video-script-loop.md) · [en](prompts/en/video-script-loop.md) |
| `translation-review-loop` | 翻译准确自然 | `python scripts/translation_check.py` | [zh](prompts/zh/translation-review-loop.md) · [en](prompts/en/translation-review-loop.md) |
| `ad-copy-optimizer` | 广告文案变体通过转化检查清单 | `python scripts/ad_copy_check.py` | [zh](prompts/zh/ad-copy-optimizer.md) · [en](prompts/en/ad-copy-optimizer.md) |

### 产品与设计 (Product & Design)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `prd-review-loop` | PRD完整、清晰并准备开发 | `python scripts/prd_check.py` | [zh](prompts/zh/prd-review-loop.md) · [en](prompts/en/prd-review-loop.md) |
| `user-story-generator` | 为每个功能生成用户故事 | `python scripts/story_check.py` | [zh](prompts/zh/user-story-generator.md) · [en](prompts/en/user-story-generator.md) |
| `design-review-loop` | 设计遵循系统规范和无障碍规则 | `python scripts/design_check.py` | [zh](prompts/zh/design-review-loop.md) · [en](prompts/en/design-review-loop.md) |
| `competitive-analysis-loop` | 竞品分析报告完整且有来源 | `python scripts/competitor_check.py` | [zh](prompts/zh/competitive-analysis-loop.md) · [en](prompts/en/competitive-analysis-loop.md) |

### 运营与市场 (Operations & Marketing)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `seo-audit-loop` | 页面通过SEO检查清单 | `python scripts/seo_check.py` | [zh](prompts/zh/seo-audit-loop.md) · [en](prompts/en/seo-audit-loop.md) |
| `email-campaign-loop` | 邮件营销活动已审查且链接有效 | `python scripts/email_check.py` | [zh](prompts/zh/email-campaign-loop.md) · [en](prompts/en/email-campaign-loop.md) |
| `analytics-health-check` | 所有关键事件正确追踪 | `python scripts/analytics_check.py` | [zh](prompts/zh/analytics-health-check.md) · [en](prompts/en/analytics-health-check.md) |
| `release-notes-generator` | 发布说明已生成并审查 | `python scripts/release_notes_check.py` | [zh](prompts/zh/release-notes-generator.md) · [en](prompts/en/release-notes-generator.md) |

### 学习与知识管理 (Learning & Knowledge)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `flashcard-generator` | 为关键概念生成闪卡 | `python scripts/flashcard_check.py` | [zh](prompts/zh/flashcard-generator.md) · [en](prompts/en/flashcard-generator.md) |
| `study-plan-optimizer` | 学习计划现实并覆盖所有主题 | `python scripts/study_plan_check.py` | [zh](prompts/zh/study-plan-optimizer.md) · [en](prompts/en/study-plan-optimizer.md) |
| `note-organizer` | 笔记已打标签、链接并结构良好 | `python scripts/note_check.py` | [zh](prompts/zh/note-organizer.md) · [en](prompts/en/note-organizer.md) |
| `research-synthesis-loop` | 研究已总结来源和关键洞察 | `python scripts/research_check.py` | [zh](prompts/zh/research-synthesis-loop.md) · [en](prompts/en/research-synthesis-loop.md) |
| `quiz-validator` | 测验问题准确且有正确答案 | `python scripts/quiz_check.py` | [zh](prompts/zh/quiz-validator.md) · [en](prompts/en/quiz-validator.md) |

### 效率与生产力 (Productivity)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `meeting-notes-cleaner` | 会议纪要结构化并含行动项 | `python scripts/meeting_check.py` | [zh](prompts/zh/meeting-notes-cleaner.md) · [en](prompts/en/meeting-notes-cleaner.md) |
| `inbox-zero-loop` | 收件箱无未读可执行邮件 | `python scripts/inbox_check.py` | [zh](prompts/zh/inbox-zero-loop.md) · [en](prompts/en/inbox-zero-loop.md) |
| `task-prioritizer` | 任务按影响力和工作量排序 | `python scripts/task_check.py` | [zh](prompts/zh/task-prioritizer.md) · [en](prompts/en/task-prioritizer.md) |
| `weekly-review-loop` | 每周回顾报告完成 | `python scripts/weekly_review_check.py` | [zh](prompts/zh/weekly-review-loop.md) · [en](prompts/en/weekly-review-loop.md) |

### 系统与 DevOps (System & DevOps)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `docker-build-until-green` | Docker镜像构建并通过健康检查 | `docker build -t app . && docker run --rm app healthcheck` | [zh](prompts/zh/docker-build-until-green.md) · [en](prompts/en/docker-build-until-green.md) |
| `terraform-plan-until-clean` | terraform plan无意外变更 | `terraform plan -detailed-exitcode` | [zh](prompts/zh/terraform-plan-until-clean.md) · [en](prompts/en/terraform-plan-until-clean.md) |
| `log-anomaly-detector` | 近期日志无严重异常 | `python scripts/log_anomaly.py` | [zh](prompts/zh/log-anomaly-detector.md) · [en](prompts/en/log-anomaly-detector.md) |
| `ssl-certificate-monitor` | 所有域名都有有效SSL证书 | `python scripts/ssl_check.py` | [zh](prompts/zh/ssl-certificate-monitor.md) · [en](prompts/en/ssl-certificate-monitor.md) |
| `backup-routine-loop` | 所有关键数据已备份并验证 | `python scripts/backup_check.py` | [zh](prompts/zh/backup-routine-loop.md) · [en](prompts/en/backup-routine-loop.md) |

### 安全与合规 (Security & Compliance)

| Loop | 目标 | 检查命令 | 提示词 |
|------|------|----------|--------|
| `secret-scan-loop` | 仓库中无密钥或凭证 | `npx secretlint --maskSecrets "**/*"` | [zh](prompts/zh/secret-scan-loop.md) · [en](prompts/en/secret-scan-loop.md) |
| `compliance-checklist-loop` | 所有合规检查项已满足 | `python scripts/compliance_check.py` | [zh](prompts/zh/compliance-checklist-loop.md) · [en](prompts/en/compliance-checklist-loop.md) |
| `privacy-policy-audit` | 隐私政策与当前数据实践匹配 | `python scripts/privacy_check.py` | [zh](prompts/zh/privacy-policy-audit.md) · [en](prompts/en/privacy-policy-audit.md) |
| `access-review-loop` | 所有用户访问权限都有正当理由 | `python scripts/access_review.py` | [zh](prompts/zh/access-review-loop.md) · [en](prompts/en/access-review-loop.md) |

---

## 6. 场景速查表

### 软件开发

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 让测试全绿 | `test-until-green` | `/loop test-until-green` |
| 修CI失败 | `fix-ci-until-green` | `/loop fix-ci-until-green` |
| 自动lint修复 | `lint-typecheck-fix` | `/loop lint-typecheck-fix` |
| 自动格式化 | `format-until-clean` | `/loop format-until-clean` |
| 审查自己的PR | `pr-self-review` | `/loop pr-self-review` |
| 升级依赖 | `dependency-upgrade-one-by-one` | `/loop dependency-upgrade-one-by-one` |
| 修安全漏洞 | `npm-audit-fix-loop` | `/loop npm-audit-fix-loop` |
| TDD开发 | `autoloop-tdd` | `/loop autoloop-tdd` |
| 更新文档 | `docs-sync-after-edits` | `/loop docs-sync-after-edits` |
| 合并冲突 | `merge-conflict-resolver` | `/loop merge-conflict-resolver` |
| 部署验证 | `deploy-verification-loop` | `/loop deploy-verification-loop` |
| 优化性能 | `bundle-size-budget` | `/loop bundle-size-budget` |
| 代码重构 | `refactor-until-clean` | `/loop refactor-until-clean` |
| 生成单元测试 | `generate-unit-tests` | `/loop generate-unit-tests` |
| 错误处理审计 | `error-handling-audit` | `/loop error-handling-audit` |

### 数据与AI

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 清洗数据集 | `data-cleaning-loop` | `/loop data-cleaning-loop` |
| 训练模型 | `model-training-loop` | `/loop model-training-loop` |
| 特征工程 | `feature-engineering-loop` | `/loop feature-engineering-loop` |
| 运行数据管道 | `data-pipeline-until-green` | `/loop data-pipeline-until-green` |
| 追踪实验 | `experiment-tracker` | `/loop experiment-tracker` |
| 刷新仪表盘 | `dashboard-sync-loop` | `/loop dashboard-sync-loop` |
| 数据库迁移 | `schema-migration-loop` | `/loop schema-migration-loop` |
| 优化慢查询 | `query-performance-loop` | `/loop query-performance-loop` |

### 内容创作

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 优化博客文章 | `blog-post-until-publish` | `/loop blog-post-until-publish` |
| 改进README | `readme-improvement-loop` | `/loop readme-improvement-loop` |
| 生成社媒帖子 | `social-post-generator` | `/loop social-post-generator` |
| 准备Newsletter | `newsletter-until-send` | `/loop newsletter-until-send` |
| 优化视频脚本 | `video-script-loop` | `/loop video-script-loop` |
| 审校翻译 | `translation-review-loop` | `/loop translation-review-loop` |
| 优化广告文案 | `ad-copy-optimizer` | `/loop ad-copy-optimizer` |

### 产品与运营

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 审查PRD | `prd-review-loop` | `/loop prd-review-loop` |
| 生成用户故事 | `user-story-generator` | `/loop user-story-generator` |
| 设计审查 | `design-review-loop` | `/loop design-review-loop` |
| 竞品分析 | `competitive-analysis-loop` | `/loop competitive-analysis-loop` |
| SEO审计 | `seo-audit-loop` | `/loop seo-audit-loop` |
| 邮件营销检查 | `email-campaign-loop` | `/loop email-campaign-loop` |
| 发布说明 | `release-notes-generator` | `/loop release-notes-generator` |

### 学习与效率

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 生成学习闪卡 | `flashcard-generator` | `/loop flashcard-generator` |
| 优化学习计划 | `study-plan-optimizer` | `/loop study-plan-optimizer` |
| 整理笔记 | `note-organizer` | `/loop note-organizer` |
| 综合研究 | `research-synthesis-loop` | `/loop research-synthesis-loop` |
| 整理会议纪要 | `meeting-notes-cleaner` | `/loop meeting-notes-cleaner` |
| 收件箱清零 | `inbox-zero-loop` | `/loop inbox-zero-loop` |
| 任务优先级 | `task-prioritizer` | `/loop task-prioritizer` |
| 每周回顾 | `weekly-review-loop` | `/loop weekly-review-loop` |

### 系统与安全

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 构建Docker镜像 | `docker-build-until-green` | `/loop docker-build-until-green` |
| 检查Terraform | `terraform-plan-until-clean` | `/loop terraform-plan-until-clean` |
| 检测日志异常 | `log-anomaly-detector` | `/loop log-anomaly-detector` |
| 监控SSL证书 | `ssl-certificate-monitor` | `/loop ssl-certificate-monitor` |
| 扫描密钥泄露 | `secret-scan-loop` | `/loop secret-scan-loop` |
| 合规检查 | `compliance-checklist-loop` | `/loop compliance-checklist-loop` |
| 审查访问权限 | `access-review-loop` | `/loop access-review-loop` |

---

## 7. 最佳实践

### 7.1 使用 Loop 前的准备

1. **确保仓库干净**：运行 Loop 前最好提交当前工作，避免意外覆盖
2. **检查环境依赖**：确保检查命令所需的工具已安装
3. **设置合理的最大迭代次数**：避免无限循环
4. **备份重要数据**：内容创作、数据处理类 Loop 建议先备份原文件

### 7.2 Loop 执行原则

- **最小 diff 原则**：每次只修复最小根因
- **不要跳过检查**：每次修改后必须运行检查命令
- **保留证据**：重要的 Loop 运行结果建议截图或保存日志
- **人工兜底**：达到最大迭代次数仍未成功时，需要人工介入

### 7.3 安全建议

- 在运行 `npm-audit-fix-loop`、`dependency-upgrade-one-by-one` 等 Loop 前，先备份 `package-lock.json`
- `fix-ci-until-green`、`ship-pr-until-green` 等会修改远程仓库的 Loop，请在确定后再使用
- 涉及生产部署的 Loop（如 `deploy-verification-loop`）请在监控下运行
- 涉及密钥扫描、权限审查的 Loop 需审计后再执行
- 内容创作类 Loop 可能生成大量内容，建议先在小范围测试

### 7.4 与 Git 工作流结合

```bash
# 1. 创建新分支
git checkout -b feature/new-stuff

# 2. 让AI用Loop实现功能
/loop autoloop-tdd

# 3. 用Loop自我审查
/loop pr-self-review

# 4. 提交并推送
git commit -am "feat: add new stuff"
git push origin feature/new-stuff

# 5. 确保CI通过
/loop fix-ci-until-green
```

---

## 8. 故障排除

### 8.1 Agent 不识别 Loop 命令

**现象**：输入 `/loop test-until-green` 后 Agent 没有按 Loop 执行。

**解决**：
1. 确认 Skill 已正确安装到项目目录
2. 尝试使用完整路径加载：`/load ~/.loops/SKILL.md`
3. 用自然语言描述意图，例如："请按照 test-until-green 的模式运行测试并修复"

### 8.2 检查命令不存在

**现象**：Loop 运行时报 `command not found`。

**解决**：
1. 检查项目 `package.json` 中是否有对应的 scripts
2. 安装缺失的依赖或工具
3. 修改 Loop 提示词中的检查命令以匹配你的项目

### 8.3 Loop 陷入无限循环

**现象**：同一个错误反复出现，无法修复。

**解决**：
1. 检查是否达到最大迭代次数限制
2. 查看 `reflexion-debug-loop` 的失败记录
3. 人工介入，可能是需要重构或更深层次的问题

### 8.4 网络问题（中国区）

**现象**：`npm audit`、`gh`、Docker pull 等命令连接超时。

**解决**：见[中国区用户须知](#10-中国区用户须知)。

---

## 9. 创建自己的 Loop

### 9.1 Loop 文件模板

复制 `prompts/zh/test-until-green.md` 并修改：

```markdown
---
name: "my-custom-loop"
description: "你的Loop目标"
---

# 你的Loop标题

**分类:** 自定义  
**标识符:** `my-custom-loop`  
**最大迭代次数:** 5

## 目标

描述Loop要达成的最终状态

## 检查命令

```bash
npm run your-check-command
```

## 退出条件

检查命令返回成功

## 执行步骤

Step 1: 运行检查命令。
Step 2: 如果失败，修复最小根因。
Step 3: 重复直到退出条件满足。

## 推荐代理

Claude Code、Cursor、Trae
```

### 9.2 创建 Loop 的原则

1. **目标清晰**：Loop 必须有一个可验证的目标
2. **检查命令明确**：必须有一个命令能判断是否达成目标
3. **可迭代修复**：每次失败后都能进行小步修复
4. **有退出条件**：避免无限循环
5. **保持最小化**：每个 Loop 只负责一个职责

### 9.3 贡献 Loop

如果你想贡献新的 Loop：

1. 在 `prompts/zh/` 和 `prompts/en/` 中各添加一个 Markdown 文件
2. 文件名使用小写连字符格式，例如 `my-new-loop.md`
3. 更新 `SKILL.md` 和 `README.md` 中的 Loop 目录
4. 提交 Pull Request

---

## 10. 中国区用户须知

### 10.1 网络加速

由于部分工具链依赖 GitHub / npm / Docker 官方源，建议配置镜像：

```bash
# npm 切换到淘宝镜像
npm config set registry https://registry.npmmirror.com

# 或使用 nvm 时
npm config set registry https://registry.npmmirror.com --global

# pip 使用清华镜像
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Docker 使用阿里云镜像（需配置 daemon.json）
```

### 10.2 常用命令替换

| 原命令 | 中国区替代 |
|--------|-----------|
| `npm install` | `npm install --registry=https://registry.npmmirror.com` |
| `npx playwright install` | 手动下载或使用镜像 |
| `gh` | 可替换为 `hub` 或直接访问 GitHub Web |
| `pip install` | `pip install -i https://pypi.tuna.tsinghua.edu.cn/simple` |
| `docker pull` | 配置阿里云/网易云镜像加速 |

### 10.3 安装 Skill 的中国区方式

```bash
# 如果 GitHub 访问慢，可以使用 Gitee 镜像
git clone https://gitee.com/jwangkun/loops.git

# 或者先下载 zip 包解压
curl -L -o loops.zip https://github.com/jwangkun/loops/archive/refs/heads/main.zip
unzip loops.zip
```

### 10.4 获取帮助

- 中文文档：[README.md](./README.md)
- 英文文档：[README_EN.md](./README_EN.md)
- 官方 Loops 站点：https://loops.elorm.xyz/loops
- SkillHub：https://www.skillhub.club/
- SkillsMP：https://skillsmp.com/

---

**许可证:** MIT  
**版本:** 2.0.0  
**维护:** Loops Community


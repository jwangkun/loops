# Loops - AI驱动的自动化循环集合

> 100个精心策划的AI驱动自动化循环，覆盖软件开发、数据科学、内容创作、产品运营、学习管理等多个领域。面向中国用户优化，全中文文档与提示词支持。

[English README](README_EN.md)

---

## 目录

1. [什么是 Loop？](#1-什么是-loop)
2. [什么时候用 Loop？](#2-什么时候用-loop)
3. [一分钟快速开始](#3-一分钟快速开始)
4. [安装 Skill](#4-安装-skill)
5. [在各 Agent 中使用](#5-在各-agent-中使用)
6. [Loop 完整目录](#6-loop-完整目录)
7. [场景速查表](#7-场景速查表)
8. [创建自己的 Loop](#8-创建自己的-loop)
9. [最佳实践](#9-最佳实践)
10. [中国区用户指南](#10-中国区用户指南)
11. [常见问题](#11-常见问题)

---

## 1. 什么是 Loop？

**Loop（循环）** 是一种用于 AI 编程助手（如 Claude Code、Cursor、Trae、Windsurf、Cline）的自动化工作流指令集。它通过"执行→检查→修复→重复"的闭环模式，让 AI 能够自主完成任务，直到达到预设目标。

### Loop 的核心概念

| 概念 | 说明 |
|------|------|
| **目标 (Goal)** | Loop 要达成的最终状态 |
| **检查命令 (Check)** | 验证目标是否达成的命令 |
| **最大迭代次数** | Loop 最多执行多少轮 |
| **退出条件** | 何时停止（通常指检查命令返回成功） |
| **执行步骤** | 每一轮的具体操作 |

### Loop vs 传统指令

| 传统指令 | Loop |
|----------|------|
| "修复所有 lint 错误" | 执行 lint → 修复最小 diff → 再次执行 → 直到 lint 干净 |
| "修复 CI" | 检查 CI 状态 → 读取日志 → 本地复现 → 修复 → 推送 → 验证 |
| "优化一篇博客" | 检查质量 → 修改一个问题 → 再次检查 → 直到达标 |
| 一次性任务 | **闭环自动化** |

### Loop 的运作流程

```
开始
  │
  ▼
运行检查命令
  │
  ├─ 通过 ──► 结束
  │
  └─ 失败 ──► 分析失败原因
                  │
                  ▼
            修复最小根因
                  │
                  ▼
            迭代次数 +1
                  │
                  ▼
            是否超过最大迭代次数？
                  │
            是 ──► 结束，提示人工介入
            否 ──► 回到运行检查命令
```

---

## 2. 什么时候用 Loop？

当你需要：
- **持续迭代** - 需要反复检查、修复、再检查的任务
- **质量把关** - 保持代码、文档、数据处于健康状态
- **自动化工作流** - 减少重复性的人工操作
- **CI/CD 集成** - 自动化修复失败的 CI 构建
- **TDD 开发** - 测试驱动开发，先写测试再实现
- **内容优化** - 反复打磨文案、博客、脚本
- **数据处理** - 清洗数据、训练模型、生成报告

### 适合使用 Loop 的场景

| 场景 | 示例 Loop |
|------|----------|
| 刚写完代码，想让测试全绿 | `test-until-green` |
| CI 红了，不知道怎么修 | `fix-ci-until-green` |
| 提交前想确保质量 | `pre-commit-guard` |
| 要升级依赖 | `dependency-upgrade-one-by-one` |
| 要审查自己的 PR | `pr-self-review` |
| 文档和代码不同步 | `docs-sync-after-edits` |
| 要优化博客文章 | `blog-post-until-publish` |
| 要清洗数据集 | `data-cleaning-loop` |
| 要训练模型 | `model-training-loop` |
| 要整理会议纪要 | `meeting-notes-cleaner` |

---

## 3. 一分钟快速开始（Claude Code 全局安装）

Claude Code 对 Loop 的支持最直接：加载 `SKILL.md` 后即可使用 `/loop` 调用。

### 第 1 步：全局安装 Loops

```bash
# 克隆到用户主目录下的全局位置
git clone https://github.com/jwangkun/loops.git ~/.loops
```

### 第 2 步：在 Claude Code 中加载并调用

```bash
# 启动 Claude Code
claude

# 加载 Skill（每次新会话执行一次即可）
/load ~/.loops/SKILL.md

# 使用任意 Loop
/loop test-until-green
```

AI 会自动执行：
1. 运行检查命令（如 `npm test`）
2. 找到失败或不足
3. 修复最小根因
4. 重新运行检查
5. 重复直到目标达成

### 第 3 步：查看效果

AI 会告诉你每一步的操作结果，你只需在必要时介入。

---

## 4. 安装 Skill（默认全局安装）

> **推荐原则**：先把 Loops 装到全局位置，这样所有项目都能调用；只有需要项目隔离时，才按项目安装。
>
> 全局安装路径建议：`~/.loops`（Claude Code）、`~/.trae/skills/loops`（Trae）。

### 4.1 Claude Code（推荐，全局可用）

Claude Code 通过 `/load` 命令显式加载技能文件，因此 Loops 放在哪里都可以。推荐放在 `~/.loops`。

```bash
# 1. 克隆到全局位置
git clone https://github.com/jwangkun/loops.git ~/.loops

# 2. 启动 Claude Code 并加载 Skill
claude
/load ~/.loops/SKILL.md

# 3. 使用 Loop
/loop test-until-green
```

**让 Claude Code 每次自动加载（可选）**

把下面这行加入你的 shell 配置文件（如 `~/.zshrc`），这样每次启动 Claude Code 都会自动加载：

```bash
# 不推荐直接自动执行 /load，Claude Code 暂不支持启动脚本自动加载
# 建议每次会话手动执行 /load ~/.loops/SKILL.md
```

> 目前 Claude Code 不支持启动时自动执行 `/load`，所以每个新会话第一次使用 Loop 前，请手动 `/load ~/.loops/SKILL.md`。

### 4.2 Trae IDE（全局 Skill）

Trae 支持基于 `.trae/skills/` 目录结构自动识别 Skill。全局路径为 `~/.trae/skills/loops/`。

```bash
# macOS / Linux
mkdir -p ~/.trae/skills/loops
cp ~/.loops/SKILL.md ~/.trae/skills/loops/
cp -r ~/.loops/prompts ~/.trae/skills/loops/

# Windows
mkdir %USERPROFILE%\.trae\skills\loops
copy %USERPROFILE%\.loops\SKILL.md %USERPROFILE%\.trae\skills\loops\
xcopy /E /I %USERPROFILE%\.loops\prompts %USERPROFILE%\.trae\skills\loops\prompts
```

安装后在 Trae 的 AI 对话框中输入：

```
/loop test-until-green
```

或：

```
@loops /loop test-until-green
```

> Trae 全局 Skill 的支持取决于版本，如果全局不生效，请改用下面的项目级安装。

### 4.3 Cursor（全局 `.cursorrules`）

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

> 请确保你已经执行过 `git clone https://github.com/jwangkun/loops.git ~/.loops`，否则 `~/.loops/prompts/zh/` 路径不存在。

### 4.4 Windsurf（项目级）

Windsurf 目前按项目加载 `docs`/`knowledge` 目录，需要在每个项目中复制一次：

```bash
mkdir -p .windsurf/knowledge
cp ~/.loops/SKILL.md .windsurf/knowledge/loops.md
cp ~/.loops/prompts/zh/*.md .windsurf/knowledge/
```

然后在 Windsurf 中输入：

```
/loop test-until-green
```

### 4.5 Cline（项目级）

Cline 同样按项目加载知识库文件：

```bash
mkdir -p .cline
cp ~/.loops/SKILL.md .cline/loops.md
cp ~/.loops/prompts/zh/*.md .cline/
```

### 4.6 项目级安装（可选）

如果你希望某个项目使用独立的 Loops 版本，可以按项目安装：

```bash
cd your-project
mkdir -p .trae/skills/loops
cp ~/.loops/SKILL.md .trae/skills/loops/
cp -r ~/.loops/prompts .trae/skills/loops/
```

> `.trae/` 是本地 IDE 配置，不应提交到版本控制。建议将 `.trae/` 加入项目 `.gitignore`。

### 4.7 通过 Git 子模块安装（可选）

```bash
cd your-project
git submodule add https://github.com/jwangkun/loops.git .trae/skills/loops
```

---

## 5. 在各 Agent 中使用

### 5.1 通用调用格式

```
/loop <loop-name> [上下文参数]
```

### 5.2 Claude Code

Claude Code 需要先 `/load ~/.loops/SKILL.md` 加载 Skill（每个新会话一次）：

```bash
/load ~/.loops/SKILL.md
/loop fix-ci-until-green
```

### 5.3 Trae

```
@loops /loop test-until-green
```

或自然语言：

```
帮我运行 test-until-green，修复所有失败的测试
```

### 5.4 Cursor

```
运行 lint-typecheck-fix loop 清理代码
```

Cursor 会读取 `~/.cursorrules` 中的配置并执行。

### 5.5 自然语言调用

如果你记不住 Loop 名称，可以直接描述需求：

```
我有一些测试失败了，帮我用 Loop 的方式修复它们
```

AI 助手会根据你的需求自动匹配最合适的 Loop。

### 5.6 组合使用

```
先运行 /loop lint-typecheck-fix，然后运行 /loop test-until-green
```

---

## 6. Loop 完整目录

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

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `test-until-green` | 所有测试通过 | `npm test` | [查看](prompts/zh/test-until-green.md) | [View](prompts/en/test-until-green.md) |
| `e2e-until-green` | E2E 测试套件通过 | `npm run test:e2e` | [查看](prompts/zh/e2e-until-green.md) | [View](prompts/en/e2e-until-green.md) |
| `flaky-test-triage` | 将失败测试分类为 flaky 或 real | `npm test -- --testPathPattern=<failing-suite>` | [查看](prompts/zh/flaky-test-triage.md) | [View](prompts/en/flaky-test-triage.md) |
| `visual-regression-until-match` | 视觉回归测试通过 | `npx playwright test --grep @visual` | [查看](prompts/zh/visual-regression-until-match.md) | [View](prompts/en/visual-regression-until-match.md) |
| `coverage-until-threshold` | 覆盖率达标（默认80%） | `npm test -- --coverage` | [查看](prompts/zh/coverage-until-threshold.md) | [View](prompts/en/coverage-until-threshold.md) |
| `staging-smoke-test` | 预发布环境冒烟测试通过 | `npm run smoke:staging` | [查看](prompts/zh/staging-smoke-test.md) | [View](prompts/en/staging-smoke-test.md) |
| `post-edit-test-guard` | 编辑后相关测试必须通过 | `npm test -- --findRelatedTests <files>` | [查看](prompts/zh/post-edit-test-guard.md) | [View](prompts/en/post-edit-test-guard.md) |

### CI/CD

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `ship-pr-until-green` | PR 已打开且所有 CI 检查通过 | `gh pr checks` | [查看](prompts/zh/ship-pr-until-green.md) | [View](prompts/en/ship-pr-until-green.md) |
| `fix-ci-until-green` | 当前分支的最新 CI 运行通过 | `gh run list ...` | [查看](prompts/zh/fix-ci-until-green.md) | [View](prompts/en/fix-ci-until-green.md) |
| `ci-failure-watcher` | 当前分支的最新 CI 运行是绿色的 | `gh run list ...` | [查看](prompts/zh/ci-failure-watcher.md) | [View](prompts/en/ci-failure-watcher.md) |
| `build-until-green` | 生产构建成功 | `npm run build` | [查看](prompts/zh/build-until-green.md) | [View](prompts/en/build-until-green.md) |
| `pre-commit-guard` | 测试失败时阻止 git 提交 | `npm test` | [查看](prompts/zh/pre-commit-guard.md) | [View](prompts/en/pre-commit-guard.md) |
| `pr-self-review` | 当前 diff 上完成三轮干净的自我审查 | `git diff main...HEAD` | [查看](prompts/zh/pr-self-review.md) | [View](prompts/en/pr-self-review.md) |
| `pr-babysitter` | 标记为 codex-watch 的 PR 保持健康 | `gh pr list --label "codex-watch"` | [查看](prompts/zh/pr-babysitter.md) | [View](prompts/en/pr-babysitter.md) |
| `pr-watch-loop` | codex-watch PR 保持健康且无阻碍 | `gh pr list --label codex-watch ...` | [查看](prompts/zh/pr-watch-loop.md) | [View](prompts/en/pr-watch-loop.md) |
| `spec-first-ship` | spec.md 中的每个需求都已实现并打勾 | `npm test` | [查看](prompts/zh/spec-first-ship.md) | [View](prompts/en/spec-first-ship.md) |

### 代码质量 (Code Quality)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `lint-typecheck-fix` | lint 和 typecheck 干净 | `npm run lint && npx tsc --noEmit` | [查看](prompts/zh/lint-typecheck-fix.md) | [View](prompts/en/lint-typecheck-fix.md) |
| `format-until-clean` | 格式化工具运行干净 | `npm run format` | [查看](prompts/zh/format-until-clean.md) | [View](prompts/en/format-until-clean.md) |
| `de-sloppify-pass` | 最近的变更干净、最小化 | `npm run lint && npm test` | [查看](prompts/zh/de-sloppify-pass.md) | [View](prompts/en/de-sloppify-pass.md) |
| `knip-until-clean` | knip 报告没有未使用代码或依赖 | `npx knip` | [查看](prompts/zh/knip-until-clean.md) | [View](prompts/en/knip-until-clean.md) |

### API/规范

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `api-contract-until-match` | API 实现与发布的契约匹配 | `npm run test:contract` | [查看](prompts/zh/api-contract-until-match.md) | [View](prompts/en/api-contract-until-match.md) |
| `openapi-sync-until-valid` | openapi.yaml lint 干净且与实现的路由匹配 | `npx @redocly/cli lint openapi.yaml` | [查看](prompts/zh/openapi-sync-until-valid.md) | [View](prompts/en/openapi-sync-until-valid.md) |

### 依赖管理

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `dependency-upgrade-one-by-one` | 关键过时依赖升级且测试绿色 | `npm outdated && npm test && npm run build` | [查看](prompts/zh/dependency-upgrade-one-by-one.md) | [View](prompts/en/dependency-upgrade-one-by-one.md) |
| `migration-until-applied` | 所有数据库迁移应用干净 | `npx prisma migrate status` | [查看](prompts/zh/migration-until-applied.md) | [View](prompts/en/migration-until-applied.md) |
| `dependency-audit-weekly` | 交付每周依赖审计摘要 | `npm outdated || true` | [查看](prompts/zh/dependency-audit-weekly.md) | [View](prompts/en/dependency-audit-weekly.md) |
| `npm-audit-fix-loop` | 没有高危或严重 npm 审计漏洞 | `npm audit --audit-level=high && npm test` | [查看](prompts/zh/npm-audit-fix-loop.md) | [View](prompts/en/npm-audit-fix-loop.md) |

### 安全 (Security)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `security-audit-weekly` | 交付每周 npm 审计摘要和修复计划 | `npm audit --json` | [查看](prompts/zh/security-audit-weekly.md) | [View](prompts/en/security-audit-weekly.md) |

### 开发流程 (Development Process)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `autoloop-tdd` | 测试优先地实现目标行为 | `npm test` | [查看](prompts/zh/autoloop-tdd.md) | [View](prompts/en/autoloop-tdd.md) |
| `changelog-sync-after-ship` | CHANGELOG.md 有准确的 [Unreleased] 条目 | `git log -5 --oneline` | [查看](prompts/zh/changelog-sync-after-ship.md) | [View](prompts/en/changelog-sync-after-ship.md) |
| `investigation-script-loop` | 用最小复现脚本证明根因 | `node scripts/investigate.mjs` | [查看](prompts/zh/investigation-script-loop.md) | [View](prompts/en/investigation-script-loop.md) |
| `ralph-story-executor` | 每个 story 都有 passes: true | `npm test && npm run lint && npm run build` | [查看](prompts/zh/ralph-story-executor.md) | [View](prompts/en/ralph-story-executor.md) |
| `reflexion-debug-loop` | 失败的测试或复现通过 | `npm test -- --testNamePattern=<test>` | [查看](prompts/zh/reflexion-debug-loop.md) | [View](prompts/en/reflexion-debug-loop.md) |

### 文档 (Documentation)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `docs-sync-after-edits` | 文档与当前代码变更匹配 | `git diff main...HEAD --name-only` | [查看](prompts/zh/docs-sync-after-edits.md) | [View](prompts/en/docs-sync-after-edits.md) |

### 性能 (Performance)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `bundle-size-budget` | 客户端 bundle 保持在预算内 | `npm run build && npm run size-limit` | [查看](prompts/zh/bundle-size-budget.md) | [View](prompts/en/bundle-size-budget.md) |

### 无障碍 (Accessibility)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `a11y-audit-until-clean` | 变更的 UI 上没有严重的无障碍访问违规 | `npm run test:a11y` | [查看](prompts/zh/a11y-audit-until-clean.md) | [View](prompts/en/a11y-audit-until-clean.md) |

### Pull Request

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `merge-conflict-resolver` | 分支在 main 上 rebase 成功且测试通过 | `npm test` | [查看](prompts/zh/merge-conflict-resolver.md) | [View](prompts/en/merge-conflict-resolver.md) |
| `post-merge-regression-guard` | 每次合并或 rebase 后冒烟测试立即通过 | `npm run test:smoke` | [查看](prompts/zh/post-merge-regression-guard.md) | [View](prompts/en/post-merge-regression-guard.md) |

### 部署 (Deployment)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `deploy-verification-loop` | 所有部署后健康和冒烟端点返回成功 | `curl -fsS <your-health-url>` | [查看](prompts/zh/deploy-verification-loop.md) | [View](prompts/en/deploy-verification-loop.md) |

### 维护 (Maintenance)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `independent-verifier-pass` | 构建、lint 和测试在独立验证下通过 | `npm run build && npm run lint && npm test` | [查看](prompts/zh/independent-verifier-pass.md) | [View](prompts/en/independent-verifier-pass.md) |

### Git 钩子

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `guardrails-learning-loop` | 测试和 lint 通过且不重复之前的失败模式 | `npm test && npm run lint` | [查看](prompts/zh/guardrails-learning-loop.md) | [View](prompts/en/guardrails-learning-loop.md) |

### 代码生成与重构 (Code Generation)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `code-review-until-clean` | 代码通过结构化审查清单 | `python scripts/review_checklist.py` | [查看](prompts/zh/code-review-until-clean.md) | [View](prompts/en/code-review-until-clean.md) |
| `refactor-until-clean` | 目标模块达到整洁代码标准 | `npm run lint && npm test` | [查看](prompts/zh/refactor-until-clean.md) | [View](prompts/en/refactor-until-clean.md) |
| `generate-unit-tests` | 目标函数对边界条件有通过的单元测试 | `npm test -- <target-file>` | [查看](prompts/zh/generate-unit-tests.md) | [View](prompts/en/generate-unit-tests.md) |
| `component-scaffold-loop` | 新 UI 组件已生成测试和 stories | `npm test -- <component-name>` | [查看](prompts/zh/component-scaffold-loop.md) | [View](prompts/en/component-scaffold-loop.md) |
| `api-endpoint-generator` | 新 API 端点已实现 handler、路由和测试 | `npm run test:api` | [查看](prompts/zh/api-endpoint-generator.md) | [View](prompts/en/api-endpoint-generator.md) |
| `error-handling-audit` | 所有公共函数有一致的错误处理 | `npm run lint && npm test` | [查看](prompts/zh/error-handling-audit.md) | [View](prompts/en/error-handling-audit.md) |
| `type-definition-sync` | TypeScript 类型与运行时 API 和数据库 schema 匹配 | `npx tsc --noEmit` | [查看](prompts/zh/type-definition-sync.md) | [View](prompts/en/type-definition-sync.md) |
| `dead-code-removal` | 无未使用的导出、变量或函数残留 | `npx knip --no-exit-code && npm test` | [查看](prompts/zh/dead-code-removal.md) | [View](prompts/en/dead-code-removal.md) |

### 数据库与数据 (Database)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `schema-migration-loop` | 数据库 schema 变更已迁移且测试通过 | `npx prisma migrate dev && npm test` | [查看](prompts/zh/schema-migration-loop.md) | [View](prompts/en/schema-migration-loop.md) |
| `query-performance-loop` | 慢查询优化到阈值以下 | `npm run benchmark:queries` | [查看](prompts/zh/query-performance-loop.md) | [View](prompts/en/query-performance-loop.md) |
| `seed-data-validator` | 种子数据干净加载且引用有效 | `npm run db:seed && npm run test:seed` | [查看](prompts/zh/seed-data-validator.md) | [View](prompts/en/seed-data-validator.md) |
| `backup-verify-loop` | 最新数据库备份成功恢复 | `npm run db:backup:verify` | [查看](prompts/zh/backup-verify-loop.md) | [View](prompts/en/backup-verify-loop.md) |
| `data-consistency-check` | 无孤立记录或约束违规 | `npm run db:consistency` | [查看](prompts/zh/data-consistency-check.md) | [View](prompts/en/data-consistency-check.md) |

### 前端与 UI (Frontend)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `responsive-until-match` | UI 在所有目标断点正确渲染 | `npx playwright test --grep @responsive` | [查看](prompts/zh/responsive-until-match.md) | [View](prompts/en/responsive-until-match.md) |
| `design-token-sync` | 所有 UI 使用批准的设计 token | `npm run lint:design-tokens` | [查看](prompts/zh/design-token-sync.md) | [View](prompts/en/design-token-sync.md) |
| `component-library-update` | 组件库已更新新变体和文档 | `npm run storybook:build` | [查看](prompts/zh/component-library-update.md) | [View](prompts/en/component-library-update.md) |
| `frontend-error-boundary-check` | 所有路由都有错误边界和 fallback UI | `npm run lint:error-boundaries` | [查看](prompts/zh/frontend-error-boundary-check.md) | [View](prompts/en/frontend-error-boundary-check.md) |

### 后端与 API 开发 (Backend)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `rate-limit-enforcer` | 所有公共端点都实施限流 | `npm run test:rate-limit` | [查看](prompts/zh/rate-limit-enforcer.md) | [View](prompts/en/rate-limit-enforcer.md) |
| `authz-policy-loop` | 所有敏感端点都实施授权 | `npm run test:authz` | [查看](prompts/zh/authz-policy-loop.md) | [View](prompts/en/authz-policy-loop.md) |
| `api-validation-loop` | 所有 API 输入已验证和清理 | `npm run test:api-validation` | [查看](prompts/zh/api-validation-loop.md) | [View](prompts/en/api-validation-loop.md) |
| `logging-audit-loop` | 所有关键路径产生结构化日志 | `npm run lint:logging` | [查看](prompts/zh/logging-audit-loop.md) | [View](prompts/en/logging-audit-loop.md) |

### 数据科学与分析 (Data Science)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `data-cleaning-loop` | 数据集通过质量检查 | `python scripts/data_quality.py` | [查看](prompts/zh/data-cleaning-loop.md) | [View](prompts/en/data-cleaning-loop.md) |
| `model-training-loop` | 模型在验证集上达到目标准确率 | `python scripts/train.py --validate` | [查看](prompts/zh/model-training-loop.md) | [View](prompts/en/model-training-loop.md) |
| `feature-engineering-loop` | 特征集提升模型性能 | `python scripts/evaluate_features.py` | [查看](prompts/zh/feature-engineering-loop.md) | [View](prompts/en/feature-engineering-loop.md) |
| `data-pipeline-until-green` | 数据管道端到端无错误运行 | `python scripts/run_pipeline.py` | [查看](prompts/zh/data-pipeline-until-green.md) | [View](prompts/en/data-pipeline-until-green.md) |
| `experiment-tracker` | 实验结果已记录且可复现 | `python scripts/check_experiments.py` | [查看](prompts/zh/experiment-tracker.md) | [View](prompts/en/experiment-tracker.md) |
| `dashboard-sync-loop` | 仪表盘反映最新数据和指标 | `python scripts/refresh_dashboard.py` | [查看](prompts/zh/dashboard-sync-loop.md) | [View](prompts/en/dashboard-sync-loop.md) |

### 内容创作与写作 (Content Creation)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `blog-post-until-publish` | 博客文章已润色并准备发布 | `python scripts/blog_quality.py draft.md` | [查看](prompts/zh/blog-post-until-publish.md) | [View](prompts/en/blog-post-until-publish.md) |
| `readme-improvement-loop` | README 清晰、完整并遵循最佳实践 | `python scripts/readme_lint.py` | [查看](prompts/zh/readme-improvement-loop.md) | [View](prompts/en/readme-improvement-loop.md) |
| `social-post-generator` | 为每个平台生成社交媒体帖子 | `python scripts/check_posts.py` | [查看](prompts/zh/social-post-generator.md) | [View](prompts/en/social-post-generator.md) |
| `newsletter-until-send` | Newsletter 通过审查且链接有效 | `python scripts/newsletter_check.py` | [查看](prompts/zh/newsletter-until-send.md) | [View](prompts/en/newsletter-until-send.md) |
| `video-script-loop` | 视频脚本达到目标时长和清晰度 | `python scripts/script_review.py` | [查看](prompts/zh/video-script-loop.md) | [View](prompts/en/video-script-loop.md) |
| `translation-review-loop` | 翻译准确自然 | `python scripts/translation_check.py` | [查看](prompts/zh/translation-review-loop.md) | [View](prompts/en/translation-review-loop.md) |
| `ad-copy-optimizer` | 广告文案变体通过转化检查清单 | `python scripts/ad_copy_check.py` | [查看](prompts/zh/ad-copy-optimizer.md) | [View](prompts/en/ad-copy-optimizer.md) |

### 产品与设计 (Product & Design)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `prd-review-loop` | PRD 完整、清晰并准备开发 | `python scripts/prd_check.py` | [查看](prompts/zh/prd-review-loop.md) | [View](prompts/en/prd-review-loop.md) |
| `user-story-generator` | 为每个功能生成用户故事 | `python scripts/story_check.py` | [查看](prompts/zh/user-story-generator.md) | [View](prompts/en/user-story-generator.md) |
| `design-review-loop` | 设计遵循系统规范和无障碍规则 | `python scripts/design_check.py` | [查看](prompts/zh/design-review-loop.md) | [View](prompts/en/design-review-loop.md) |
| `competitive-analysis-loop` | 竞品分析报告完整且有来源 | `python scripts/competitor_check.py` | [查看](prompts/zh/competitive-analysis-loop.md) | [View](prompts/en/competitive-analysis-loop.md) |

### 运营与市场 (Operations & Marketing)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `seo-audit-loop` | 页面通过 SEO 检查清单 | `python scripts/seo_check.py` | [查看](prompts/zh/seo-audit-loop.md) | [View](prompts/en/seo-audit-loop.md) |
| `email-campaign-loop` | 邮件营销活动已审查且链接有效 | `python scripts/email_check.py` | [查看](prompts/zh/email-campaign-loop.md) | [View](prompts/en/email-campaign-loop.md) |
| `analytics-health-check` | 所有关键事件正确追踪 | `python scripts/analytics_check.py` | [查看](prompts/zh/analytics-health-check.md) | [View](prompts/en/analytics-health-check.md) |
| `release-notes-generator` | 发布说明已生成并审查 | `python scripts/release_notes_check.py` | [查看](prompts/zh/release-notes-generator.md) | [View](prompts/en/release-notes-generator.md) |

### 学习与知识管理 (Learning & Knowledge)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `flashcard-generator` | 为关键概念生成闪卡 | `python scripts/flashcard_check.py` | [查看](prompts/zh/flashcard-generator.md) | [View](prompts/en/flashcard-generator.md) |
| `study-plan-optimizer` | 学习计划现实并覆盖所有主题 | `python scripts/study_plan_check.py` | [查看](prompts/zh/study-plan-optimizer.md) | [View](prompts/en/study-plan-optimizer.md) |
| `note-organizer` | 笔记已打标签、链接并结构良好 | `python scripts/note_check.py` | [查看](prompts/zh/note-organizer.md) | [View](prompts/en/note-organizer.md) |
| `research-synthesis-loop` | 研究已总结来源和关键洞察 | `python scripts/research_check.py` | [查看](prompts/zh/research-synthesis-loop.md) | [View](prompts/en/research-synthesis-loop.md) |
| `quiz-validator` | 测验问题准确且有正确答案 | `python scripts/quiz_check.py` | [查看](prompts/zh/quiz-validator.md) | [View](prompts/en/quiz-validator.md) |

### 效率与生产力 (Productivity)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `meeting-notes-cleaner` | 会议纪要结构化并含行动项 | `python scripts/meeting_check.py` | [查看](prompts/zh/meeting-notes-cleaner.md) | [View](prompts/en/meeting-notes-cleaner.md) |
| `inbox-zero-loop` | 收件箱无未读可执行邮件 | `python scripts/inbox_check.py` | [查看](prompts/zh/inbox-zero-loop.md) | [View](prompts/en/inbox-zero-loop.md) |
| `task-prioritizer` | 任务按影响力和工作量排序 | `python scripts/task_check.py` | [查看](prompts/zh/task-prioritizer.md) | [View](prompts/en/task-prioritizer.md) |
| `weekly-review-loop` | 每周回顾报告完成 | `python scripts/weekly_review_check.py` | [查看](prompts/zh/weekly-review-loop.md) | [View](prompts/en/weekly-review-loop.md) |

### 系统与 DevOps (System & DevOps)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `docker-build-until-green` | Docker 镜像构建并通过健康检查 | `docker build -t app . && docker run --rm app healthcheck` | [查看](prompts/zh/docker-build-until-green.md) | [View](prompts/en/docker-build-until-green.md) |
| `terraform-plan-until-clean` | terraform plan 无意外变更 | `terraform plan -detailed-exitcode` | [查看](prompts/zh/terraform-plan-until-clean.md) | [View](prompts/en/terraform-plan-until-clean.md) |
| `log-anomaly-detector` | 近期日志无严重异常 | `python scripts/log_anomaly.py` | [查看](prompts/zh/log-anomaly-detector.md) | [View](prompts/en/log-anomaly-detector.md) |
| `ssl-certificate-monitor` | 所有域名都有有效 SSL 证书 | `python scripts/ssl_check.py` | [查看](prompts/zh/ssl-certificate-monitor.md) | [View](prompts/en/ssl-certificate-monitor.md) |
| `backup-routine-loop` | 所有关键数据已备份并验证 | `python scripts/backup_check.py` | [查看](prompts/zh/backup-routine-loop.md) | [View](prompts/en/backup-routine-loop.md) |

### 安全与合规 (Security & Compliance)

| Loop | 目标 | 检查命令 | 中文提示词 | 英文提示词 |
|------|------|----------|-----------|-----------|
| `secret-scan-loop` | 仓库中无密钥或凭证 | `npx secretlint --maskSecrets "**/*"` | [查看](prompts/zh/secret-scan-loop.md) | [View](prompts/en/secret-scan-loop.md) |
| `compliance-checklist-loop` | 所有合规检查项已满足 | `python scripts/compliance_check.py` | [查看](prompts/zh/compliance-checklist-loop.md) | [View](prompts/en/compliance-checklist-loop.md) |
| `privacy-policy-audit` | 隐私政策与当前数据实践匹配 | `python scripts/privacy_check.py` | [查看](prompts/zh/privacy-policy-audit.md) | [View](prompts/en/privacy-policy-audit.md) |
| `access-review-loop` | 所有用户访问权限都有正当理由 | `python scripts/access_review.py` | [查看](prompts/zh/access-review-loop.md) | [View](prompts/en/access-review-loop.md) |

---

## 7. 场景速查表

### 软件开发

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 让测试全绿 | `test-until-green` | `/loop test-until-green` |
| 修 CI 失败 | `fix-ci-until-green` | `/loop fix-ci-until-green` |
| 自动 lint 修复 | `lint-typecheck-fix` | `/loop lint-typecheck-fix` |
| 自动格式化 | `format-until-clean` | `/loop format-until-clean` |
| 审查自己的 PR | `pr-self-review` | `/loop pr-self-review` |
| 升级依赖 | `dependency-upgrade-one-by-one` | `/loop dependency-upgrade-one-by-one` |
| 修安全漏洞 | `npm-audit-fix-loop` | `/loop npm-audit-fix-loop` |
| TDD 开发 | `autoloop-tdd` | `/loop autoloop-tdd` |
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
| 改进 README | `readme-improvement-loop` | `/loop readme-improvement-loop` |
| 生成社媒帖子 | `social-post-generator` | `/loop social-post-generator` |
| 准备 Newsletter | `newsletter-until-send` | `/loop newsletter-until-send` |
| 优化视频脚本 | `video-script-loop` | `/loop video-script-loop` |
| 审校翻译 | `translation-review-loop` | `/loop translation-review-loop` |
| 优化广告文案 | `ad-copy-optimizer` | `/loop ad-copy-optimizer` |

### 产品与运营

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 审查 PRD | `prd-review-loop` | `/loop prd-review-loop` |
| 生成用户故事 | `user-story-generator` | `/loop user-story-generator` |
| 设计审查 | `design-review-loop` | `/loop design-review-loop` |
| 竞品分析 | `competitive-analysis-loop` | `/loop competitive-analysis-loop` |
| SEO 审计 | `seo-audit-loop` | `/loop seo-audit-loop` |
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
| 构建 Docker 镜像 | `docker-build-until-green` | `/loop docker-build-until-green` |
| 检查 Terraform | `terraform-plan-until-clean` | `/loop terraform-plan-until-clean` |
| 检测日志异常 | `log-anomaly-detector` | `/loop log-anomaly-detector` |
| 监控 SSL 证书 | `ssl-certificate-monitor` | `/loop ssl-certificate-monitor` |
| 扫描密钥泄露 | `secret-scan-loop` | `/loop secret-scan-loop` |
| 合规检查 | `compliance-checklist-loop` | `/loop compliance-checklist-loop` |
| 审查访问权限 | `access-review-loop` | `/loop access-review-loop` |

---

## 8. 创建自己的 Loop

### 8.1 最简单的方法

1. 复制 `prompts/zh/test-until-green.md`
2. 重命名为 `prompts/zh/my-loop.md`
3. 修改标题、目标、检查命令、步骤
4. 在 `prompts/en/` 中创建对应的英文版本

### 8.2 Loop 文件模板

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

### 8.3 创建 Loop 的 5 个原则

1. **目标清晰** - 必须有一个可验证的目标
2. **检查命令明确** - 必须有一个命令能判断是否达成目标
3. **可迭代修复** - 每次失败后都能进行小步修复
4. **有退出条件** - 避免无限循环
5. **保持最小化** - 每个 Loop 只负责一个职责

---

## 9. 最佳实践

### 9.1 使用前的准备

- 运行前最好提交当前工作
- 确保环境依赖已安装
- 设置合理的最大迭代次数

### 9.2 执行原则

- 每次只修复最小根因
- 每次修改后必须运行检查命令
- 重要的运行结果保存日志
- 达到最大迭代次数时人工介入

### 9.3 安全建议

- 修改依赖前先备份 `package-lock.json`
- 会修改远程仓库的 Loop 谨慎使用
- 生产部署相关 Loop 在监控下运行
- 涉及密钥扫描、权限审查的 Loop 需审计后再执行

### 9.4 与 Git 工作流结合

```bash
# 1. 创建功能分支
git checkout -b feature/new-stuff

# 2. 用 Loop 实现功能
/loop autoloop-tdd

# 3. 用 Loop 自我审查
/loop pr-self-review

# 4. 提交推送
git commit -am "feat: add new stuff"
git push origin feature/new-stuff

# 5. 确保 CI 通过
/loop fix-ci-until-green
```

---

## 10. 中国区用户指南

### 10.1 为什么要特别优化？

本仓库主要面向中国用户，因此：
- 所有 Loop 提示词提供完整中文版本
- README 和 SKILL.md 使用中文编写
- 提供中国区网络加速建议
- 兼容国内主流 AI 编程助手（Trae、Cursor 等）

### 10.2 网络加速配置

```bash
# npm 切换到淘宝镜像
npm config set registry https://registry.npmmirror.com

# 全局设置
npm config set registry https://registry.npmmirror.com --global

# 安装依赖时使用镜像
npm install --registry=https://registry.npmmirror.com
```

### 10.3 常用工具的中国区替代

| 原工具/命令 | 中国区替代 |
|------------|-----------|
| `npm install` | `npm install --registry=https://registry.npmmirror.com` |
| `npx playwright install` | 手动下载或使用国内镜像 |
| `gh` CLI | 可替换为 `hub` 或直接访问 GitHub Web |
| GitHub 仓库克隆 | 使用 Gitee 镜像或代理 |
| Docker Hub | 使用阿里云或网易云镜像 |
| Python pip | `pip install -i https://pypi.tuna.tsinghua.edu.cn/simple` |

### 10.4 安装方式

如果 GitHub 访问较慢：

```bash
# 方式一：Gitee 镜像
git clone https://gitee.com/jwangkun/loops.git

# 方式二：下载 zip
curl -L -o loops.zip https://github.com/jwangkun/loops/archive/refs/heads/main.zip
unzip loops.zip
```

### 10.5 推荐的中国区 AI 助手

| AI 助手 | 支持情况 | 安装方式 |
|--------|---------|---------|
| Claude Code | 完全支持 | 见第 4 节 |
| Trae | 完全支持 | 见第 4 节 |
| Cursor | 完全支持 | 见第 4 节 |
| Windsurf | 支持 | 见第 4 节 |
| Cline | 支持 | 见第 4 节 |

---

## 11. 常见问题

### Q1: Agent 不识别 `/loop` 命令怎么办？

A1: 尝试以下方法：
1. 确认 Skill 已正确安装（Claude Code 需先 `/load ~/.loops/SKILL.md`）
2. Trae 用户检查 `~/.trae/skills/loops/` 是否存在 `SKILL.md` 和 `prompts/`
3. Cursor 用户检查 `~/.cursorrules` 是否已配置
4. 用自然语言描述需求，让 AI 自动匹配 Loop

### Q2: 检查命令不存在怎么办？

A2: 
1. 检查 `package.json` 中是否有对应 scripts
2. 安装缺失的工具或依赖
3. 修改 Loop 文件中的检查命令以匹配你的项目

### Q3: Loop 会修改我的代码或文件吗？

A3: 是的，Loop 的核心就是自动修复问题。建议运行前先提交当前代码或备份重要文件。

### Q4: 可以只使用中文提示词吗？

A4: 可以。`prompts/zh/` 目录下全是中文提示词。

### Q5: 如何贡献新的 Loop？

A5: 
1. 在 `prompts/zh/` 和 `prompts/en/` 中各添加一个文件
2. 文件名使用小写连字符格式
3. 更新 README 和 SKILL.md 中的目录
4. 提交 Pull Request

### Q6: 新增的 60 个 Loop 来自哪里？

A6: 新增的 Loop 参考了 SkillHub、SkillsMP 等热门 AI Skills 市场的常见需求，以及日常工作中的高频自动化场景，涵盖数据科学、内容创作、产品运营、学习管理等领域。

---

## 目录结构

```
loops/
├── prompts/
│   ├── en/                   # 英文版 Loop 提示词 (100个)
│   │   ├── test-until-green.md
│   │   ├── data-cleaning-loop.md
│   │   └── ...
│   └── zh/                   # 中文版 Loop 提示词 (100个)
│       ├── test-until-green.md
│       ├── data-cleaning-loop.md
│       └── ...
├── SKILL.md                  # Skills 入口文件（安装时复制到 .trae/skills/loops/）
├── README.md                 # 中文说明文档
├── README_EN.md              # 英文说明文档
└── generate_all_prompts.py   # Loop 元数据与生成脚本
```

> 注意：`.trae/` 是本地 IDE 配置目录，不应提交到版本控制。安装 Skill 时，请将 `SKILL.md` 和 `prompts/` 复制到你的项目 `.trae/skills/loops/` 目录下。

---

## 相关资源

- [Loops! 官方站点](https://loops.elorm.xyz/loops)
- [SkillHub - Agent Skills 市场](https://www.skillhub.club/)
- [SkillsMP - 最大的 Agent Skills 市场](https://skillsmp.com/)
- [GitHub 仓库](https://github.com/jwangkun/loops)
- [Gitee 镜像](https://gitee.com/jwangkun/loops)

---

**许可证:** MIT  
**版本:** 2.0.0  
**维护:** Loops Community

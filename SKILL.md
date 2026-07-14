---
name: "loops"
description: "AI驱动的自动化循环集合。覆盖软件开发、数据科学、内容创作、产品运营、学习管理等领域。当用户需要自动化工作流、修复问题、生成内容、分析数据或执行质量检查时使用。"
version: "2.0.0"
author: "Loops Community"
license: "MIT"
tags: ["automation", "testing", "ci", "quality", "workflow", "ai-agents", "data-science", "content-creation", "productivity"]
supported_agents: ["Claude Code", "Codex", "Cursor", "Trae", "Windsurf", "Cline"]
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

> **默认推荐全局安装**。先把 Loops 装到全局位置，这样所有项目都能调用；只有需要项目隔离时，才按项目安装。
>
> 全局安装路径建议：`~/.claude/skills/loops`（Claude Code）、`~/.trae/skills/loops`（Trae）、`~/.codex/AGENTS.md`（Codex）、`~/.loops`（通用，配合软链接）。
>
> ⚠️ **命名冲突提示**：Claude Code 自带一个内置 `/loop` skill。本仓库**统一用 `/loops <name>`（复数）调用**，避免误触发内置的那个。详见 [§2.1](#21-claude-code)。

### 1.1 Claude Code 安装（推荐，全局可用）

Claude Code 原生支持基于目录的 Skill 自动发现。把 `SKILL.md` 放进 `~/.claude/skills/loops/` 后，启动 `claude` 即自动加载，无需任何启动参数。

**方法 A：克隆到 skill 目录（推荐，自动发现）**

```bash
# 1. 克隆到 Claude Code 个人 skill 目录
git clone https://github.com/jwangkun/loops.git ~/.claude/skills/loops

# 2. 启动 Claude Code（无需 --system-prompt）
claude

# 3. 调用任意 Loop
/loops test-until-green
```

**方法 B：克隆到通用位置 + 软链接（多 Agent 共用）**

```bash
git clone https://github.com/jwangkun/loops.git ~/.loops
ln -s ~/.loops ~/.claude/skills/loops   # macOS/Linux
# Windows 下用复制代替：xcopy /E /I %USERPROFILE%\.loops %USERPROFILE%\.claude\skills\loops
```

**方法 C：用 `--append-system-prompt` 在启动时注入（已运行的会话用方法 D 粘贴）**

> ⚠️ `claude --system-prompt <文件>` 是错误写法：`--system-prompt` 接受字面文本且会完全替换默认系统提示，读取文件的 `--system-prompt-file` 仅支持 `-p` 打印模式。临时会话请用 `--append-system-prompt` 追加内容：

```bash
# 整个 Skill（保留默认能力，仅追加 Loops 指令）
claude --append-system-prompt "$(cat ~/.loops/SKILL.md)"

# 或只为单个 Loop 启动临时会话
claude --append-system-prompt "$(cat ~/.loops/prompts/zh/test-until-green.md)"
```

**方法 D：粘贴到已在运行的会话**

如果 `claude` 已经在运行但没自动加载 skill，可直接把 `SKILL.md` 内容粘贴进对话：

```bash
cat ~/.loops/SKILL.md | pbcopy    # macOS；Linux 用 xclip -sel c；Windows 用 clip
# 在 Claude Code 中粘贴即可，然后使用 /loops <name>
```

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
/loops test-until-green
```

或：

```
@loops /loops test-until-green
```

> Trae 全局 Skill 的支持取决于版本。如果全局不生效，请改用下面的项目级安装。

### 1.3 Cursor 安装（`.cursor/rules/loops.mdc`）

> ⚠️ **旧版 `.cursorrules` 已被 Cursor 弃用**。新版 Cursor 使用 `.cursor/rules/*.mdc` 文件（带 YAML frontmatter），支持按 glob 匹配文件自动激活。下面是新做法。

**项目级安装（推荐，Cursor 官方主推）**

```bash
cd your-project
mkdir -p .cursor/rules

# 创建 loops.mdc，内容如下
cat > .cursor/rules/loops.mdc << 'EOF'
---
description: Loops 自动化循环集合。当用户需要自动化测试、CI修复、代码质量、内容创作、数据分析等任务时按 Loop 模式执行。
globs:
  - "**/*"
alwaysApply: false
---

# Loops Skill

你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析、学习管理等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按照 Loop 的"执行→检查→修复→重复"模式执行任务。

调用方式：`/loops <name>`（复数，避免与内置冲突）。

常用 Loop：
- 测试失败：/loops test-until-green
- CI修复：/loops fix-ci-until-green
- 代码质量：/loops lint-typecheck-fix
- PR审查：/loops pr-self-review
- TDD开发：/loops autoloop-tdd
- 文档同步：/loops docs-sync-after-edits
- 博客优化：/loops blog-post-until-publish
- 数据清洗：/loops data-cleaning-loop
- 会议纪要：/loops meeting-notes-cleaner
EOF
```

**全局安装（对所有 Cursor 项目生效）**

Cursor 官方目前主推项目级 `.cursor/rules/`，全局规则可在用户主目录放一个 `.cursor/rules/loops.mdc`（同上内容）。若全局不生效，建议改用项目级或参考 [§2.7 直接复制提示词](#27-直接复制提示词去任意-agent)。

> 请确保已执行 `git clone https://github.com/jwangkun/loops.git ~/.loops`，否则 `~/.loops/prompts/zh/` 路径不存在。

### 1.4 Windsurf 安装（`.windsurf/rules/` 或 `.windsurfrules`）

Windsurf（Codeium）读取项目里的规则文件。新版用目录 `.windsurf/rules/*.md`（带 YAML frontmatter，支持 `always_on` / `model_decision` / `glob` / `manual` 四种激活模式）；旧版 `.windsurfrules`（项目根）仍被兼容。全局规则放在 `~/.codeium/windsurf/memories/global_rules.md`（注意中间有 `memories/` 目录，单文件约 6000 字符上限）。

**项目级安装 —— 方式 A：新版 `.windsurf/rules/`（推荐）**

```bash
cd your-project
mkdir -p .windsurf/rules
cat > .windsurf/rules/loops.md << 'EOF'
---
description: Loops 自动化循环集合。当用户需要自动化测试、CI修复、代码质量、内容创作、数据分析等任务时按 Loop 模式执行。
trigger: model_decision
---

# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。

调用方式：/loops <name>（复数，避免与 Claude Code 内置 /loop 冲突）。
常用：/loops test-until-green、/loops fix-ci-until-green、/loops lint-typecheck-fix、/loops pr-self-review
EOF
```

**项目级安装 —— 方式 B：旧版 `.windsurfrules`（兼容，单文件）**

```bash
cd your-project
cat > .windsurfrules << 'EOF'
# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。

调用方式：/loops <name>（复数，避免与 Claude Code 内置 /loop 冲突）。
常用：/loops test-until-green、/loops fix-ci-until-green、/loops lint-typecheck-fix、/loops pr-self-review
EOF
```

**全局安装（所有 Windsurf 项目）**

```bash
mkdir -p ~/.codeium/windsurf/memories
cat > ~/.codeium/windsurf/memories/global_rules.md << 'EOF'
# Loops 全局配置（同上内容）
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。
EOF
```

### 1.5 Cline 安装（`.clinerules`）

Cline 读取项目根目录的 `.clinerules` 文件（或 `.clinerules/` 文件夹）。规则会自动追加到每次对话的系统提示。

**项目级安装（推荐）**

```bash
cd your-project
cat > .clinerules << 'EOF'
# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。

调用方式：/loops <name>（复数，避免与 Claude Code 内置 /loop 冲突）。
常用：/loops test-until-green、/loops fix-ci-until-green、/loops lint-typecheck-fix、/loops pr-self-review
EOF
```

> 也可在 Cline 聊天框下方的 **Rules** 面板用 **+** 按钮新建规则，效果相同。

### 1.6 Codex 安装（`AGENTS.md`）

OpenAI Codex（CLI / IDE 扩展 / Cloud）通过 **`AGENTS.md`** 文件读取指令——开始任何工作前会先读取它。Codex **没有 `/loops` 这类斜杠命令**，调用方式是**自然语言 + 引用 Loop 名称**。它按「全局 → 项目根 → 当前目录」的顺序加载，后者覆盖前者。

**全局安装（所有 Codex 项目，推荐）**

```bash
mkdir -p ~/.codex
cat > ~/.codex/AGENTS.md << 'EOF'
# Loops Skill（全局配置）

你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析、学习管理等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后严格按 Loop 的"执行→检查→修复→重复"模式执行任务。

常用 Loop（按需选用，名称即提示词文件名）：
- test-until-green：修复失败测试直到全绿
- fix-ci-until-green：修复当前分支 CI
- lint-typecheck-fix：lint + typecheck 干净
- pr-self-review：对当前 diff 做三轮自我审查
- autoloop-tdd：测试优先地实现目标行为
- docs-sync-after-edits：文档与代码变更同步
EOF
```

**项目级安装（推荐用于团队共享）**

```bash
cd your-project
cat > AGENTS.md << 'EOF'
# Loops Skill（项目配置）

本项目使用 Loops 自动化循环。任务执行前先读取 `~/.loops/prompts/zh/<loop-name>.md`（或仓库内的 `prompts/zh/`），按其"执行→检查→修复→重复"流程执行。

常用：test-until-green、fix-ci-until-green、lint-typecheck-fix、pr-self-review。
检查命令、退出条件、最大迭代次数以各 Loop 文件为准。
EOF
```

> Codex 也会自动发现仓库根目录的 `AGENTS.md`，适合放进版本控制让团队共用。`AGENTS.override.md`（子目录）可覆盖上层规则。
>
> Codex 原生契合 Loop：本仓库的 `pr-babysitter`、`pr-watch-loop` 就是针对 Codex 的 PR 看护场景设计的（使用 `codex-watch` 标签）。

### 1.7 项目级安装（通用）

如果你希望某个项目使用独立的 Loops 版本，可按项目安装到任意 IDE 的规则目录（参考 1.2 Trae 示例）：

```bash
cd your-project
mkdir -p .trae/skills/loops
cp ~/.loops/SKILL.md .trae/skills/loops/
cp -r ~/.loops/prompts .trae/skills/loops/
```

> 各 IDE 的本地配置目录（`.trae/`、`.cursor/`、`.clinerules`、`.windsurfrules`、`AGENTS.md` 等）不应提交到版本控制（除非作为团队共享约定），已在 `.gitignore` 中忽略。

### 1.8 通过 Git 子模块安装（可选）

```bash
cd your-project
git submodule add https://github.com/jwangkun/loops.git .loops
# 然后按你用的 Agent 把 .loops/SKILL.md 链接到对应规则位置
```

---

## 2. 在 Agent 中使用

### 2.1 Claude Code

Claude Code 装到 `~/.claude/skills/loops/` 后自动发现，直接调用即可：

```
/loops test-until-green
```

或用自然语言：

```
请按 test-until-green 的 Loop 流程，修复当前所有失败的测试
```

> 若 `/loops xxx` 未触发本仓库的 Loop（例如仍触发 Claude Code 内置的 `/loop`），检查 `~/.claude/skills/loops/SKILL.md` 是否存在；或改用 [§2.7 直接复制提示词](#27-直接复制提示词去任意-agent)。

### 2.2 Trae

Trae 会自动识别 `~/.trae/skills/loops/` 中的 Skill。在 AI 对话框中输入：

```
/loops test-until-green
```

或：

```
@loops /loops test-until-green
```

也可以直接用中文：

```
帮我运行 test-until-green，修复所有失败的测试
```

### 2.3 Cursor

Cursor 会读取 `.cursor/rules/loops.mdc` 中的 Loops 配置（见 [§1.3](#13-cursor-安装cursorrulesloopsmdc)）。在 Composer 或 Chat 中：

```
运行 test-until-green 的 Loop 流程，修复当前测试
```

### 2.4 Windsurf

Windsurf 读取 `.windsurfrules`（见 [§1.4](#14-windsurf-安装windsurfrules)）。在 Cascade 中：

```
/loops test-until-green
```

### 2.5 Cline

Cline 读取 `.clinerules`（见 [§1.5](#15-cline-安装clinerules)）。在 Chat 中：

```
/loops test-until-green
```

### 2.6 Codex

Codex **没有斜杠命令**，全部用自然语言调用。配置好 `~/.codex/AGENTS.md` 或项目根的 `AGENTS.md` 后（见 [§1.6](#16-codex-安装agentsmd)），在 Codex CLI / IDE 扩展 / Cloud 里直接说需求并点 Loop 名：

```
请按 test-until-green 这个 Loop 的流程，运行 npm test，修复所有失败用例直到全绿。
```

或更简洁：

```
用 fix-ci-until-green 修复当前分支的 CI 失败。
```

> Codex 会从 `AGENTS.md` 知道去哪里读 Loop 提示词（`~/.loops/prompts/zh/`）。本仓库的 `pr-babysitter`、`pr-watch-loop` 就是为 Codex 的 PR 看护场景设计的。

### 2.7 直接复制提示词去任意 Agent

不想装 Skill、或者用的是 ChatGPT / Claude.ai / Gemini / Copilot Chat / 通义 / 文心 等对话框？**直接把某个 Loop 的提示词全文复制进对话即可**，无需安装。三步：

**第 1 步：选一个 Loop 文件**

```bash
ls ~/.loops/prompts/zh/     # 中文版（推荐）
ls ~/.loops/prompts/en/     # 英文版
```

**第 2 步：复制全文到剪贴板**

```bash
# macOS
cat ~/.loops/prompts/zh/test-until-green.md | pbcopy

# Linux（需 xclip）
cat ~/.loops/prompts/zh/test-until-green.md | xclip -sel c

# Windows（Git Bash / WSL）
cat ~/.loops/prompts/zh/test-until-green.md | clip.exe

# 或者：直接在 GitHub / 编辑器里打开文件，Ctrl+A 全选复制
```

**第 3 步：粘贴到任意 Agent 对话框，加一句指令**

```
请严格按照下面这个 Loop 的流程执行，每完成一轮检查后把结果告诉我：

（粘贴 Loop 提示词全文）
```

> 注意：纯对话框类 Agent 无法直接执行 `npm test` 等命令，需要你把命令输出贴回给它。适用于内容创作、数据分析、学习管理类不需要执行本地命令的 Loop（如 `blog-post-until-publish`、`meeting-notes-cleaner`、`prd-review-loop`）。

### 2.8 通用调用格式

```
/loops <loop-name> [上下文参数]

示例：
/loops test-until-green
/loops fix-ci-until-green
/loops pr-self-review
/loops data-cleaning-loop
/loops blog-post-until-publish
```

> 本仓库统一用 **`/loops`（复数）**，避免与 Claude Code 内置的 `/loop` skill 冲突。其它 Agent（Trae/Cursor/Windsurf/Cline）同样使用 `/loops`。

---

## 3. 快速开始

### 3.1 一分钟上手

1. 将本 Skill 安装到你的项目（见[安装 Skill](#1-安装-skill)）
2. 打开你的 AI 编程助手
3. 输入任意 Loop 命令，例如：

```
/loops test-until-green
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
/loops <loop-slug>
```

### 4.2 带上下文参数

某些 Loop 支持上下文参数（Agent 会自动识别）：

```
/loops flaky-test-triage --suite=auth.test.ts
/loops coverage-until-threshold --threshold=85
/loops npm-audit-fix-loop --level=high
/loops generate-unit-tests --file=utils.ts
/loops blog-post-until-publish --file=draft.md
```

> 具体参数由 Agent 根据 Loop 描述自动推断，你也可以在提示词中明确指定。

### 4.3 组合使用

Loop 可以串联使用：

```
先运行 /loops lint-typecheck-fix，然后运行 /loops test-until-green
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
| 让测试全绿 | `test-until-green` | `/loops test-until-green` |
| 修CI失败 | `fix-ci-until-green` | `/loops fix-ci-until-green` |
| 自动lint修复 | `lint-typecheck-fix` | `/loops lint-typecheck-fix` |
| 自动格式化 | `format-until-clean` | `/loops format-until-clean` |
| 审查自己的PR | `pr-self-review` | `/loops pr-self-review` |
| 升级依赖 | `dependency-upgrade-one-by-one` | `/loops dependency-upgrade-one-by-one` |
| 修安全漏洞 | `npm-audit-fix-loop` | `/loops npm-audit-fix-loop` |
| TDD开发 | `autoloop-tdd` | `/loops autoloop-tdd` |
| 更新文档 | `docs-sync-after-edits` | `/loops docs-sync-after-edits` |
| 合并冲突 | `merge-conflict-resolver` | `/loops merge-conflict-resolver` |
| 部署验证 | `deploy-verification-loop` | `/loops deploy-verification-loop` |
| 优化性能 | `bundle-size-budget` | `/loops bundle-size-budget` |
| 代码重构 | `refactor-until-clean` | `/loops refactor-until-clean` |
| 生成单元测试 | `generate-unit-tests` | `/loops generate-unit-tests` |
| 错误处理审计 | `error-handling-audit` | `/loops error-handling-audit` |

### 数据与AI

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 清洗数据集 | `data-cleaning-loop` | `/loops data-cleaning-loop` |
| 训练模型 | `model-training-loop` | `/loops model-training-loop` |
| 特征工程 | `feature-engineering-loop` | `/loops feature-engineering-loop` |
| 运行数据管道 | `data-pipeline-until-green` | `/loops data-pipeline-until-green` |
| 追踪实验 | `experiment-tracker` | `/loops experiment-tracker` |
| 刷新仪表盘 | `dashboard-sync-loop` | `/loops dashboard-sync-loop` |
| 数据库迁移 | `schema-migration-loop` | `/loops schema-migration-loop` |
| 优化慢查询 | `query-performance-loop` | `/loops query-performance-loop` |

### 内容创作

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 优化博客文章 | `blog-post-until-publish` | `/loops blog-post-until-publish` |
| 改进README | `readme-improvement-loop` | `/loops readme-improvement-loop` |
| 生成社媒帖子 | `social-post-generator` | `/loops social-post-generator` |
| 准备Newsletter | `newsletter-until-send` | `/loops newsletter-until-send` |
| 优化视频脚本 | `video-script-loop` | `/loops video-script-loop` |
| 审校翻译 | `translation-review-loop` | `/loops translation-review-loop` |
| 优化广告文案 | `ad-copy-optimizer` | `/loops ad-copy-optimizer` |

### 产品与运营

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 审查PRD | `prd-review-loop` | `/loops prd-review-loop` |
| 生成用户故事 | `user-story-generator` | `/loops user-story-generator` |
| 设计审查 | `design-review-loop` | `/loops design-review-loop` |
| 竞品分析 | `competitive-analysis-loop` | `/loops competitive-analysis-loop` |
| SEO审计 | `seo-audit-loop` | `/loops seo-audit-loop` |
| 邮件营销检查 | `email-campaign-loop` | `/loops email-campaign-loop` |
| 发布说明 | `release-notes-generator` | `/loops release-notes-generator` |

### 学习与效率

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 生成学习闪卡 | `flashcard-generator` | `/loops flashcard-generator` |
| 优化学习计划 | `study-plan-optimizer` | `/loops study-plan-optimizer` |
| 整理笔记 | `note-organizer` | `/loops note-organizer` |
| 综合研究 | `research-synthesis-loop` | `/loops research-synthesis-loop` |
| 整理会议纪要 | `meeting-notes-cleaner` | `/loops meeting-notes-cleaner` |
| 收件箱清零 | `inbox-zero-loop` | `/loops inbox-zero-loop` |
| 任务优先级 | `task-prioritizer` | `/loops task-prioritizer` |
| 每周回顾 | `weekly-review-loop` | `/loops weekly-review-loop` |

### 系统与安全

| 你想做什么 | 使用的 Loop | 示例 |
|-----------|------------|------|
| 构建Docker镜像 | `docker-build-until-green` | `/loops docker-build-until-green` |
| 检查Terraform | `terraform-plan-until-clean` | `/loops terraform-plan-until-clean` |
| 检测日志异常 | `log-anomaly-detector` | `/loops log-anomaly-detector` |
| 监控SSL证书 | `ssl-certificate-monitor` | `/loops ssl-certificate-monitor` |
| 扫描密钥泄露 | `secret-scan-loop` | `/loops secret-scan-loop` |
| 合规检查 | `compliance-checklist-loop` | `/loops compliance-checklist-loop` |
| 审查访问权限 | `access-review-loop` | `/loops access-review-loop` |

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
/loops autoloop-tdd

# 3. 用Loop自我审查
/loops pr-self-review

# 4. 提交并推送
git commit -am "feat: add new stuff"
git push origin feature/new-stuff

# 5. 确保CI通过
/loops fix-ci-until-green
```

---

## 8. 故障排除

### 8.1 Agent 不识别 Loop 命令

**现象**：输入 `/loops test-until-green` 后 Agent 没有按 Loop 执行。

**解决**：
1. **Claude Code**：确认 `~/.claude/skills/loops/SKILL.md` 存在（官方自动发现）；或在对话中粘贴 `SKILL.md` 内容；或用 `claude --append-system-prompt "$(cat ~/.loops/SKILL.md)"` 启动。
2. **Claude Code 命名冲突**：若 `/loops xxx` 触发的是 Claude Code 内置的 `/loop` 而非本仓库，确认 skill 目录命名是 `loops`（不是 `loop`），或直接用自然语言描述需求。
3. **Trae**：检查 `~/.trae/skills/loops/` 是否存在 `SKILL.md` 和 `prompts/`。
4. **Cursor**：检查 `.cursor/rules/loops.mdc` 是否存在（旧版 `.cursorrules` 已废弃）。
5. **Windsurf**：检查项目根的 `.windsurfrules` 是否存在。
6. **Cline**：检查项目根的 `.clinerules` 是否存在。
7. **Codex**：检查 `~/.codex/AGENTS.md` 或项目根的 `AGENTS.md` 是否配置了 Loops（Codex 用自然语言调用，无斜杠命令）。
8. 都不行时，用 [§2.7 直接复制提示词](#27-直接复制提示词去任意-agent) 把 Loop 文件全文粘进对话框。

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


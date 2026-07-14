#!/usr/bin/env bash
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOOPS_HOME="$HOME/.loops"

usage() {
  cat <<'USAGE'
用法:
  ./install.sh                      为所有「全局」Agent 安装 Loops（Claude Code / Trae / Codex / Windsurf）
  ./install.sh --project <目录>     在上面基础上，再为指定项目写入 Cursor / Cline / Windsurf 的项目级规则

说明:
  - 会把本仓库软链到 ~/.loops，使各 Agent 都能读到 ~/.loops/prompts/zh/ 下的提示词。
  - 已安装的内容会跳过（用 # >>> Loops 标记做幂等判断），可重复运行。
USAGE
}

PROJECT=""
while [ $# -gt 0 ]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2;;
    -h|--help) usage; exit 0;;
    *) echo "未知参数: $1"; usage; exit 1;;
  esac
done

install_global() {
  if [ ! -e "$LOOPS_HOME" ]; then
    ln -sfn "$SRC" "$LOOPS_HOME"
  fi
  echo "==> Loops 仓库已链接到 $LOOPS_HOME"

  mkdir -p "$HOME/.claude/skills"
  ln -sfn "$LOOPS_HOME" "$HOME/.claude/skills/loops"
  echo "==> Claude Code : ~/.claude/skills/loops"

  mkdir -p "$HOME/.trae/skills" "$HOME/.trae-cn/skills"
  ln -sfn "$LOOPS_HOME" "$HOME/.trae/skills/loops"
  ln -sfn "$LOOPS_HOME" "$HOME/.trae-cn/skills/loops"
  echo "==> Trae       : ~/.trae/skills/loops 与 ~/.trae-cn/skills/loops"

  mkdir -p "$HOME/.codex"
  if ! grep -q "# >>> Loops" "$HOME/.codex/AGENTS.md" 2>/dev/null; then
    cat >> "$HOME/.codex/AGENTS.md" <<'EOF'

# >>> Loops (请勿手动删除此标记)
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析、学习管理等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后严格按 Loop 的"执行→检查→修复→重复"模式执行任务。常用 Loop：test-until-green、fix-ci-until-green、lint-typecheck-fix、pr-self-review、autoloop-tdd、docs-sync-after-edits。
# <<< Loops
EOF
  fi
  echo "==> Codex      : ~/.codex/AGENTS.md"

  mkdir -p "$HOME/.codeium/windsurf/memories"
  if ! grep -q "# >>> Loops" "$HOME/.codeium/windsurf/memories/global_rules.md" 2>/dev/null; then
    cat >> "$HOME/.codeium/windsurf/memories/global_rules.md" <<'EOF'

# >>> Loops (请勿手动删除此标记)
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。
# <<< Loops
EOF
  fi
  echo "==> Windsurf   : ~/.codeium/windsurf/memories/global_rules.md"
}

install_project() {
  local proj="$1"
  mkdir -p "$proj"

  mkdir -p "$proj/.cursor/rules"
  cat > "$proj/.cursor/rules/loops.mdc" <<'EOF'
---
description: Loops 自动化循环集合。当用户需要自动化测试、CI修复、代码质量、内容创作、数据分析等任务时按 Loop 模式执行。
globs:
  - "**/*"
alwaysApply: false
---

# Loops Skill
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析、学习管理等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按照 Loop 的"执行→检查→修复→重复"模式执行任务。
调用方式：`/loops <name>`（复数，避免与内置冲突）。
常用：/loops test-until-green、/loops fix-ci-until-green、/loops lint-typecheck-fix、/loops pr-self-review
EOF

  cat > "$proj/.clinerules" <<'EOF'
# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。
调用方式：/loops <name>（复数，避免与 Claude Code 内置 /loop 冲突）。
常用：/loops test-until-green、/loops fix-ci-until-green、/loops lint-typecheck-fix、/loops pr-self-review
EOF

  mkdir -p "$proj/.windsurf/rules"
  cat > "$proj/.windsurf/rules/loops.md" <<'EOF'
---
description: Loops 自动化循环集合。当用户需要自动化测试、CI修复、代码质量、内容创作、数据分析等任务时按 Loop 模式执行。
trigger: model_decision
---

# Loops Skill 配置
你是一名熟练使用 Loops 的 AI 开发助手。当用户要求自动化测试、CI修复、代码质量检查、内容创作、数据分析等任务时，请先读取 `~/.loops/prompts/zh/` 目录中的对应 Loop 提示词，然后按 Loop 的"执行→检查→修复→重复"模式执行。
EOF
  echo "==> 项目级规则已写入: $proj (.cursor/rules/loops.mdc, .clinerules, .windsurf/rules/loops.md)"
}

install_global
if [ -n "$PROJECT" ]; then
  install_project "$PROJECT"
fi
echo ""
echo "完成。下一步：在 Claude Code / Trae 输入 /loops test-until-green，或在 Codex / Cursor / Cline / Windsurf 用自然语言描述 Loop 需求。"

# Loops - AI-Powered Development Automation Loops Collection

> A curated collection of AI-powered development loops for automating software development tasks.

[中文说明](README.md) | [English README](README_EN.md)

---

## What is a Loop?

**Loop** is an automated workflow instruction set for AI programming assistants (like Claude Code, Cursor). It enables AI to autonomously complete development tasks through a "execute → check → fix → repeat" closed-loop pattern until a preset goal is achieved.

### Core Concepts of Loops

| Concept | Description |
|---------|-------------|
| **Goal** | The final state the Loop aims to achieve |
| **Check Command** | Command to verify if the goal is met |
| **Max Iterations** | Maximum number of iterations to prevent infinite loops |
| **Exit Condition** | When to stop (usually when check command returns success) |
| **Steps** | Specific operations for each iteration |

### Loop vs Traditional Instructions

| Traditional Instruction | Loop |
|------------------------|------|
| "Fix all lint errors" | Run lint → Fix minimal diff → Run again → Repeat until clean |
| "Fix CI" | Check CI status → Read logs → Reproduce locally → Fix → Push → Verify |
| One-time task | **Closed-loop automation** |

---

## When to Use Loops?

Use Loops when you need:

- **Continuous Iteration** - Tasks that require repeated check, fix, re-check cycles
- **Quality Gates** - Keep code, builds, and tests in a healthy state
- **Workflow Automation** - Reduce repetitive manual operations
- **CI/CD Integration** - Automatically fix failing CI builds

### Common Scenarios

```
✅ Run tests until all pass
✅ Fix CI failures and verify
✅ TDD development workflow
✅ Code review and refactoring
✅ Dependency management and security audits
✅ API contract validation
✅ Deployment verification
❌ Simple one-time Q&A
❌ Creative design work
```

---

## How to Use Loops?

### Method 1: Use on Loops! Website

Visit [https://loops.elorm.xyz/loops](https://loops.elorm.xyz/loops) to browse, search, and install the Loops you need.

### Method 2: Use in Claude Code / Cursor

```
/loop <loop-name>
```

For example:
```
/loop test-until-green
/loop fix-ci-until-green
/loop pr-self-review
```

### Method 3: Local Use

Paste Loop instructions into your preferred AI programming assistant and follow its check commands.

---

## Loop Categories Overview

| Category | Description | Count |
|----------|-------------|-------|
| [Testing](#testing--testing) | Automated testing, quality assurance | 7 |
| [CI/CD](#cicd--cicd) | Continuous integration and deployment automation | 9 |
| [Code Quality](#code-quality--code-quality) | Lint, format, type checking | 4 |
| [API/Specs](#apispecs--apispecs) | API contract and spec validation | 2 |
| [Dependencies](#dependencies--dependencies) | Dependency upgrades and audits | 4 |
| [Security](#security--security) | Security audits and vulnerability fixes | 3 |
| [Development Process](#development-process--development-process) | Development methodology and workflows | 5 |
| [Documentation](#documentation--documentation) | Documentation sync and updates | 1 |
| [Performance](#performance--performance) | Performance optimization | 1 |
| [Accessibility](#accessibility--accessibility) | Accessibility checks | 1 |
| [Pull Request](#pull-request--pull-request) | PR management and collaboration | 2 |
| [Maintenance](#maintenance--maintenance) | Routine maintenance tasks | 1 |

---

## Complete Loop List

### Testing

#### 1. test-until-green
**Goal:** All tests pass
```bash
npm test
```
Run tests, fix the smallest root cause, repeat until all tests pass.
```bash
# Usage
/loop test-until-green
```

#### 2. e2e-until-green
**Goal:** E2E test suite passes
```bash
npm run test:e2e
```
Run E2E tests, fix the first failing spec, repeat until all pass.
```bash
# Usage
/loop e2e-until-green
```

#### 3. flaky-test-triage
**Goal:** Classify failing tests as flaky or real, fix only confirmed regressions
```bash
npm test -- --testPathPattern=<failing-suite>
```
Run failing test suite multiple times, classify each failure, fix real ones, document flaky behavior.
```bash
# Usage
/loop flaky-test-triage
```

#### 4. visual-regression-until-match
**Goal:** Visual regression tests pass with intentional UI changes only
```bash
npx playwright test --grep @visual
```
Run visual tests, fix unintended UI diffs; update baselines only for deliberate design changes.
```bash
# Usage
/loop visual-regression-until-match
```

#### 5. coverage-until-threshold
**Goal:** Coverage meets target threshold (default 80%) with all tests passing
```bash
npm test -- --coverage
```
Run coverage, add focused tests for biggest uncovered gaps, repeat until threshold is met.
```bash
# Usage
/loop coverage-until-threshold
```

#### 6. staging-smoke-test
**Goal:** Staging smoke checklist passes
```bash
npm run smoke:staging
```
Run staging smoke checklist, fix the first failing item, repeat until passing.
```bash
# Usage
/loop staging-smoke-test
```

#### 7. post-edit-test-guard
**Goal:** After each batch of file edits, related tests must pass before continuing
```bash
npm test -- --findRelatedTests <edited files>
```
After edits, run related tests. If they fail, fix before making more changes.
```bash
# Usage
/loop post-edit-test-guard
```

---

### CI/CD

#### 8. ship-pr-until-green
**Goal:** PR is open with all CI checks passing
```bash
gh pr checks
```
Implement change, test locally, push, open PR, fix CI until all pass.
```bash
# Usage
/loop ship-pr-until-green
```

#### 9. fix-ci-until-green
**Goal:** Latest CI run on current branch passes
```bash
gh run list --branch $(git branch --show-current) --limit 1 --json conclusion -q '.[0].conclusion'
```
Find latest failed CI run, read logs, reproduce locally, fix root cause, push, verify.
```bash
# Usage
/loop fix-ci-until-green
```

#### 10. ci-failure-watcher
**Goal:** Latest CI run on current branch is green
```bash
gh run list --branch $(git branch --show-current) --limit 1
```
Check CI status, if failed read logs, fix root cause, verify locally, push if needed.
```bash
# Usage
/loop ci-failure-watcher
```

#### 11. build-until-green
**Goal:** Production build succeeds
```bash
npm run build
```
Run build, if it fails fix the first error, repeat until green.
```bash
# Usage
/loop build-until-green
```

#### 12. pre-commit-guard
**Goal:** Block git commits when tests are failing
```bash
npm test
```
Before any git commit, run tests, fix failures before committing.
```bash
# Usage
/loop pre-commit-guard
```

#### 13. pr-self-review
**Goal:** Three clean self-review passes on the current diff
```bash
git diff main...HEAD
```
Review the diff like a senior reviewer, fix findings, then re-review.
```bash
# Usage
/loop pr-self-review
```

#### 14. pr-babysitter
**Goal:** PRs labeled codex-watch are healthy (CI green, rebased, not stale)
```bash
gh pr list --label "codex-watch"
```
List watched PRs, fix CI once, rebase if behind, comment if stale. Escalate repeated failures.
```bash
# Usage
/loop pr-babysitter
```

#### 15. pr-watch-loop
**Goal:** Keep codex-watch PRs healthy and unblocked
```bash
gh pr list --label codex-watch --json number,title,state,statusCheckRollup
```
List codex-watch PRs, check CI and reviews, report or fix trivial blockers.
```bash
# Usage
/loop pr-watch-loop
```

#### 16. spec-first-ship
**Goal:** Every requirement in spec.md is implemented and checked off
```bash
npm test
```
Read spec.md, implement the first unchecked item, verify it, mark [x], stop this iteration.
```bash
# Usage
/loop spec-first-ship
```

---

### Code Quality

#### 17. lint-typecheck-fix
**Goal:** Lint and typecheck are clean
```bash
npm run lint && npx tsc --noEmit
```
Run lint and typecheck, fix reported issues with minimal diffs, repeat.
```bash
# Usage
/loop lint-typecheck-fix
```

#### 18. format-until-clean
**Goal:** Formatter runs cleanly with no remaining diff
```bash
npm run format
```
Run formatter, fix any issues it cannot auto-fix, repeat.
```bash
# Usage
/loop format-until-clean
```

#### 19. de-sloppify-pass
**Goal:** Recent changes are clean, minimal, and convention-aligned
```bash
npm run lint && npm test
```
Review diff for debug code, dead branches, naming issues, fix with minimal diffs.
```bash
# Usage
/loop de-sloppify-pass
```

#### 20. knip-until-clean
**Goal:** Knip reports no unused code or dependencies
```bash
npx knip
```
Run knip, remove dead exports and unused deps with minimal diffs, verify tests still pass.
```bash
# Usage
/loop knip-until-clean
```

---

### API/Specs

#### 21. api-contract-until-match
**Goal:** API implementation matches the published contract
```bash
npm run test:contract
```
Run contract tests, fix each schema/response mismatch with minimal diffs, re-run.
```bash
# Usage
/loop api-contract-until-match
```

#### 22. openapi-sync-until-valid
**Goal:** openapi.yaml lints clean and matches implemented routes
```bash
npx @redocly/cli lint openapi.yaml
```
Lint openapi.yaml, fix spec errors and handler drift until lint passes.
```bash
# Usage
/loop openapi-sync-until-valid
```

---

### Dependencies

#### 23. dependency-upgrade-one-by-one
**Goal:** Critical outdated deps upgraded with green tests
```bash
npm outdated && npm test && npm run build
```
Pick one outdated package, upgrade it, fix breakages, commit, stop. One package per iteration.
```bash
# Usage
/loop dependency-upgrade-one-by-one
```

#### 24. migration-until-applied
**Goal:** All database migrations apply cleanly
```bash
npx prisma migrate status
```
Run migrations, fix schema or SQL errors, repeat until status is clean.
```bash
# Usage
/loop migration-until-applied
```

#### 25. dependency-audit-weekly
**Goal:** Deliver weekly dependency audit summary
```bash
npm outdated || true
```
Run npm outdated, categorize updates, propose safe upgrade plan.
```bash
# Usage
/loop dependency-audit-weekly
```

#### 26. npm-audit-fix-loop
**Goal:** No high or critical npm audit vulnerabilities
```bash
npm audit --audit-level=high && npm test
```
Pick one high/critical advisory, apply safest fix, run tests, repeat.
```bash
# Usage
/loop npm-audit-fix-loop
```

---

### Security

#### 27. security-audit-weekly
**Goal:** Deliver weekly npm audit summary with remediation plan
```bash
npm audit --json
```
Run npm audit, triage by severity, propose safe remediation steps.
```bash
# Usage
/loop security-audit-weekly
```

---

### Development Process

#### 28. autoloop-tdd
**Goal:** Implement target behavior test-first with green suite
```bash
npm test
```
Write a failing test for the next behavior, implement minimum code to pass, refactor, repeat.
```bash
# Usage
/loop autoloop-tdd
```

#### 29. changelog-sync-after-ship
**Goal:** CHANGELOG.md has accurate [Unreleased] entries
```bash
git log -5 --oneline
```
Review recent commits, write Keep-a-Changelog entries for user-visible changes, verify completeness.
```bash
# Usage
/loop changelog-sync-after-ship
```

#### 30. investigation-script-loop
**Goal:** Prove the root cause with a minimal repro script
```bash
node scripts/investigate.mjs
```
Write a tiny throwaway script that reproduces the issue, run it, iterate on output.
```bash
# Usage
/loop investigation-script-loop
```

#### 31. ralph-story-executor
**Goal:** Every story in .ralph/prd.json has passes: true
```bash
npm test && npm run lint && npm run build
```
Read .ralph/prd.json and .ralph/progress.md, pick one incomplete story, implement it, run backpressure checks, commit, update prd.json and progress.md, stop this iteration.
```bash
# Usage
/loop ralph-story-executor
```

#### 32. reflexion-debug-loop
**Goal:** The failing test or repro passes
```bash
npm test -- --testNamePattern=<failing-test>
```
Reproduce the bug. If it fails, append a reflection to .loops/reflexion.md before trying a new fix.
```bash
# Usage
/loop reflexion-debug-loop
```

---

### Documentation

#### 33. docs-sync-after-edits
**Goal:** Documentation matches the current code changes
```bash
git diff main...HEAD --name-only
```
Review the diff, find stale docs, update them, verify accuracy.
```bash
# Usage
/loop docs-sync-after-edits
```

---

### Performance

#### 34. bundle-size-budget
**Goal:** Client bundle stays under the size-limit budget
```bash
npm run build && npm run size-limit
```
Build and measure bundle size, if over budget lazy-load or trim deps until size-limit passes.
```bash
# Usage
/loop bundle-size-budget
```

---

### Accessibility

#### 35. a11y-audit-until-clean
**Goal:** Zero serious accessibility violations on changed UI
```bash
npm run test:a11y
```
Run a11y audit on changed routes, fix each violation, prioritize keyboard and screen reader issues.
```bash
# Usage
/loop a11y-audit-until-clean
```

---

### Pull Request

#### 36. merge-conflict-resolver
**Goal:** Branch is rebased on main with no conflicts and tests pass
```bash
npm test
```
Rebase on main, resolve conflicts one file at a time, run tests, continue.
```bash
# Usage
/loop merge-conflict-resolver
```

#### 37. post-merge-regression-guard
**Goal:** Smoke tests pass immediately after every merge or rebase
```bash
npm run test:smoke
```
After a merge, run smoke tests, fix regressions before continuing other work.
```bash
# Usage
/loop post-merge-regression-guard
```

---

### Deployment

#### 38. deploy-verification-loop
**Goal:** All post-deploy health and smoke endpoints return success
```bash
curl -fsS <your-health-url>
```
Hit health/smoke URLs, if any fail inspect deploy logs, fix or escalate.
```bash
# Usage
/loop deploy-verification-loop
```

---

### Maintenance

#### 39. independent-verifier-pass
**Goal:** Build, lint, and tests pass under independent verification
```bash
npm run build && npm run lint && npm test
```
Run build, lint, and tests as a verifier. Trust only command output, not prior claims.
```bash
# Usage
/loop independent-verifier-pass
```

---

### Hooks

#### 40. guardrails-learning-loop
**Goal:** Tests and lint pass without repeating prior failure patterns
```bash
npm test && npm run lint
```
Read .ralph/guardrails.md, run checks, if a failure repeats add a sign before fixing.
```bash
# Usage
/loop guardrails-learning-loop
```

---

## How to Create Your Own Loop?

### Loop Structure

A Loop consists of:

```
Name
├── Goal - The final state the Loop aims to achieve
├── Check Command - Command to verify if the goal is met
├── Max Iterations - Maximum iterations to prevent infinite loops
├── Exit Condition - When to stop successfully
├── Steps - Specific operations for each iteration
└── Recommended Agents - Suitable AI programming assistants
```

### Creation Steps

1. **Define the Goal** - What do you want to automate?
2. **Design the Check Command** - How to verify goal achievement?
3. **Write the Steps** - How should the AI iterate?
4. **Set Exit Conditions** - When to stop?
5. **Test Your Loop** - Verify in real scenarios

### Example Loop

```markdown
### My Custom Loop

**Goal:** Code formatting is clean

**Check Command:**
\`\`\`bash
npm run format && git diff --exit-code
\`\`\`

**Exit Condition:** git diff is empty (no formatting changes needed)

**Steps:**
Step 1: Run the formatter command.
Step 2: Check git diff, if there are changes commit them.
Step 3: Repeat until no changes.

**Recommended Agents:** Claude Code, Cursor
```

---

## Installation and Usage

### Install as a Skill

Copy `SKILL.md` and the `prompts/` directory into your project's Trae Skill location:

```bash
cd your-project
mkdir -p .trae/skills/loops
cp /path/to/loops/SKILL.md .trae/skills/loops/
cp -r /path/to/loops/prompts .trae/skills/loops/
```

> Note: The `.trae/` directory is local IDE configuration and should not be committed to version control.

### Use Individual Loops

```bash
# In Claude Code
/load /path/to/loops/SKILL.md
/loop test-until-green

# In Cursor
@loop test-until-green
```

---

## Related Resources

- [Loops! Official Website](https://loops.elorm.xyz/loops)
- [Prompts Directory (EN)](prompts/en/)
- [Prompts Directory (ZH)](prompts/zh/)
- [Skills Installation Guide](https://skills.sh/)

---

## Contributing

Welcome to submit new Loops! Please ensure:

1. Loop has a clear goal and verifiable exit condition
2. Check command is deterministic
3. Has appropriate max iterations to prevent infinite loops
4. Includes Chinese and English descriptions

---

**License:** MIT
**Maintainer:** loops!
**Version:** 1.0.0

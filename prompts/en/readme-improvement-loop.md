---
name: "readme-improvement-loop"
description: "README is clear, complete, and follows best practices"
---

# README Improvement Loop

**Category:** Documentation
**Slug:** `readme-improvement-loop`
**Max Iterations:** 8

## Goal

Make the README pass lint and be genuinely useful to readers: install steps that run, examples you can copy and execute, and feature descriptions that match the code's actual behavior. Success means the check command exits cleanly.

## When to Use

Use when the README is missing key sections, when command examples are outdated or disagree with reality, and you need to complete and calibrate it.

## Check Command

```bash
python scripts/readme_lint.py
```

## Exit Condition

- The check command completes with exit code 0 and no lint errors.
- All necessary sections are present (intro, install, usage, license, etc., as fits the project).
- Features, commands, and examples described in the docs match the code's actual behavior.

## Steps

Step 1: Run the check command, capturing every lint error and warning with its location.
Step 2: Analyze the issues—distinguish missing structure (absent sections/headings), inaccurate content (commands that don't run/changed parameters), non-executable examples, and dead badges or links.
Step 3: Make the smallest fix: add the section, correct the command and example; never describe features that don't exist or aren't yet implemented just to pass lint.
Step 4: Re-run the check command; if errors remain and you're under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining lint error list; never loop forever.

## Common Pitfalls

- Documenting features that are unimplemented or already removed, misleading readers.
- Install commands that run on your machine but omit prerequisites/runtime, so readers following them fail.
- Example code inconsistent with the repo's actual paths or API, failing on copy-paste.
- Badges pointing to defunct CI/coverage services, leaving broken links.

## Notes

- Treat the code's actual behavior as the source of truth; when in doubt read the source instead of copying old descriptions.
- Don't overstate capabilities or promise features still on the roadmap.
- When editing command examples, verify they actually execute.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

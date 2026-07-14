---
name: "ralph-story-executor"
description: "Make every story reach passes: true"
---

# Ralph Story Executor

**Category:** Development Process
**Slug:** `ralph-story-executor`
**Max Iterations:** 20

## Goal

Advance each incomplete story from `.rhal/prd.json` one by one until every story has status `passes: true`. Each completed story must keep tests, lint, and build green at the same time.

## When to Use

The project drives a story list via `.rhal/prd.json` and stories must be implemented in order and accepted by a single check command.

## Check Command

```bash
npm test && npm run lint && npm run build
```

## Exit Condition

- Every story in `.rhal/prd.json` is marked `passes: true`.
- The check command passes in one run: no failures, no lint errors, build succeeds.

## Steps

Step 1: Read `.rhal/prd.json` and list every story with its current status.
Step 2: Pick the next story whose `passes` is not `true` and confirm its acceptance criteria and dependencies.
Step 3: Implement the minimal code that story needs; do not add functionality outside the story scope.
Step 4: Run the check command; on success set the story to `passes: true`, then return to Step 2 for the next story.
Step 5: If max iterations are hit with stories still not passing, stop and report the remaining stories and their failure reasons; never loop forever.

## Common Pitfalls

- Marking a story `passes: true` before the check command is fully green, leaving status out of sync with reality.
- Implementing several stories at once so the failing one can't be located.
- Treating tests-only as done while ignoring lint or build failures.
- Hard-coding a story's output to pass tests and breaking later stories' implementation.

## Notes

- Advance strictly in order to avoid conflicts from parallel implementation.
- Story status changes must be traceable so a single story's implementation can be rolled back.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

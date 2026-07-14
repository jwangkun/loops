---
name: "component-scaffold-loop"
description: "scaffold a component with tests and stories"
---

# Component Scaffold Loop

**Category:** Code Generation
**Slug:** `component-scaffold-loop`
**Max Iterations:** 5

## Goal

Produce a complete, runnable scaffold for the named component: the implementation file, its test, and showcase stories, with the check command passing. The output must follow the directory structure and naming conventions of existing project components.

## When to Use

When creating a new UI component that should immediately ship with tests and visual stories; pass the name as `<component-name>`.

## Check Command

```bash
npm test -- <component-name>
```

## Exit Condition

- Component implementation, test, and stories files all exist.
- Tests pass and the check command exits with code 0.
- Structure and naming are consistent with existing project components.

## Steps

Step 1: Reference the closest existing component, run the check command to establish the scaffold baseline, and capture missing files and failures.
Step 2: Identify the component's props/state and render variants; from these, list test cases and the showcase scenarios for stories.
Step 3: Generate the implementation, tests, and stories, reusing existing project patterns (styling approach, exports, type definitions).
Step 4: Re-run the check command; if failures or missing pieces remain and max iterations is not reached, go to Step 2 to fix them.
Step 5: If max iterations is reached with items unresolved, stop and report the missing files and failing tests; never leave half-finished work or fool the check with empty implementations.

## Common Pitfalls

- Ignoring existing conventions: inventing new directory/naming/styling so the component can't be consumed by the project.
- Stories showing only one state: omitting key prop variants makes visual regression meaningless.
- Tests that only assert "renders without throwing": no real DOM/behavior assertions, so they miss real regressions.

## Notes

- Prefer mimicking existing components over introducing new dependencies.
- The component must be type-safe and clearly exported for import by other modules.
- Do not leave TODOs or empty stubs just to pass the check.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

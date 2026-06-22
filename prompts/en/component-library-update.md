---
name: "component-library-update"
description: "component library gains new variants and docs, Storybook build passes"
---

# Component Library Update

**Category:** Frontend
**Slug:** `component-library-update`
**Max Iterations:** 8

## Goal

Add or adjust component variants in the component library and keep the matching story, props documentation, and usage examples in sync. The final Storybook static build must pass with zero errors, and the new variants must be discoverable and reusable by consumers.

## When to Use

Use when adding new component shapes to a design system (e.g. new size, state, or theme variants) or when filling in missing variant documentation.

## Check Command

```bash
npm run storybook:build
```

## Exit Condition

- `npm run storybook:build` exits with code 0.
- Storybook console shows no errors, only acceptable warnings.
- New variants appear in the relevant story and render correctly.

## Steps

Step 1: Run `npm run storybook:build` and capture the full build log.
Step 2: Analyze failures — common causes: missing/mis-exported story files, props type mismatches, MDX syntax errors, wrong asset paths. Locate each one.
Step 3: Make the smallest fix: implement the variant source and props first, then update the story (`args`/`argTypes`) and MDX docs. Never paper over build errors with `// eslint-disable` or commented-out code.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go back to Step 2.
Step 5: If max iterations are reached without success, stop and report the remaining build errors; never loop forever.

## Common Pitfalls

- Changing component source but forgetting to sync story `args`/`argTypes`, leaving the docs panel empty or type-erroring.
- Tokens/styles the new variant depends on are not exported — build passes but runtime rendering is broken; verify visually in a browser.
- MDX referencing unimported components or bad frontmatter causes `storybook:build` to fail silently.
- Hard-coding values that should come from props, which defeats the purpose of the documentation example.

## Notes

- Keep the component API backward compatible; if a breaking change is unavoidable, update all call sites and the changelog together.
- Do not delete legitimate stories or variants just to make the build pass.
- Modify only files related to the target variant; avoid large unrelated churn.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

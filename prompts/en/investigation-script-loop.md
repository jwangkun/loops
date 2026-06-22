---
name: "investigation-script-loop"
description: "pinpoint root cause with a minimal repro script"
---

# Investigation Script Loop

**Category:** Development Process
**Slug:** `investigation-script-loop`
**Max Iterations:** 10

## Goal

Use a minimal, standalone, repeatable investigation script to genuinely trigger and reproduce the root cause of an issue, not stop at the hypothesis stage. The script should emit observable evidence that validates the root cause.

## When to Use

For hard-to-explain bugs or behavioral anomalies where you must reproduce before you can localize; not for cases already reliably reproducible that just need a direct fix.

## Check Command

```bash
node scripts/investigate.mjs
```

## Exit Condition

- The investigation script reliably reproduces the target issue.
- The output clearly points to an explainable root cause.
- The reproduction still holds after irrelevant variables are removed.

## Steps

Step 1: Run the check command, capture current output, and determine whether the issue is actually triggered and whether the script runs at all.
Step 2: Analyze the output and the failure symptom, isolate the most suspicious hypothesis, and confirm whether the script genuinely hits the problem or merely restates an assumption.
Step 3: Make the smallest change: narrow the reproduction scope, remove unrelated code, or add observable logging so the script triggers and exposes the root cause more precisely.
Step 4: Re-run the check command; if the issue is not yet reliably reproduced and max iterations is not reached, go to Step 2 to revise the hypothesis.
Step 5: If max iterations is reached without reproduction, stop and report the hypotheses ruled out, the current blockers, and a recommended next step; never loop endlessly or fabricate a root cause.

## Common Pitfalls

- Substituting a hypothetical repro for a real trigger: the script constructs data from speculation and never actually hits the defective code path.
- Reproduction depends on too much context: pulling in the whole application state makes the real trigger impossible to isolate.
- Treating "the script no longer errors" as "the bug is fixed": a clean script run does not equal a confirmed root cause.

## Notes

- The investigation script is a temporary probe; keep it separate from fix code and clean it up once validated.
- Prefer experiments that can falsify a hypothesis over ones that only gather supporting evidence.
- Do not modify the system under test or loosen observability just to make the script "pass".

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

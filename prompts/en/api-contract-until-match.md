---
name: "api-contract-until-match"
description: "API implementation matches published contract"
---

# API Contract Until Match

**Category:** API/Specs
**Slug:** `api-contract-until-match`
**Max Iterations:** 10

## Goal

Make the actual API implementation (request/response schemas, status codes, field types) fully match the published consumer contracts. All contract tests pass so consumers experience no unexpected breakage on upgrade.

## When to Use

Use when you have consumer-driven contract tests (e.g. Pact) and need to confirm that implementation-side changes have not violated them. Also for pre-release regression checks before shipping a new API version.

## Check Command

```bash
npm run test:contract
```

## Exit Condition

- `npm run test:contract` exits 0.
- No contract verification failures (schema mismatch, missing fields, wrong status codes).
- All consumer contracts pass validation.

## Steps

Step 1: Run `npm run test:contract`, capture full output, and record the failing contracts, the affected consumers, and missing or mistyped fields.
Step 2: Analyze each failure to decide whether the contract is stale or the implementation drifted; assume the implementation is wrong by default and only edit the contract when it is genuinely incorrect, then notify affected consumers.
Step 3: Apply the smallest fix: add missing fields, correct types and status codes, adjust required flags; never fabricate data to mask a failure.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining failing contracts and blockers; never loop forever.

## Common Pitfalls

- Changing the contract to accommodate a broken implementation just to go green — fix the implementation first.
- Fixing only the first failure and ignoring the rest, so the same root cause recurs.
- Overlooking nullability/required differences in contract fields.
- Editing the contract without notifying downstream consumers, causing silent breakage.

## Notes

- Never delete or bypass a failing contract test.
- Distinguish consumer-driven contracts from provider self-tests; semantics differ.
- Editing a contract is a breaking change and must follow versioning and notification.
- If a failure stems from a genuinely stale contract, record the reason before updating.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

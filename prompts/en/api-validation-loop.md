---
name: "api-validation-loop"
description: "all API inputs validated and sanitized"
---

# API Validation Loop

**Category:** Backend
**Slug:** `api-validation-loop`
**Max Iterations:** 8

## Goal

Ensure every API endpoint runs strict schema validation and input sanitization on bodies, query params, path params, and headers before any business logic — invalid input is rejected early and never reaches downstream code.

## When to Use

Use when newly added endpoints lack validation, or when a security scan or review surfaces unvalidated input entry points. Also for input-safety hardening before release.

## Check Command

```bash
npm run test:api-validation
```

## Exit Condition

- `npm run test:api-validation` exits 0.
- Every public endpoint has schema validation middleware mounted.
- Invalid-input test cases (wrong types, oversize, injection chars) return 4xx.

## Steps

Step 1: Run `npm run test:api-validation`, recording failing cases, unvalidated endpoint paths, and missing validation types.
Step 2: Cross-check against the route inventory to find endpoints lacking validation middleware, or validated but with uncovered fields or no sanitization.
Step 3: Apply the smallest fix: add schema validation (e.g. zod/joi/express-validator) to each missing endpoint, plus input sanitization (trim, escape, length cap); do not patch with ad-hoc checks inside business logic.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining unvalidated endpoints and failing cases; never loop forever.

## Common Pitfalls

- Validating only the body and ignoring query, path, or header params.
- Validating but never sanitizing, leaving downstream exposed to injection.
- Using loose types (any, unconstrained string) that make the schema meaningless.
- Covering only valid inputs in tests and skipping the invalid-input rejection path.

## Notes

- Validation must run before business logic; reject as early as possible.
- Separate validation (structural correctness) from sanitization (content safety); both are needed.
- Do not swallow validation errors in try/catch just to "pass".
- Sensitive fields (IDs, monetary amounts) need extra range and format constraints.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

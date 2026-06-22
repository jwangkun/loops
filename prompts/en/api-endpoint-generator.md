---
name: "api-endpoint-generator"
description: "generate an API endpoint with tests from spec"
---

# API Endpoint Generator

**Category:** Code Generation
**Slug:** `api-endpoint-generator`
**Max Iterations:** 8

## Goal

Generate a complete, working API endpoint from an interface spec: the handler, route registration, and its tests, with the check command passing. The implementation must cover auth/validation, error responses, and the agreed status codes.

## When to Use

When you hold a concrete interface spec (path, method, inputs, outputs, status codes, auth) and want to generate the endpoint end-to-end; not for cases where the spec is vague and needs exploratory design first.

## Check Command

```bash
npm run test:api
```

## Exit Condition

- Route, handler, and tests are all generated.
- All endpoint tests pass and the check command exits with code 0.
- Input validation and error status codes match the spec.

## Steps

Step 1: Run the check command, capture output, and identify the existing test structure and what parts of the endpoint are not yet generated.
Step 2: From the spec, enumerate the contract: path/method, body and query validation, success and each error status code, auth requirements; plan test cases accordingly.
Step 3: Generate the handler, route registration, and tests, reusing the project's existing middleware, error handling, and validation patterns.
Step 4: Re-run the check command; if cases still fail and max iterations is not reached, go to Step 2 to fix the implementation or add tests.
Step 5: If max iterations is reached with tests still failing, stop and report the failing cases and suspected spec inconsistencies; never loosen assertions or comment out tests.

## Common Pitfalls

- Testing only the success path: ignoring 4xx/5xx, validation failures, and auth denials leaves the endpoint unprotected.
- Reinventing error handling: bypassing the project's existing error middleware produces inconsistent response shapes.
- Disconnect between route and tests: tests never actually hit the new route, giving a false green signal.

## Notes

- Follow the spec's status codes and response shapes strictly; report spec contradictions rather than deciding unilaterally.
- Auth and validation must exist explicitly, never assumed to be handled upstream.
- Do not globally mock the database or auth layer just to make tests pass.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

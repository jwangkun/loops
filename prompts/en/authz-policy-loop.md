---
name: "authz-policy-loop"
description: "all sensitive endpoints enforce authorization"
---

# Authz Policy Loop

**Category:** Backend
**Slug:** `authz-policy-loop`
**Max Iterations:** 10

## Goal

Ensure every sensitive endpoint runs a correct authorization check (role/permission/resource ownership) after authentication. Unauthorized access is rejected with 403, and the authorization matrix tests all pass.

## When to Use

Use when newly added sensitive endpoints lack authorization checks, or when an audit surfaces privilege-escalation risk (horizontal/vertical). Also for permission hardening before release.

## Check Command

```bash
npm run test:authz
```

## Exit Condition

- `npm run test:authz` exits 0.
- Every sensitive endpoint has an explicit authorization check after authentication.
- Privilege-escalation tests (including horizontal: accessing another user's resources) return 403.

## Steps

Step 1: Run `npm run test:authz`, recording endpoints reachable without authorization, missing-check cases, and status-code mismatches.
Step 2: Audit each sensitive endpoint to confirm whether an authorization check runs after authentication, and check for horizontal escalation (user A accessing user B's resources) and vertical escalation (a normal user hitting admin routes).
Step 3: Apply the smallest fix: add authorization checks (role/permission/ownership) to missing endpoints and add the corresponding escalation test cases; do not conflate authorization with authentication.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining escalation risks and failing cases; never loop forever.

## Common Pitfalls

- Treating "logged in" (authentication) as "authorized" and skipping the actual check.
- Guarding only against vertical escalation and missing horizontal escalation (users accessing each other's resources).
- Putting authorization on the client/frontend while the backend does not validate.
- Using loose checks (e.g. only checking a field exists) instead of precise role/ownership checks.

## Notes

- Authorization must run on the backend, after authentication, before business logic.
- Resource-ownership checks must use non-forgeable server-side data (e.g. session user ID).
- Never relax authorization rules or comment out assertions just to pass tests.
- Default to deny: anything not explicitly allowed is rejected.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

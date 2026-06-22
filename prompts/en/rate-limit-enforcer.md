---
name: "rate-limit-enforcer"
description: "all public endpoints enforce rate limits"
---

# Rate Limit Enforcer

**Category:** Backend
**Slug:** `rate-limit-enforcer`
**Max Iterations:** 8

## Goal

Ensure every externally exposed public endpoint has a rate-limit policy mounted, tiered per endpoint, correctly returns 429 under load, and leaves zero endpoints unprotected.

## When to Use

Use when newly added public endpoints lack rate limiting, or when security/load testing reveals routes that can be called without bound. Also for protection hardening before release.

## Check Command

```bash
npm run test:rate-limit
```

## Exit Condition

- `npm run test:rate-limit` exits 0.
- Every public endpoint has rate-limit middleware mounted.
- Requests over the threshold return 429 reliably, with a Retry-After header.

## Steps

Step 1: Run `npm run test:rate-limit`, recording unprotected endpoints, mis-set thresholds, and cases that fail to return 429.
Step 2: Cross-check against the route inventory to confirm each route has rate limiting and that the dimension (IP/user/endpoint) and threshold are sensible.
Step 3: Apply the smallest fix: mount rate-limit middleware on missing endpoints, set thresholds by risk tier, and ensure the response conforms (429 + Retry-After); never limit only a subset of routes.
Step 4: Re-run the check command; if it still fails and you are under max iterations, go to Step 2.
Step 5: If max iterations are hit without success, stop and report the remaining unprotected endpoints and failing cases; never loop forever.

## Common Pitfalls

- Limiting only a few high-risk endpoints and leaving the rest of the public routes open.
- Wrong limit dimension (e.g. IP-only, bypassed via NAT/proxy).
- Thresholds too high (limiting is decorative) or too low (throttling legitimate users).
- Returning 429 without Retry-After, so clients cannot back off.

## Notes

- Rate limiting must cover all public entry points, including internal endpoints exposed externally.
- Differentiate limits for authenticated vs anonymous users.
- Never raise thresholds or disable limiting just to pass tests.
- In multi-instance deployments, counters must use shared storage (e.g. Redis).

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

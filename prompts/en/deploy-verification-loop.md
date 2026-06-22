---
name: "deploy-verification-loop"
description: "post-deploy health and smoke endpoints all pass"
---

# Deploy Verification Loop

**Category:** Deployment
**Slug:** `deploy-verification-loop`
**Max Iterations:** 5

## Goal

Confirm that after a deployment every health and smoke endpoint returns success, proving the new version is live and serving correctly. A single green check is not enough — verify the served version, not a cached or stale instance. Success means the check command exits 0 against all configured endpoints.

## When to Use

Immediately after a deploy, rollback, or config change, before declaring the release done.

## Check Command

```bash
curl -fsS <your-health-url>
```

## Exit Condition

- `curl -fsS <your-health-url>` exits 0.
- Health and smoke endpoints return the expected success status and body for the new version.

## Steps

Step 1: Run the check and capture the HTTP status, body, and any served version header; repeat for each health/smoke URL.
Step 2: If a check fails, read the deployment and application logs to locate the cause (failed rollout, bad config, missing dependency, crash loop); confirm you are hitting the new version, not a cached/old instance.
Step 3: Apply the smallest fix (correct config, restart pod, fix the deployed artifact); never paper over a failure by widening timeouts or pointing at a different URL.
Step 4: Re-run the check; if still failing and under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and recommend rollback rather than continuing to fix; never loop forever.

## Common Pitfalls

- The health endpoint returns 200 while the app is broken behind a CDN/cache, or old pods still serve traffic.
- Checking the load balancer health before the new replica set has taken real traffic.
- Time-bombed failures: the deploy looks healthy immediately but degrades minutes later (connection pool, cache warmup) — a single early check can be misleading.
- Smoke tests that only cover the happy path, missing a degraded downstream dependency.

## Notes

- Confirm the served build/version, not just a 2xx status, to avoid verifying a stale instance.
- Prefer rollback over more fix iterations when the failure is risky or unclear.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

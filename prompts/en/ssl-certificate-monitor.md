---
name: "ssl-certificate-monitor"
description: "all domains serve a valid SSL certificate"
---

# SSL Certificate Monitor

**Category:** System & DevOps
**Slug:** `ssl-certificate-monitor`
**Max Iterations:** 5

## Goal

Ensure every monitored domain presents a valid, trusted SSL certificate that is not near expiry. Expiring, mis-issued, or misconfigured certificates are renewed or fixed, and the renewed cert is confirmed actually live (including the served chain). Success means the check script exits 0.

## When to Use

On a recurring schedule to catch expiring certs, or after cert renewal/load-balancer changes to confirm the live certificate.

## Check Command

```bash
python scripts/ssl_check.py
```

## Exit Condition

- `python scripts/ssl_check.py` exits 0.
- Every domain has a valid, trusted certificate with sufficient remaining validity (not near expiry).

## Steps

Step 1: Run the check and capture the full output; list each domain with its expiry date, issuer, SANs, and any trust/chain errors.
Step 2: For each failing or near-expiry cert, identify the cause: pending renewal, wrong SAN, broken/missing intermediate chain, or a cert not yet deployed; watch for clock-skew false readings.
Step 3: Apply the smallest correct fix — trigger renewal, correct SAN/chain, or reload the serving component; never bypass the check by excluding a domain or loosening the expiry threshold.
Step 4: Re-run the check; if failures remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report the remaining failing domains with expiry and trust details; do not loop forever.

## Common Pitfalls

- Clock skew on the checking host producing false expiry readings — verify against the real expiry time.
- A cert that is "not expired" but not trusted (self-signed, missing intermediate, wrong chain).
- Renewing the cert while the load balancer/CDN still serves the old one (cache or component not reloaded).
- SAN mismatch: the cert covers the apex but not www (or vice versa), so one hostname passes and the other fails.

## Notes

- After a renewal, re-check to confirm the new cert and its full chain are actually served, accounting for propagation time.
- Do not exclude domains or widen expiry thresholds to force a green result.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

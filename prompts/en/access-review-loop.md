---
name: "access-review-loop"
description: "every access grant has a current justification"
---

# Access Review Loop

**Category:** Security & Compliance
**Slug:** `access-review-loop`
**Max Iterations:** 20

## Goal

Ensure every user, role, and service-account access grant has a documented, current business justification. Stale, over-privileged, or orphaned access is revoked or formally recorded as a reviewed exception. Success means the review script exits clean and every flagged item is resolved with a clear decision.

## When to Use

During periodic access reviews, after role/permission changes, or when an audit requires evidence that all grants are justified.

## Check Command

```bash
python scripts/access_review.py
```

## Exit Condition

- `python scripts/access_review.py` exits 0.
- Every flagged user, role, or grant is either revoked or has a recorded justification.

## Steps

Step 1: Run the check and capture the full output; list every flagged user, role, and grant.
Step 2: For each item, verify the justification: who owns it, why it exists now, and whether the scope is still the minimum needed; distinguish human accounts from service/machine accounts.
Step 3: Apply the smallest correct action — revoke unneeded access or record a reviewed exception; never rubber-stamp an item just because it passed last cycle.
Step 4: Re-run the check; if items remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report the remaining unreviewed or unjustified grants; do not loop forever.

## Common Pitfalls

- Treating long-lived service accounts as inherently safe — they accumulate the most stale, over-broad permissions over time.
- Re-approving a role because it was approved last cycle, instead of re-checking the current business need.
- Nested group membership hiding effective permissions: a user looks clean but inherits broad access via a group.
- Admin or break-glass accounts left enabled outside of incidents.

## Notes

- Distinguish revoke from documented exception; never delete a live production role without confirming blast radius.
- Record every decision and change for the audit trail — this is a compliance activity, not just cleanup.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "analytics-health-check"
description: "all key events tracked correctly"
---

# Analytics Health Check

**Category:** Operations & Marketing  
**Slug:** `analytics-health-check`  
**Max Iterations:** 8

## Goal
Ensure all key analytics events are tracked correctly and pass every check in `analytics_check.py`. Success means each defined event fires exactly once on the correct element with the correct parameters — no missing, misbound, or duplicate events.

## When to Use
After a feature launch, a tracking-plan change, a cross-domain/SPA refactor, or when data anomalies surface — run this loop to verify the event-tracking baseline and keep dirty data out of reports.

## Check Command

```bash
python scripts/analytics_check.py
```

## Exit Condition
- The check command passes with exit code 0 and no errors.
- All key events exist, fire on the correct element, carry complete parameters, and do not fire more than once.

## Steps
Step 1: Run `python scripts/analytics_check.py`, capturing the full output and exit code, recording the failing event name and failure type for each issue.
Step 2: Analyze by failure type: missing event, bound to the wrong element, missing/wrong parameters, duplicate firing (multiple listeners or uncaught bubbling), lost events on cross-domain or SPA route changes; locate the exact tracking code and trigger location.
Step 3: Make the smallest fix: correct a single event's binding or parameters; prioritize making the event fire exactly once on the correct element, never disabling the event or silently swallowing exceptions just to clear a warning.
Step 4: Re-run the check command; if failures remain and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without passing, stop and report the remaining failures (event, type, reason, suggestion); never loop forever.

## Common Pitfalls
- Binding an event to the wrong element (e.g. an inner span instead of the button), so some clicks go unreported.
- Duplicate firing: the same event has multiple listeners or bubbling is not intercepted, producing double counts.
- Missing or hardcoded-wrong parameters (e.g. a fixed page_name), distorting segmentation and funnels.
- Failing to re-fire pageview/virtual page on SPA route changes or modal opens, missing key views.
- Not preserving/passing the client ID across cross-domain redirects, breaking the user journey.

## Notes
- Fixes must capture real user behavior correctly; never disable or merge semantically distinct events just to pass the check.
- Distinguish a real gap from an intentionally retired event; retirements must be documented explicitly, never silently ignored.
- After changing tracking, reproduce the trigger once in a real environment and confirm the network request and parameters match expectations.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents
Claude Code, Cursor, Trae, Windsurf, Cline

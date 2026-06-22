---
name: "log-anomaly-detector"
description: "no critical anomalies in recent logs"
---

# Log Anomaly Detector

**Category:** System & DevOps
**Slug:** `log-anomaly-detector`
**Max Iterations:** 10

## Goal

Ensure recent logs contain no critical anomalies. Each detected anomaly is investigated to its root cause and either fixed or triaged with an accepted explanation; symptom-level log lines are never silenced. Success means the detector script exits 0 with no critical anomalies remaining.

## When to Use

After a deploy, during incident follow-up, or on a recurring schedule to catch regressions and emerging issues in production logs.

## Check Command

```bash
python scripts/log_anomaly.py
```

## Exit Condition

- `python scripts/log_anomaly.py` exits 0.
- No critical anomalies remain, and each prior anomaly is either fixed or has a recorded accepted explanation.

## Steps

Step 1: Run the check and capture the full output; list each detected anomaly with timestamp, source, and severity.
Step 2: For each anomaly, investigate the root cause — correlate with deploys, cron jobs, known events, and surrounding logs; separate real issues from benign recurring noise.
Step 3: Apply the smallest fix at the root cause, or record an accepted explanation (known issue, expected behavior); never silence or filter the log line to make the detector pass.
Step 4: Re-run the check; if anomalies remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without success, stop and report the remaining unexplained anomalies with their suspected causes; do not loop forever.

## Common Pitfalls

- Chasing benign recurring spikes (backups, cron jobs, deployments) as if they were incidents; correlate with known events first.
- Silencing or filtering an error log line instead of fixing the underlying fault.
- Sampling or truncation hiding the true culprit — the visible error is often downstream of the real cause.
- Looking only at ERROR level; many critical issues first surface as WARN or unusual patterns.

## Notes

- Keep "fix root cause" and "accept known issue" clearly distinct — both must be recorded with a decision.
- Do not widen filters or disable detectors to force a green result.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

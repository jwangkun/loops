---
name: "terraform-plan-until-clean"
description: "terraform plan shows no unexpected changes"
---

# Terraform Plan Until Clean

**Category:** System & DevOps
**Slug:** `terraform-plan-until-clean`
**Max Iterations:** 8

## Goal

Reach a `terraform plan` with no unexpected changes: exit code 0 (no diff) or a diff that is fully accounted for and intentional. Any accidental drift is corrected in code or state, and every resource change is understood before the loop ends. Success means the plan is clean or its remaining diff is 100% expected.

## When to Use

Before applying infrastructure changes, after merging IaC PRs, or to confirm there is no drift between code and real infrastructure.

## Check Command

```bash
terraform plan -detailed-exitcode
```

## Exit Condition

- `terraform plan -detailed-exitcode` exits 0 (no changes), or
- Exit code 2 (changes present) where every resource change is reviewed and confirmed intentional.
- Exit code 1 (error) is never an acceptable end state.

## Steps

Step 1: Run `terraform plan -detailed-exitcode` and capture the full diff; note the exit code (0 clean, 2 changes, 1 error).
Step 2: Analyze each change and error: separate intended code-driven changes from drift (manual console edits), stale state, or provider/version skew; never treat a destructive change as routine.
Step 3: Apply the smallest correct fix — update code to match reality, refresh/import drifted resources into state, or reconcile versions; do not silence drift with `--target` or by ignoring changes.
Step 4: Re-run the plan; if changes or errors remain and you are under max iterations, go back to Step 2.
Step 5: If max iterations is hit without a clean or fully-expected plan, stop and report the remaining unexplained diff and any destructive actions; do not loop forever.

## Common Pitfalls

- Real drift from manual console changes surfacing as diffs — fix by importing/correcting state, not by ignoring it.
- Local state out of sync (missed `terraform init`/refresh or stale backend) producing phantom diffs.
- Destructive changes (`force-replace`, `destroy`) buried in a large plan and auto-confirmed without review.
- Provider version skew between teammates generating spurious, non-actionable diffs.

## Notes

- Never run `terraform apply` inside this loop — this loop only plans and reconciles code/state.
- Explicitly flag any `force-replace` or `destroy` to a human before considering the plan acceptable.

- Convergence guard — if the same check fails with the same root cause on two consecutive iterations, change your approach or stop and escalate rather than retrying identically.
- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

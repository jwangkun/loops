---
name: "privacy-policy-audit"
description: "Privacy policy matches actual data practices"
---

# Privacy Policy Audit

**Category:** Security & Compliance
**Slug:** `privacy-policy-audit`
**Max Iterations:** 5

## Goal

Make `python scripts/privacy_check.py` pass, with the repository's privacy policy fully aligned to the code's actual data collection, storage, and sharing practices: every data category declared in the policy maps to a real data flow, and every category of sensitive data actually collected is truthfully disclosed in the policy.

## When to Use

Run before release or a compliance audit, or after changes to data-collection logic, third-party SDKs, or policy copy, so product behavior does not drift from the privacy promises made to users.

## Check Command

```bash
python scripts/privacy_check.py
```

## Exit Condition

- `privacy_check.py` exits with code 0.
- Every data-collection category declared in the policy has a corresponding implementation in code.
- Every category of personal data actually collected or shared in code is truthfully disclosed in the policy, with no undeclared collection or third-party sharing.

## Steps

Step 1: Run the check command, capturing the output and recording each mismatch (type: declared in policy but not implemented / collected in code but not disclosed / third-party sharing not declared).
Step 2: For each gap, locate the root cause: code introduced undeclared collection, the policy copy is lagging, or a third-party SDK reports extra data by default. Read the relevant collection points and policy sections as needed.
Step 3: Apply the smallest correct fix: if code is collecting out of scope, remove the collection or obtain proper consent; if copy is lagging, update the policy section to describe the practice truthfully. Never mask unauthorized collection by removing the matching statement from the policy.
Step 4: Re-run the check command; if gaps remain and you are under the max iteration count, go to Step 2.
Step 5: If the max iteration count is reached with gaps still remaining, stop and report the remaining gaps, the collection points and third parties involved, for a human (engineering / legal / privacy owner) to handle. Never loop forever.

## Common Pitfalls

- Matching only on policy section titles without reading the collection code and the specific policy text misses gaps where the names align but the meaning does not.
- Device identifiers, location, and similar data collected by default by analytics/ad SDKs are frequently left out of policy disclosures.
- Clearing an "undeclared collection" finding by deleting the corresponding policy statement is masking, not a compliant fix.
- The check script only covers known collection points; new collection logic that is not registered can bypass the check — combine with code review.

## Notes

- Unauthorized collection of real user data is a compliance event requiring human escalation; have a privacy/legal owner confirm the disposition first.
- Do not provide guidance that helps evade privacy checks or weaken user notice; the fix direction is to bring practice in line with promises, not to make promises accommodate over-collection.
- When a fix changes policy copy, ensure all language versions are updated together to avoid inconsistency between versions.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

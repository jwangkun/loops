---
name: "secret-scan-loop"
description: "No leaked secrets or credentials in the repository"
---

# Secret Scan Loop

**Category:** Security & Compliance
**Slug:** `secret-scan-loop`
**Max Iterations:** 5

## Goal

Make `npx secretlint --maskSecrets "**/*"` report zero hits, with no real secrets or credentials present in the working tree. Any discovered secret must be rotated/revoked, not merely deleted from history.

## When to Use

Run before commits or merges, or during periodic security reviews. Especially relevant when credentials are suspected of being committed, or when new config/test fixtures involving secrets are introduced.

## Check Command

```bash
npx secretlint --maskSecrets "**/*"
```

## Exit Condition

- secretlint exits with code 0 with no hits (or only confirmed false positives that are whitelisted with a stated rationale).
- Every real hit has had its credential rotated/revoked, and the leak has been removed from source.
- No real leak has been "resolved" by merely deleting the file or scrubbing git history.

## Steps

Step 1: Run the check command, capturing the full output; record each hit's file, line, rule, and the masked secret type (AKSK, token, private key, etc.).
Step 2: For each hit, determine whether it is a real secret: rule out test fixtures, example values, placeholders, and already-invalid or public harmless values. When in doubt, conservatively treat it as real.
Step 3: For real leaks: add the secret to a rotation list and have it rotated/revoked by a human first, then remove it from source (switch to environment variables / a secrets manager). Only confirmed false positives may be whitelisted, with a rationale. Never "clear" a hit by deleting the file or scrubbing git history.
Step 4: Re-run the check command; if hits remain and you are under the max iteration count, go to Step 2.
Step 5: If the max iteration count is reached with hits still remaining, stop and report the remaining hits, the credential types involved, and their rotation status for a human security owner to handle. Never loop forever.

## Common Pitfalls

- Test fixtures, doc examples, and placeholders (e.g. `xxxx`) are frequently misreported as real secrets; review each individually rather than ignoring them in bulk.
- Removing a secret from git history does not undo the leak — the secret may already have been captured and must be rotated/revoked.
- `--maskSecrets` hides the plaintext, but you still need the rule and surrounding context to judge type and severity.
- Obfuscating a real secret via string concatenation or encoding (base64 / splitting) to bypass the scanner is masking, not a fix.

## Notes

- A real credential leak must be treated as a human-escalation event: rotation/revocation takes priority over code cleanup.
- Never print plaintext secrets in commit messages, comments, or logs, and do not copy plaintext anywhere while handling hits.
- Do not provide guidance that helps hide, exfiltrate, or bypass secret scanning; whitelisting is only for unambiguous false positives.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

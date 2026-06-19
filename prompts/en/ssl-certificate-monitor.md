---
name: "ssl-certificate-monitor"
description: "all domains have valid SSL certificates"
---

# SSL Certificate Monitor

**Category:** System & DevOps  
**Slug:** `ssl-certificate-monitor`  
**Max Iterations:** 5

## Goal

all domains have valid SSL certificates

## Check Command

```bash
python scripts/ssl_check.py
```

## Exit Condition

all certificates valid and not expiring soon

## Steps

Step 1: Check each domain's certificate. Renew or fix expiring ones.

## Recommended Agents

Claude Code, Cursor, Trae

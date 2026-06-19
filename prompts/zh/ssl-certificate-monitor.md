---
name: "ssl-certificate-monitor"
description: "所有域名都有有效SSL证书"
---

# SSL证书监控

**分类:** 系统与DevOps  
**标识符:** `ssl-certificate-monitor`  
**最大迭代次数:** 5

## 目标

所有域名都有有效SSL证书

## 检查命令

```bash
python scripts/ssl_check.py
```

## 退出条件

所有证书有效且未临近过期

## 执行步骤

Step 1: 检查每个域名的证书。续期或修复即将过期的证书。

## 推荐代理

Claude Code、Cursor、Trae

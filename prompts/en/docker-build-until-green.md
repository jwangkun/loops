---
name: "docker-build-until-green"
description: "image builds and health check passes"
---

# Docker Build Until Green

**Category:** System & DevOps
**Slug:** `docker-build-until-green`
**Max Iterations:** 8

## Goal

Make the Docker image build successfully and, once started, have the healthcheck pass and the container exit with code 0. Success means the full chain — Dockerfile, base image, dependency install, application startup, and health probe — works and the produced image is actually runnable.

## When to Use

After changes to the Dockerfile, dependency manifest, entrypoint, or healthcheck logic; suited to iteratively fixing build and runtime issues before image-based deployment.

## Check Command

```bash
docker build -t app . && docker run --rm app healthcheck
```

## Exit Condition

- `docker build -t app .` exits with code 0 and the `app` image is produced.
- `docker run --rm app healthcheck` exits with code 0.
- No errors during the build and no crash or healthcheck timeout at runtime.

## Steps

Step 1: Run the check command; separately capture stdout/stderr and exit codes for the build and run phases, and note which phase failed.
Step 2: Analyze failures: in the build phase distinguish base-image pull failures, instruction errors (COPY paths, RUN commands), dependency-install failures, and disk/layer-cache issues; in the run phase distinguish missing entrypoint, missing port/volume mounts, application startup failure, and a healthcheck command that is itself wrong or times out.
Step 3: Make the smallest fix — correct Dockerfile instructions/paths, complete dependencies, or adjust the entrypoint or healthcheck config (e.g. `start-period`, retry count). Never fake health by making the healthcheck always return 0, commenting out the check, or appending `|| true`.
Step 4: Re-run the check command; if it still fails and you are under the max iterations, return to Step 2.
Step 5: If max iterations are reached without success, stop and list the remaining issues for the build and run phases separately, with their root causes. Never loop forever.

## Common Pitfalls

- Making the healthcheck always return 0 (e.g. `CMD ["true"]` or `|| exit 0`): the image looks healthy without actually probing.
- Slow application startup with no `start-period`/retries on the healthcheck, so the container is marked unhealthy before it is ready.
- Inconsistent dependencies between build and runtime (dev deps installed at build but missing at runtime), causing green-build-but-crash-on-run.
- Wrong `COPY` paths or `.dockerignore` rules leaving files missing at runtime; or layer cache masking the real change, requiring `--no-cache` to reproduce.

## Notes

- Do not pass the build by using `latest` base images or disabling multi-stage safety/slimming optimizations.
- The healthcheck must genuinely probe application availability (e.g. the `/health` endpoint), not be a no-op.
- When secrets are involved, use build args or mounts; never bake secrets into image layers.

- Budget discipline — respect the host harness's token, cost, and wall-clock budget; treat budget exhaustion as a stop-and-report event, never a signal to retry.
- Terminal states — a loop ends in success, blocked, or exhausted. A stalled run or an exhausted budget is never reported as success.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

---
name: "social-post-generator"
description: "social posts generated for each platform"
---

# Social Post Generator

**Category:** Content Creation
**Slug:** `social-post-generator`
**Max Iterations:** 10

## Goal

Generate a social post for each target platform that conforms to that platform's length, format, and tone norms—preserving one core message but adapting it per platform. Success means the check command confirms all platforms have a compliant post.

## When to Use

Use when a single piece of content must be adapted and distributed across multiple platforms (e.g., short-form, long-form, hashtagged variants).

## Check Command

```bash
python scripts/check_posts.py
```

## Exit Condition

- A post has been generated for every target platform.
- Each post's character count, hashtags, links, and media format conform to its platform's limits.
- The core message is consistent across all platforms.

## Steps

Step 1: Run the check command, capturing missing platforms and each post's compliance issues (over-length, missing tags, wrong format, etc.).
Step 2: Analyze per platform—check against that platform's length cap, line-break/hashtag conventions, media requirements, and tone norms to find what falls short.
Step 3: Generate posts for missing platforms or rewrite non-compliant ones to fit; handle each platform independently and never cross-post verbatim.
Step 4: Re-run the check command; if platforms are still missing or non-compliant and you're under max iterations, go to Step 2.
Step 5: If max iterations are hit without full coverage, stop and report the remaining platforms and unresolved items; never loop forever.

## Common Pitfalls

- Cross-posting the same copy verbatim to every platform, ignoring length and tone differences.
- Stuffing irrelevant hashtags to fill tags, triggering throttling or looking low-quality.
- Misjudging the character-count basis (counting code points rather than display width, or ignoring link wrapping), so posts are actually over-length.
- Ignoring media format/aspect-ratio requirements, causing cropped images or upload failures.

## Notes

- Generate each platform's post independently; keep the core message consistent but tailor expression per platform.
- Never fabricate data, quotes, or third-party endorsements.
- Respect each platform's content rules and limits; confirm the target platform list before generating.

## Recommended Agents

Claude Code, Cursor, Trae, Windsurf, Cline

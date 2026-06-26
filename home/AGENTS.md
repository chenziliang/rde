# Agent Instructions (global)

Common instructions for my coding agents across all projects. A project may add
its own `AGENTS.md` at its root, which **extends and overrides** this file.

## General Guidelines

- Never use the em dash "—". Use a plain dash "-" instead.
- When writing commit messages, do not auto-add the agent name as co-author.
- Never manually modify `CHANGELOG.md` or any file marked auto-generated.
- When writing or substantially editing long Markdown, put each full sentence on
  its own line (preserve normal structure; avoid wrapping multiple sentences
  onto one physical line).
- When making technical decisions, do not give much weight to development cost.
  Prefer quality, simplicity, robustness, scalability, and long-term
  maintainability.
- When fixing bugs, start by reproducing the bug in an end-to-end setting as
  closely as possible, so the fix actually solves the real problem.
- When end-to-end testing, be picky about the UI and obsessed with pixels. If
  something looks off, even if unrelated to the current change, call it out.
- Apply the same high standard to engineering excellence: lint, test failures,
  and test flakiness. If you see one, fix it even if it is not caused by the
  current work.
- Avoid personal/private details in prompts, screenshots, logs, and scratch files.

## Opinions

When a task would benefit from my technical viewpoints, read `~/OPINIONS.md`.

## Voice Profile

When writing or posting on my behalf (PRs, issues, social, docs in my name),
read `~/VOICE.md` for tone and style.

<!-- Customize the guidelines above. This is a starter set; edit freely. -->

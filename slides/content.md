# Slide Content Notes

Facts the deck draws on that are not in a single repository source. Sources for the rest are listed in `slides/INSTRUCTIONS.md`.

## Daily Claude Code Features

Taken from the user's `.claude/settings.json` and workflow.

- **Planning without plan mode**: the user does not use built-in plan mode. Plans come from the `spec-driven-development` skill and live as files in `agents/plans/`, reviewed before implementation.
- **`/clear` between tasks**, `/context` to see what fills the window, `/compact` when needed. `autoCompactWindow: 500000` caps the 1M window.
- **Auto mode** (`permissions.defaultMode: "auto"`) with a curated `permissions.deny` list.
- **`!` prefix** runs a shell command in the session; `respondToBashCommands: false` puts output in context without a model reply.
- **Skills** in `.claude/skills/`, controlled by `skillOverrides`.
- **AskUserQuestion**: the agent asks instead of guessing.
- **Hooks**: an `rtk` PreToolUse hook condenses Bash output to save tokens.
- **Named sessions**: `claude -n`, `/rename`, `/color`, `/list-agents`, cross-session messaging.
- **Remote Control** with push notifications (`inputNeededNotifEnabled`, `agentPushNotifEnabled`): answer the agent from the phone.
- **Statusline**: model, effort, context, and rate-limit pace at a glance.
- **Vim editor mode** (`editorMode: "vim"`, `ii` to escape) and focus view (`viewMode: "focus"`).
- **`/model` and `/effort`**: per task. Opus 5.5 medium by default; Sonnet 5.5 for implementation.
- **playwright-cli** skill: the agent drives a real browser (this deck's LinkedIn research used it).

## Token Basics

- **Input tokens**: everything sent each turn: system prompt, tools, `CLAUDE.md`, skills, the whole conversation so far.
- **Output tokens**: what the model writes. Most expensive per token.
- **Cached input**: a repeated exact prefix. Write costs 1.25x on a miss, read costs 0.1x on a hit.
- Default cache TTL is 5 minutes. A coffee break expires it and the next turn re-writes the whole context. `promptCacheTtl: "1h"` survives breaks and meetings; `idleCompaction` compacts a large idle conversation before the 1h cache expires.
- `/resume` reloads a long history: a full cache write if the cache expired, plus stale context that drifts. `/clear` plus self-documenting knowledge and plans gives a cheap, fresh start with the decisions preserved in files.

## No Auto Memory

Auto memory saves notes under `~/.claude/`, outside the repository. Two teammates on the same project get different hidden context, so the same prompt yields different output. Project memory (`agents/MEMORY.md`, `agents/knowledge/`, `agents/plans/`) is versioned, reviewed, and shared.

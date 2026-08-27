# Harness Context Tuning

Measured facts about what Claude Code settings cost in context prefix tokens, and which levers matter on a Claude Pro subscription. Verified 2026-08-27 against Claude Code 2.1.235 in this repository.

## Measurement Method

Run `claude -p "/context" --output-format text` from the repository root. Print mode reports a near-empty `Messages` row, so the prefix is readable directly.

- Compare arms by `total minus Messages`. The per-category rows do not sum to the reported total, and the eager/deferred tool split shifts between configurations, so no single category row is a reliable metric.
- Print mode loads fewer tools than an interactive session. Absolute numbers understate; deltas hold and tend to be larger interactively.
- `CLAUDE_CONFIG_DIR` does not work for this. It isolates config but breaks the reporter: system prompt, tools, and memory all report 0.
- Vary settings by swapping `.claude/settings.json` and `~/.claude/settings.json`, backing both up first. `--settings` merges and cannot remove a deny rule; deny rules union across sources and cannot be un-set.
- A running session hot-reloads tool changes mid-flight, but system prompt changes such as `includeGitInstructions` need a restart.

## Measured Costs

Arms differ only as named; all else held constant.

| Configuration | Prefix |
| --- | --- |
| Stock, no deny list and no `disable*` flags | 15.4k |
| Deny list emptied, `disable*` flags kept | 15.5k |
| Tuned baseline | 11.2k |
| Final: baseline plus `Agent`, `EnterPlanMode`, `includeGitInstructions` | 9.7k |

Attributed values:

| Lever | Worth | Note |
| --- | --- | --- |
| `permissions.deny` list | ~4.3k | Mostly deferred tool definitions |
| Deny `Agent` | ~1.3k | Removes the tool and the whole agent-type catalog |
| `disableBundledSkills` | ~1.4k | Skills row 2.2k drops to 778 |
| `includeGitInstructions: false` | ~200 | Needs a restart to take effect |
| `skillListingMaxDescChars: 200` | ~290 | Truncates trigger descriptions; not worth it |
| `disableMobileSimulatorTools` | 0 | Already inert on macOS here |
| `syncClaudeAiSkills: false` | 0 now | Prevents future listing growth only |

Denying a bare tool name removes its definition from the payload. A scoped rule such as `Read(./secrets/**)` only blocks use and saves nothing.

## Non-Levers

- UI flags cost nothing: `spinnerTipsEnabled`, `showTurnDuration`, `emojiCompletionEnabled`, `promptSuggestionEnabled`, `terminalProgressBarEnabled`. Several published guides list these as token savings. They are cosmetic.
- `promptCacheTtl` is close to break-even. Cache hits refresh the TTL, so active work keeps the static prefix warm under the default. A one-hour TTL costs 2x on writes against 1.25x, to avoid misses that mostly are not happening.
- MCP deny rules cost nothing when no servers are configured. Tool definitions load only for registered servers.
- `disableAllHooks` is a net loss wherever a hook or status line is in use.
- Do not deny `TaskOutput` or `TaskStop`: background Bash needs them, and they are deferred and cheap.
- Deny `EnterPlanMode` without `ExitPlanMode`. Shift+Tab still enters plan mode manually, and denying both leaves no way out.

## Prefix Cost Model

Caching is keyed on an exact token prefix, not on a session, so separate chats sharing a prefix hit the same cache. Claude Code layers it: global static (system prompt and tools), then project (`CLAUDE.md` and repository guidance), then per-session messages.

A prefix of size `N` costs `N * 1.25` as a cache write on a miss and `N * 0.1` as a read on every later request. Reads dominate by volume, so caching reduces prefix cost but never removes it. Cutting prefix tokens beats caching them.

Savings scale as `prefix / average context`. Many short chats keep average context low and make the prefix a larger share; long sessions make it negligible.

## This Repository Invalidates Its Own Cache

`AGENTS.md`, `CLAUDE.md`, and `skills/` are the project cache layer, and editing them is this repository's purpose. Any byte change invalidates that layer and everything downstream for later chats in this directory. Batch guidance edits rather than trickling them through a session. This also makes `skillListingMaxDescChars` counterproductive: it invalidates the cache to save ~290 tokens.

## Subscription Priorities

On Claude Pro the ranking differs from API billing, where per-token cost makes prefix trimming the obvious lever.

1. Keep auto-compact on, or `/clear` between tasks. With compaction off and a large window, every turn pays a cache read on the full context: a session at 200k costs ~20k per turn, exceeding the entire prefix saving across many chats.
2. Model choice. Opus consumes budget several times faster than Sonnet per token, which outweighs every prefix lever here.
3. The deny list, already applied and free.

Unverified: that subscription limits weight cache reads at the same 0.1x as API pricing. If they are weighted at full rate, context bloat costs more than modelled and item 1 matters more.

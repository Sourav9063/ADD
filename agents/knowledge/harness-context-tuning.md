# Harness Context Tuning

What Claude Code settings cost in context prefix tokens, and which levers matter. Verified 2026-09-08 against Claude Code 2.1.263 on Opus 5 in this repository. Rechecked 2026-09-23 on 2.1.280 and Opus 5.5; see [2026-09-23 Recheck](#2026-09-23-recheck), which overrides anything older where they disagree. Config decisions changed 2026-09-26; see [2026-09-26 Config Update](#2026-09-26-config-update).

Supersedes two earlier passes. See [Superseded Findings](#superseded-findings) before trusting any older number.

## Measure Interactively Or Not At All

Run `/context` in a real interactive session. Take the reported total and subtract the `Messages` row. That is the prefix.

Do not measure with `claude -p`. Print mode loads a much smaller tool set, about 3k versus 21k interactively. Settings that suppress tool schemas therefore read as zero in print mode when they are in fact the largest levers. Two full sweeps were wasted on this.

Other rules:

- **Pin the model.** Deltas are not model independent. One setting measured 2,947 tokens on Haiku and 693 on Opus. Never compare arms measured on different models.
- **`--settings` merges, it does not replace.** Array values such as `permissions.deny` union with project and user settings. Passing a shorter list cannot remove a deny rule, so any "cost of allowing X" measured that way measures nothing. `--restricted` drops project and local settings files, but it also strips project context, which changes what is being measured.
- **Verify additivity.** Measure A, B, then A+B. If the combined delta does not match the sum, the levers interact.
- The `/context` category rows do not always sum to the reported total.

## Measured Baseline

Interactive, Opus 5, this repository.

| Configuration | Prefix |
| --- | --- |
| Stock, nothing configured | ~27.6k |
| Final config | ~8.3k |
| Saved against stock | ~19.3k (70%) |

By category:

| Category | Stock | Final |
| --- | --- | --- |
| System tools | 21k | 2.8k |
| System prompt | 3k | 2.7k |
| Skills | 3.2k | 2.3k |
| Memory files | 0.4k | 0.4k |

**18.2k of the 19.3k saving is the tool row.** Everything else is rounding.

Intermediate readings, useful for attribution:

| Config | Prefix | Tools |
| --- | --- | --- |
| Deny list cut to one entry | 10.6k | 5.1k |
| Deny list restored, plus `Agent` | 8.9k | 3.2k |
| Plus `ListAgents` | 8.3k | 2.8k |

An earlier tuned reading showed 1.3k of memory against 0.4k everywhere else. That reading is the outlier and is not used. All arms above match on the memory row and are directly comparable.

## The Dominant Lever Is Feature Flags

Stock Claude Code ships tool schemas for every feature. Disabling a feature removes its schemas.

These flags account for nearly all of the 18k:

- `disableArtifact`
- `disableWorkflows`
- `disableAgentView`
- `disableRemoteControl`
- `disableClaudeAiConnectors`, plus MCP deny rules

The stock `/context` confirms what they suppress: MCP Drive tools, `artifact-capabilities`, `artifact-design`, `artifact-diagramming`, and `design`.

**Attribution across these individual flags is unmeasured.** Splitting the 18k requires one interactive probe per flag, which cannot be automated from a tool call. Do not quote per flag numbers until that work is done.

## Smaller Levers

These were measured in print mode, so treat them as a lower bound and as ordering hints only. They are marginal next to the feature flags.

| Lever | Haiku | Opus |
| --- | --- | --- |
| `autoMemoryEnabled: false` | 2,947 | 693 |
| `includeGitInstructions: false` | 1,738 | 402 |
| `disableBundledSkills: true` | 1,432 | 2,003 |

`disableBundledSkills` saves about 100 tokens, not 2k. The `Skills` row is carved out of the tool total, so hiding skills moves tokens back into `System tools`. See [2026-09-23 Recheck](#2026-09-23-recheck).

## Deny Rules Are Worth Real Tokens Interactively

Measured interactively. Cutting the deny list to one entry raised the prefix from 9.4k to 10.6k and the tool row from 3k to 5.1k. Restoring 11 entries plus `Agent` pulled the tool row back to 3.2k. Adding `ListAgents` took it to 2.8k, worth about 400.

Print mode scored every one of those removals at zero. `--restricted` on Opus put a 15 entry list at 2,540, closer but still an understatement. Trust only interactive figures.

`Agent` and `ListAgents` are worth denying together. Denying `Agent` alone leaves `ListAgents` loading a catalog of agents that can no longer be spawned.

Finer per entry attribution is unmeasured and needs one restart per probe.

Denying a bare tool name removes its definition only when that tool would otherwise load, so value concentrates in a few entries. A scoped rule such as `Read(./secrets/**)` blocks use and saves nothing.

Do not deny `ToolSearch`, `TaskOutput`, or `TaskStop`. The first loads deferred tools; the other two are needed for background Bash.

## Confirmed Non-Levers

Measured at zero in every arm, print and interactive.

- **UI and session keys**: `theme` (all values), `tui`, `editorMode`, `statusLine`, `preferredNotifChannel`, `awaySummaryEnabled`, `autoCompactEnabled`, `spinnerTipsEnabled`, `showTurnDuration`, `emojiCompletionEnabled`, `promptSuggestionEnabled`, `terminalProgressBarEnabled`.
- **`effortLevel` and `modelSettings`**: `high` costs nothing extra to send. Tune on reasoning depth alone. A top level `effortLevel` is not redundant with a per model entry; it is the fallback for other models.
- **`env` vars, `model`, `permissions.defaultMode`, `hooks`.** Hooks are free in the prefix. The rtk hook saves Bash output tokens, which is a separate axis not measured here.

Two zeros depend on account state rather than the setting:

- `syncClaudeAiSkills` was zero because no synced skill directory existed. By 2026-09-23 the account synced 12 `anthropic-skills:*` skills. The key is ignored in project `.claude/settings.json`; it works only from `~/.claude/settings.json` or `.claude/settings.local.json`.
- `disableClaudeAiConnectors` reads zero in print mode only. Interactively it removes MCP tool schemas and is part of the 18k.

Invalid values fail silently for free-form keys. `"theme": "totally-bogus-theme-xyz"` is accepted with no error. Keys with a closed enum are rejected when Claude Code edits the file: `disableDeepLinkRegistration`, `disableAutoMode`, and `disableBypassPermissionsMode` take the string `"disable"`, not `true`.

## 2026-09-23 Recheck

Claude Code 2.1.280, Opus 5.5, interactive `/context`. 2.1.280 added no new settings keys over 2.1.278.

| Config | Where | Total |
| --- | --- | --- |
| No settings anywhere | `judi-dashboard` | ~25k |
| Only deny `ScheduleWakeup` and `autoMemoryEnabled: false` | this repository | ~23.6k |
| Full config, `Agent` denied, git instructions off | `judi-dashboard` | ~6.8k |
| Current config: full, `Agent` allowed, git instructions on | this repository | ~9.2k |

The stripped config was a mistake driven by print mode. It kept only the two items print mode ranked highest and removed the feature flags and deny entries print mode scored at zero. The prefix returned to near stock. The rule in [Measure Interactively Or Not At All](#measure-interactively-or-not-at-all) held again.

Current config decisions:

- **`Agent` is allowed.** Subagents keep search and exploration out of the main context, which outweighs the ~2k up front cost. `ListAgents` stays denied.
- **`includeGitInstructions` is on.** It is optional. It encodes commit and PR safety rules the model mostly follows anyway, for about 0.2k.
- **`skillOverrides` turns off only `loop` and `schedule`**, which fail against the denied scheduling tools. Hiding other skills is not worth the lines.
- **Synced claude.ai skills stay listed.** Removing them needs `syncClaudeAiSkills: false` in user or local settings.

### Hiding Skills Saves Almost Nothing

The `/context` `Skills` row is an estimate subtracted from the tool total. Hiding skills moves tokens between rows and barely changes the total.

- Seven synced skills set `"off"` interactively: `Skills` 5.3k to 3.6k, `System tools` 1.1k to 2.8k, total 9.2k to 9.1k.
- All bundled skills hidden in print mode, by `skillOverrides` or `disableBundledSkills`: total 5.1k to 5.0k.

`skillOverrides` does accept synced names such as `anthropic-skills:docx`. Use it to keep the model from invoking a skill, not to save tokens. Only denying the `Skill` tool removed real tokens (~0.7k), and that also disables project skills.

### Print Mode Probes, Ranking Only

`claude -p --setting-sources project "/context"` loads only the project file and reports a separate `System tools (deferred)` row. Settings in `~/.claude/settings.json` otherwise union into the deny list and mask per entry deltas. Print mode still omits interactive features, so read these as ordering hints: deny `ScheduleWakeup` ~1.7k, deny `Agent` ~1.1k, deny `ReportFindings` ~0.8k, `autoMemoryEnabled: false` ~0.7k, `disableClaudeAiConnectors` ~0.6k, deny `ListAgents` ~0.4k, `includeGitInstructions: false` ~0.2k. Everything else read zero, including feature flags that are worth thousands interactively.

## 2026-09-26 Config Update

`.claude/settings.json` is now a complete, standalone file meant to be copied to `~/.claude/settings.json`. Scopes were checked against the settings reference; token effects were **not re-measured**. Run interactive `/context` after installing it.

### Scope Traps

These keys do nothing in project `.claude/settings.json`. They take effect only from user settings, or local where noted:

- `syncClaudeAiSkills`, `syncClaudeAiPlugins`: user or local.
- `feedbackDrafts`, `askUserQuestionTimeout`, `vimInsertModeRemaps`: user only.
- `permissions.defaultMode: "auto"`: ignored in project and local files.
- `effortLevel` in user settings is legacy: Opus 5.5 ignores it and reads `modelSettings["claude-opus-5-5"]`. Keep both. The top-level key covers older models.

### Changes Superseding the 2026-09-23 Decisions

- **Synced claude.ai skills and plugins are off** via `syncClaudeAiSkills` and `syncClaudeAiPlugins`. Per [Hiding Skills Saves Almost Nothing](#hiding-skills-saves-almost-nothing), expect little prefix saving. The point is keeping them from triggering.
- **`skillOverrides` hides more.** `dataviz`, `claude-api`, `keybindings-help`, and `fewer-permission-prompts` are `"off"`. `code-review`, `simplify`, `security-review`, `run`, and `init` are `"user-invocable-only"`, so they stay typable. This controls invocation, not tokens.
- **`feedbackDrafts: "off"`** removes the `SendFeedback` tool, but only from user settings. `SendFeedback` is also denied so the project file works alone. It is a tool-row lever, unmeasured.
- **Deny `EnterWorktree` and `ExitWorktree`.** Agent view and background sessions are off, so worktrees go unused. These are deferred tools, so only their names load. The main value is preventing unexpected worktree switches.
- **`disableArtifact` became `enableArtifact: false`.** The old key is deprecated.
- **Deny `Read(**/.env)` and `Read(**/.env.*)`.** This is for secret safety, not tokens. Scoped rules save nothing.
- **`disableRemoteControl` stays unset.** Remote Control is in use, so its schemas are accepted as a cost. `inputNeededNotifEnabled` and `agentPushNotifEnabled` are on.

### Per-Turn Levers

These keys shrink conversation growth, not the prefix. That growth dominates in long sessions; see [Subscription Priorities](#subscription-priorities).

- `autoCompactWindow: 200000`: compact at 200k instead of near the 1M window.
- `bashOutputMaxChars: 8000`: default 30000. Overflow is saved to a file. This stacks with the rtk hook.
- `respondToBashCommands: false`: `!` output enters context without a model reply.
- `showClearContextOnPlanAccept: true`: offers a fresh context when approving a plan.
- `promptCacheTtl: "1h"`: fewer cache misses across breaks, at a higher write price. This is cost, not tokens.

## Prefix Cost Model

Caching is keyed on an exact token prefix, not on a session, so separate chats sharing a prefix hit the same cache. Claude Code layers it: global static (system prompt and tools), then project (`CLAUDE.md` and repository guidance), then per session messages.

A prefix of size `N` costs `N * 1.25` as a cache write on a miss and `N * 0.1` as a read on every later request. Reads dominate by volume, so caching reduces prefix cost but never removes it. Cutting prefix tokens beats caching them.

Savings scale as `prefix / average context`. Many short chats keep average context low and make the prefix a larger share. Long sessions make it negligible.

## This Repository Invalidates Its Own Cache

`AGENTS.md`, `CLAUDE.md`, and `skills/` are the project cache layer, and editing them is this repository's purpose. Any byte change invalidates that layer and everything downstream for later chats in this directory. Batch guidance edits rather than trickling them through a session.

## Subscription Priorities

On Claude Pro the ranking differs from API billing, where per token cost makes prefix trimming the obvious lever.

1. Keep auto compact on, or `/clear` between tasks. With compaction off and a large window, every turn pays a cache read on the full context. A session at 200k costs about 20k per turn, which exceeds the entire prefix saving across many chats.
2. Model choice. Opus consumes budget several times faster than Sonnet per token.
3. Feature flags, worth 18k once and then free forever.

Unverified: that subscription limits weight cache reads at the same 0.1x as API pricing. If they are weighted at full rate, context bloat costs more than modelled and item 1 matters more.

## Superseded Findings

Two earlier passes produced wrong numbers. Both failures had the same shape: something adjacent to the real question was measured and reported as the answer.

**2026-08-27, version 2.1.235.** Used `/context` row parsing and `--settings` list omission. Its deny list value of ~4.3k and its `Agent` value of ~1.3k were method artifacts. Its warning that print mode understates was correct and should have been heeded.

**2026-09-08, first pass, same day.** Measured everything with `claude -p` on Haiku. Reported stock as 17.4k and the saving as 34%. Both wrong. Worse, it listed `disableArtifact`, `disableWorkflows`, `disableAgentView`, and `disableRemoteControl` as non levers worth zero. They are the largest levers in the config. Print mode never loaded the tools they suppress.

| Claim | Then | Now |
| --- | --- | --- |
| Stock prefix | 15.4k, later 17.4k | ~27.6k |
| Total saving | ~4.3k, later 34% | ~19.3k (70%) |
| Feature flags | zero | the dominant lever, ~18k |
| `permissions.deny` list | ~4.3k | 2,540 on Opus |
| Deny `Agent` | ~1.3k | unverified, print mode said 0 but it loads interactively |
| `autoMemoryEnabled` | not measured | 693 on Opus, marginal |

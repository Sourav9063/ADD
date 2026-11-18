# Claude Code Settings Proposal, 2026-11-18

Applied 2026-11-18: items 2, 5, 6, and P3; item 7 was reverted because the SchemaStore schema lags the CLI and flags valid keys and deny names in `.claude/settings*.json`; item 1 resolves when `.claude/settings.json` is copied to `~/.claude/settings.json`; item 3 kept Opus at `medium`; item 4 still needs a subagent check. Orca hooks were removed from user configs; HyperFrames skills were removed by the user. Recorded in `agents/knowledge/harness-context-tuning.md`.

Reviewed the changelog from 2.1.301 to 2.1.327 (the installed version), plus the settings and settings-reference pages. The last recorded review covered up to 2.1.300 (`agents/knowledge/harness-context-tuning.md`, 2026-10-15). The files reviewed are `.claude/settings.json`, its `.ask` and `.rc` variants, and the live `~/.claude/settings.json`. No token effects were measured. The `/context` checks are listed under Verification.

## P0: Fix Now

### 1. User `autoMode.environment` is pinned to another repository

`~/.claude/settings.json` has an `autoMode.environment` block written for `hyperframe/postgres-internals-short`. It names that repository as "the trusted repo" and says "no remotes configured". `autoMode` is a user-scope key, so this block applies in every project, including this one, which has a GitHub remote. The block also leaves out `"$defaults"`. Without it, the list replaces the classifier's built-in environment entries instead of adding to them (settings-reference `autoMode`; 2.1.326 changed this for managed settings too).

What this costs: in every project except that one, the auto mode classifier works from false premises about which repository is trusted and where it pushes.

Proposal: delete the block. If a trusted-environment description is still wanted, put back a generic one that starts with `"$defaults"` and names no project:

```json
"autoMode": {
  "environment": [
    "$defaults",
    "**Source control**: github.com/Sourav9063 repositories are trusted"
  ]
}
```

### 2. Attribution still adds a session link

This session's harness told the agent to end commits with `Claude-Session: https://claude.ai/code/...`. The cause is that `attribution.commit: ""` and `attribution.pr: ""` hide the trailer and the PR text but not `attribution.sessionUrl`, which stays on by default. `includeCoAuthoredBy` is deprecated and ignored once `attribution` is set.

Proposal: replace both keys with `"attribution": false` (v2.1.281 or later; 2.1.327 is installed). Apply this in `.claude/settings.json`, both variants, and the user file.

## P1: Recommended

### 3. Pick one Opus effort level

The project file sets `claude-opus-5-5` to `medium` and the user file sets `high`, probably saved through `/effort`. Each model's effort is resolved from the highest-precedence file that sets it. So this repository runs at medium and every other project runs at high, while the canonical file says medium. Choose one and write it to both files.

### 4. Close the subagent-effort open question

Since 2.1.317, subagents on a model other than the main conversation's use that model's saved effort. So `modelSettings["claude-sonnet-5-5"].effortLevel: "high"` now applies to the Sonnet-pinned subagents. Verify this once with a subagent, then remove the "unverified" notes in the knowledge file. `CLAUDE_CODE_SUBAGENT_EFFORT` (2.1.316) is a fallback that isn't needed.

### 5. Hide the `plugin-authoring` bundled skill

It is listed in every session ("Make a mod..."), and mods aren't used here. Add `"plugin-authoring": "off"` to `skillOverrides`. The point is fewer false triggers, not token savings (see "Hiding Skills Saves Almost Nothing").

### 6. Turn off subagent progress summaries

Set `CLAUDE_CODE_DISABLE_AGENT_PROGRESS_SUMMARIES=1` (2.1.323, available since 2.1.318). It stops the extra requests that write subagent progress summaries. With `viewMode: "focus"` those summaries are rarely read. This saves subscription budget at no cost to quality. Revert it if background-agent progress becomes hard to follow.

### 7. Add `$schema`

Add `"$schema": "https://json.schemastore.org/claude-code-settings.json"` for editor validation. Claude Code ignores the key.

## P2: User Setup Hygiene (outside the repository)

- **User-level HyperFrames skills.** `~/.claude/skills/{hyperframes,hyperframes-cli,hyperframes-registry,media-use,reverse-any-video,style-sampling}` load in every project, so they appear in this repository's skill listing and can trigger falsely. Move them to the HyperFrames project's `.claude/skills/`, or install them as a plugin enabled only there.
- **Orca hooks.** These are wired to 15 hook events, including a `PreToolUse` hook with matcher `*` that runs a shell per tool call (10 s timeout). Keep them only if Orca is in use. `/status` now lists matchers that never match (2.1.327), so check it once.
- **Stale backups.** There are 12 `~/.claude/settingsm*.json` files. Archive or delete them so it's clear which file is live.
- **Drift.** Apart from items 1–3, the user file matches `.claude/settings.json` except for `includeCoAuthoredBy`. Item 2 removes that difference.

## P3: Variants

`.claude/settings.ask.json` and `.claude/settings.rc.json` still lack `idleCompaction: true` (recorded 2026-10-15) and have no attribution setting. Add `"attribution": false` and `"idleCompaction": true` to both.

## Considered and Rejected

- **`permissions.blockWritesOutsideWorkingDirectories`** (2.1.314). It also refuses Write and Edit on Claude Code settings files inside the working directory. This repository edits `.claude/settings*.json` directly by design. It would also make the `EnterWorktree`/`ExitWorktree` denies redundant, but that saves almost nothing.
- **`permissions.denyInsteadOfPrompting`** (2.1.319). Remote Control and push notifications are on so that prompts can be answered away from the terminal. Denying would silently drop those actions. Use it only per run, through `--settings`, for unattended jobs.
- **`autoMode.classifyAllShell`.** There are no allow rules for it to override.
- **`CLAUDE_CODE_DISABLE_SHELL_HEAD_START`** (2.1.327). It only matters when opening untrusted repositories, so it isn't worth a line here.
- **`blockReadsOutsideWorkingDirectories`.** Agents here read `~/.claude/*` while doing harness work.
- **`CLAUDE_CODE_DISABLE_ULTRATHINK`.** The keyword is now a useful per-turn xhigh switch (2.1.311).

## Changelog Notes for the Knowledge File (no setting change)

- 2.1.317 removed the Read tool's "file unchanged" stub, so a repeated Read returns the full content. Re-reading files now costs real tokens.
- 2.1.322 trims background-command notifications and `TaskStop` results over 1,000 characters to their start and end.
- 2.1.304: after compaction the skill list is sent again, and `/reload-skills` sends only skills that changed.
- 2.1.302: forked subagents are on by default everywhere. `CLAUDE_CODE_FORK_SUBAGENT=0` turns them off.
- 2.1.325: `promptSuggestionEnabled` is now honored from `settings.json`. The existing `false` now takes effect.

## Verification After Applying

1. `/status`: settings sources, ignored permission settings, and hook matchers that never match.
2. `claude doctor`: no rejected entries.
3. Commit a test change in a scratch repository and confirm it has no trailer or session link.
4. Interactive `/context` in this repository, compared with the ~9.2k figure from 2026-09-23.
5. Record the outcome as a `2026-11-18 Changelog Review` section in `agents/knowledge/harness-context-tuning.md`, and mark this draft as applied.

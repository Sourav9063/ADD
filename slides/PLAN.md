# Slide Plan: Claude Code, the ADD Way

Slide-by-slide spec for `slides/claude/index.html`. Brief: `slides/INSTRUCTIONS.md`. Facts come from the sources named per section; do not add numbers that are not listed here.

## Status

- Status: ready for Implementer.
- LinkedIn tips: `slides/linkedin-posts.md` did not exist when this plan was written. Placeholder: see [LinkedIn Tips](#linkedin-tips).

## Build Contract

### Files

Implementer creates exactly two files and edits nothing else:

1. `slides/claude/index.html`: the deck.
2. `index.html` at the repository root: the landing page.

`slides/claude/vscode-setup.png` already exists; reference it relatively as `vscode-setup.png`. Do not inline it as base64 (866 KB).

### Deck (`slides/claude/index.html`)

- **Self-contained.** One HTML file with inline `<style>` and `<script>`. No build step, no external CDN, font, script, or stylesheet. Diagrams are inline SVG or HTML/CSS. Works when opened from disk and on GitHub Pages under a sub-path (relative URLs only).
- **Markup.** One `<section class="slide" id="s-N">` per slide, in plan order. Each slide carries a small section chip (top-left) naming its section, for example `3 · Tokens`.
- **Stage.** Fixed 16:9 stage (design at 1920x1080), scaled with CSS to fit the viewport and letterboxed. Nothing scrolls inside a slide.
- **Navigation.**
  - Next: `ArrowRight`, `ArrowDown`, `Space`, `PageDown`, `Enter`.
  - Previous: `ArrowLeft`, `ArrowUp`, `Shift+Space`, `PageUp`, `Backspace`.
  - `Home` first, `End` last.
  - Ignore keys while focus is in an input or when a modifier other than Shift is held (do not break browser shortcuts).
  - Optional: touch swipe and click on the left or right third of the stage.
- **URL hash.** `#N`, 1-based slide number. Update with `history.replaceState` on navigation, read on load and on `hashchange`, clamp out-of-range values. Browser back and forward should still work via `hashchange`.
- **Slide counter.** Bottom-right, `N / total`, total computed from the DOM.
- **Progress bar.** Thin bar at the top, width `N / total`, accent color.
- **Theme.** Dark, projector-safe:
  - Background `#0f1115`, panels `#181b22`, text `#e8eaf0`, muted text `#a6adbb` (no dimmer than this for any text).
  - Accent `#7aa2ff`. Semantic diagram colors, used consistently across the deck: input `#7aa2ff` (blue), output `#ffb86b` (orange), cache hit `#5fd39a` (green), cache miss or warning `#ff6b6b` (red), neutral/prefix `#8b93a7` (grey), yellow band `#f2d35b`.
  - System font stack for text, system monospace stack for code. Body text at least 28px on the 1920 stage, titles 64 to 80px, code at least 24px.
  - Contrast at least WCAG AA for all text. Do not encode meaning by color alone; label bars and bands.
- **Motion.** Simple fade or none. Honor `prefers-reduced-motion: reduce` with no transitions.
- **Print (optional, nice to have).** `@media print`: one slide per landscape page, hide progress bar and counter, keep the dark theme off (white background, dark text) only if it stays readable.
- **Accessibility.** `<html lang="en">`, a `<title>`, `alt` text on the screenshot, `aria-label` on SVG diagrams, `aria-live="polite"` on the counter.
- **Content rule.** No em dashes anywhere: not the character U+2014, not `&mdash;`, not `&#8212;`. Use a colon, a spaced hyphen, or "to" for ranges. Arrows (`→`) in diagrams are fine.

### Landing Page (`index.html`, repository root)

- Same dark palette, inline CSS, no scripts needed.
- Title "Agent Driven Development", one-line description ("Reusable coding-agent guidance and the workflow behind it."), a prominent link "Claude Code workflow deck" to `slides/claude/` (relative, trailing slash), and a secondary link to `README.md` on GitHub is optional (skip if the remote URL is unknown).
- No em dashes.

### Verification (Implementer runs before reporting)

1. `rg -n '\x{2014}|&mdash;|&#8212;' index.html slides/claude/index.html` returns nothing.
2. `rg -n 'https?://' slides/claude/index.html` shows no external resource loads (plain hyperlinks in text are allowed).
3. Open the deck locally: every slide fits the stage at 1920x1080 and 1280x720 without overflow; keys, hash, counter, and progress bar behave as specified; `#12` on load opens slide 12.
4. `git diff --check`.

## Slide Conventions

- **Title**: punchy, short. **Points**: 3 to 6 terse lines; fragments are fine. **Diagram**: the visual that carries the slide. **Notes**: speaker context and source; not shown on the slide unless marked.
- Define a term before the first slide that relies on it. Slide 3 defines the core vocabulary.
- Inline code (settings keys, commands) in monospace chips.

## Slides

### Opening

#### 1. Claude Code, the ADD Way

- Subtitle: "How I run agents without letting them run me."
- Small footer line: "Agent Driven Development · team session".
- **Diagram**: none; large title, subtitle, and a faint terminal-prompt motif (`❯ claude`) in the background.

#### 2. The Map

- Nine stops, in order: CLI basics · Why the CLI · Tokens and cache · No auto memory · Statusline · Harness tuning · Named sessions · Daily features · Don't be a slave to a Model.
- **Diagram**: horizontal track of 9 numbered stations connected by a line; the last station highlighted in accent as the destination.

#### 3. Five Words Before We Start

- **Token**: the unit a model reads and writes, roughly 3 to 4 characters of English. Usage and limits are counted in tokens.
- **Context window**: everything the model sees on one turn. Opus 5.5 and Sonnet 5.5 have 1M tokens. I compact at 500k.
- **Context**: what currently fills that window: instructions, tools, files read, the conversation so far.
- **Cache**: the provider remembers an exact repeated beginning of the context (the *prefix*) so re-sending it is cheaper.
- **Effort**: how hard the model thinks before answering (low, medium, high, xhigh).
- **Diagram**: five glossary cards in a row, each with a one-word icon drawn in CSS/SVG (token: small block; window: frame; context: filled frame; cache: lightning; effort: dial).

### Section 1: Claude Code CLI Basics

Source: `slides/content.md`, general product behavior.

#### 4. An Agent That Lives in Your Terminal

- Claude Code is a coding agent you run with `claude` in a project folder.
- It reads files, searches, runs shell commands, and edits code, inside your repository.
- Permission mode decides what it may do without asking; a deny list blocks tools outright.
- One terminal = one session = one conversation.
- **Diagram**: loop. `You (prompt)` → `Model` → `Tool call (Read · Edit · Bash)` → `Result back into context` → `Model` → repeats until `Answer`. Draw the tool loop as a circle with 3 nodes, the user enters on the left and the answer exits on the right.

#### 5. Anatomy of a Turn

- Every turn sends the whole stack again, bottom to top.
- System prompt and tool definitions: same for everyone.
- Project guidance: `CLAUDE.md` / `AGENTS.md`, skills list.
- Conversation: every message, file read, and command output so far.
- New prompt on top. The model answers; the answer joins the conversation.
- **Diagram**: vertical stack of 5 layers, bottom up: `System prompt` (grey), `Tools` (grey), `Project: CLAUDE.md, skills` (blue-grey), `Conversation so far` (blue, tallest), `Your new prompt` (blue, thin). A bracket on the right labels the bottom three "prefix: same every turn". An orange box above the stack labeled "Output".

#### 6. Commands You'll Actually Use

- `/clear`: fresh conversation, same session. Use between tasks.
- `/context`: what fills the window, by category.
- `/compact`: summarize the conversation to shrink it.
- `/model`, `/effort`: switch model or thinking depth per task.
- `Shift+Tab`: cycle permission modes.
- `!cmd`: run a shell command yourself; output lands in context.
- `Esc`: interrupt. `/rename`, `/color`: label a session.
- **Diagram**: 3x3 grid of keycap-styled tiles, each with the command large and a 3 to 5 word purpose under it. Highlight `/clear` and `/context` in accent ("use daily").

### Section 2: Why Claude Code CLI

Source: `slides/INSTRUCTIONS.md` section 2, `slides/claude/vscode-setup.png`.

#### 7. Your Editor Stays in Charge

- The CLI plugs into the system you already have; nothing to migrate.
- Agents run in terminal tabs inside VS Code's editor area, as many as needed.
- You keep everything else in hand: search, code navigation, source control, Problems panel, Timeline.
- Same tool in any terminal: VS Code, tmux, SSH.
- One `settings.json`, hooks, and skills shared by every agent tab.
- **Diagram**: schematic of the VS Code window (not the screenshot): left column `Problems · Terminal`, center `Editor area` holding 3 tabs labeled `claude: Planner`, `claude: Implementer`, `claude: Reviewer`, right column `Explorer · Source Control · Timeline`. Center tabs in accent, side panels grey, a caption "agents in the middle, your tools around them".

#### 8. One Window, as Many Agents as You Need

- How: Command Palette → **Terminal: Create New Terminal in Editor Area**, then run `claude`.
- Repeat per agent; split or drag tabs like editors.
- **Diagram**: the screenshot `vscode-setup.png`, fitted to about 80% of stage width, with 5 numbered callout pins (absolute-positioned, percentages of the image box) and a legend:
  1. Command palette entry "Terminal: Create New Terminal in Editor Area" (about x 50%, y 30%).
  2. Terminal in the editor area, center (about x 50%, y 14%).
  3. Problems panel, left (about x 12%, y 13%).
  4. Explorer, right (about x 86%, y 13%).
  5. Source Control and git graph with Timeline, bottom right (about x 86%, y 76%).
- Alt text: "VS Code with Claude Code terminals in the editor area, Problems panel on the left, Explorer and Source Control on the right, Command Palette open on Terminal: Create New Terminal in Editor Area."

### Section 3: Input, Output, and Cached Tokens

Source: `slides/content.md` Token Basics, `agents/knowledge/harness-context-tuning.md` Prefix Cost Model and Subscription Priorities.

#### 9. Every Turn Re-Sends Everything

- **Input tokens**: everything sent each turn: system prompt, tools, `CLAUDE.md`, skills, the whole conversation.
- **Output tokens**: what the model writes. Most expensive per token.
- **Cached input**: an exact repeated prefix. Cheaper, never free.
- A long conversation makes every later turn more expensive.
- **Diagram**: bar chart of 5 turns. Each bar stacked: grey prefix (constant), blue conversation (growing each turn), small orange output cap. Caption under turn 5: "turn 5 pays for turns 1 to 4 again".

#### 10. Cache: Pay 1.25x Once, 0.1x After

- Cache **write** on a miss: 1.25x the normal input price.
- Cache **read** on a hit: 0.1x.
- Keyed on an exact prefix: change one byte and everything after it is a miss.
- Layers: global (system prompt, tools) → project (`CLAUDE.md`, skills) → session (messages).
- **Diagram**: left half: horizontal bar comparison for a 100k-token context: "No cache 100k" (grey), "Miss: write 125k" (red), "Hit: read 10k" (green), drawn to scale. Right half: three nested layer blocks `Global → Project → Session` with a red marker on `Project` labeled "edit CLAUDE.md here: everything to the right re-writes".

#### 11. The 5-Minute Trap

- Default cache lifetime (TTL): 5 minutes.
- Coffee break, meeting, review: cache expires; the next turn re-writes the whole context at 1.25x.
- `"promptCacheTtl": "1h"`: survives breaks. Higher write price, far fewer misses.
- `idleCompaction` (default on): a conversation over its 200k threshold idle about 54 minutes is compacted before the 1h cache expires, so you return to a summary, not a full re-write.
- **Diagram**: two timelines, same events (work, 15 min break, work, 40 min meeting, work). Top "TTL 5m": red "MISS: re-write" markers after both pauses. Bottom "TTL 1h": green "HIT" markers. A code chip `"promptCacheTtl": "1h"` beside the bottom timeline.

#### 12. `/clear`, Not `/resume`

- `/resume` reloads a long history: a full cache write if it expired, plus stale context that drifts.
- `/clear` starts fresh and cheap; decisions live in files, not in chat history.
- Self-documenting work: plans in `agents/plans/`, facts in `agents/knowledge/`, rules in `agents/MEMORY.md`.
- "I almost never use `/resume`." Work documents itself.
- With a 1M window and `autoCompactWindow: 500000`, a session at the 500k cap pays about 50k per turn in cache reads alone.
- **Diagram**: two lanes. Top lane `/resume`: big blue block "up to 500k old history" → red "cache write" → grey "stale decisions" icon. Bottom lane `/clear`: small block "8k prefix" + small green "read plan + knowledge (few k)" → "fresh context, same decisions". Bar on the right comparing per-turn cost: session at the 500k cap ~50k reads vs fresh session small.

### Section 4: No Auto Memory

Source: `slides/content.md` No Auto Memory, `agents/MEMORY.md`, `skills/agent-driven-development/project-memory/SKILL.md`.

#### 13. Hidden Memory Splits the Team

- Auto memory saves notes under `~/.claude/`, outside the repository.
- Two teammates, same repo, same prompt: different hidden context, different output.
- Nobody reviews it, nobody else sees it.
- `"autoMemoryEnabled": false`.
- **Diagram**: two developer columns (A, B) pointing at one shared repo box in the middle. Each developer has a private grey "~/.claude memory" cylinder attached. Same prompt arrow from each → two output boxes, one blue and one orange, labeled "different answer". Red "diverged" tag between them.

#### 14. Learn in the Repo, Not in Your Home Folder

- Project memory is versioned, reviewed, and shared: `agents/MEMORY.md`, `agents/knowledge/`, `agents/plans/`.
- This is harness engineering: the repository is the agent's learning environment.
- Correction → rule in `MEMORY.md` → commit → every teammate's agent learns it.
- Self-improvement goes through code review like any other change.
- **Diagram**: cycle of 4 nodes around the repo icon: `Correction` → `Rule written to MEMORY.md` → `Commit / PR` → `Every agent on the team reads it` → back to work. Contrast inset (small, grey): "auto memory: one laptop, unreviewed".

### Section 5: Statusline

Source: `docs/statusline-prompt.md`.

#### 15. One Line, Five Gauges

- Target line, shown large in monospace: `Opus • Medium • CTX 18% • 51%(+19) 1h36m • 64%(+29) 2d10h`
- `Opus`: model family. `Medium`: effort level.
- `CTX 18%`: context used against the 500k compact cap (rescaled from the 1M window).
- `51%(+19) 1h36m`: 5-hour limit window: quota left, surplus, time to reset.
- `64%(+29) 2d10h`: 7-day limit window, same format.
- Setup: paste `docs/statusline-prompt.md` into a fresh session. One `jq` script, missing fields drop cleanly.
- **Diagram**: the line rendered big, centered, with leader lines down to 5 labeled boxes (model, effort, context, 5h window, 7d window). Surplus values tinted green as they would be in the terminal; separators bold.

#### 16. Even-Burn Pace: Ahead or Behind?

- **Remaining**: `100 - used%`.
- **Even-burn pace**: the share of the window still on the clock. What you would have left if you burned evenly.
- **Surplus** = remaining - pace. Positive: ahead of budget. Negative: slow down or switch model.
- Worked example (5h window): 1h36m left of 5h → pace 32%. Remaining 51%. Surplus +19.
- Colors: green above +5, yellow +5 to -5, red below -5.
- **Diagram**: two aligned horizontal bars for the 5h window, 0 to 100%. Top "Time left on the clock": 32% filled grey. Bottom "Quota left": 51% filled blue. A green bracket between the two right edges labeled "+19 surplus". Below, a number line from -30 to +30 with red / yellow / green bands and labels at -5 and +5.

#### 16b. Say "Good Morning" to Claude

Added by user request after planning; deck now has 36 slides.

- The 5-hour window starts at your first message, not at a fixed clock time.
- Trick: a scheduled task at claude.ai/scheduled-task sends a tiny prompt ("Good morning") at 6:00 AM, before work starts.
- Window 1 runs 6 to 11 AM and refreshes at 11 AM, mid-morning. Work 9 to 6 then spans three windows (6-11, 11-4, 4-9) instead of two.
- Cost: one trivial message. Gain: a fresh 5-hour quota before lunch.
- Source: the user's LinkedIn post (7 months ago); see `slides/linkedin-posts.md` "5-Hour Window Trick".
- **Diagram**: a horizontal day timeline 6 AM to 9 PM. Grey band "office hours 9 AM to 6 PM". Top row "No ping": windows start at 9 AM (9-2, 2-7), two blue blocks. Bottom row "6 AM scheduled ping": three green blocks 6-11, 11-4, 4-9, with a small sun icon and "Good morning" bubble at 6 AM. Caption: "3 refreshes inside one workday".

### Section 6: Harness Context Tuning

Source: `agents/knowledge/harness-context-tuning.md`. Numbers: Opus 5, Claude Code 2.1.263, this repository, interactive `/context`.

#### 17. Measure the Real Thing

- Measure with `/context` in a real interactive session: total minus `Messages` = prefix.
- Never with `claude -p`: print mode loads about 3k of tools vs about 21k interactively. Two full sweeps were wasted on this.
- Pin the model: one setting measured 2,947 tokens on Haiku and 693 on Opus.
- `--settings` merges deny lists; it cannot remove a rule.
- **Diagram**: bar comparison "Tool definitions loaded": `claude -p` ~3k (short grey bar) vs interactive ~21k (long blue bar), with a red caption "print mode hides the biggest levers".

#### 18. Feature Flags: 27.6k → 8.3k

- Stock prefix ~27.6k tokens; tuned ~8.3k. Saved ~19.3k (70%).
- 18.2k of that is the tool row: features you never use still ship their tool definitions.
- The flags: `disableWorkflows`, `disableAgentView`, `enableArtifact: false`, `disableClaudeAiConnectors`, `disableRemoteControl` (left on here: Remote Control is in use).
- Set once; every session after starts lighter.
- **Diagram**: grouped horizontal bars by category, stock (grey) vs final (accent): System tools 21k → 2.8k, System prompt 3k → 2.7k, Skills 3.2k → 2.3k, Memory files 0.4k → 0.4k. Totals row emphasized: 27.6k → 8.3k. Draw to scale.

#### 19. Deny What You Don't Use

- A bare tool name in `permissions.deny` removes its definition from the prefix.
- Cutting the deny list to one entry: prefix 9.4k → 10.6k, tools 3k → 5.1k.
- Denying `Agent` alone saves about 1.1k.
- Scoped rules such as `Read(**/.env)` save nothing; they discourage reads, but they are not a security boundary. Agents route around hooks, deny lists, and permissions; protect private files with an OS-level lock (`docs/securing-files-from-agents.md`).
- Never deny `ToolSearch` (loads deferred tools) or `TaskStop` (stops background Bash).
- **Diagram**: two columns. Left "Removes a tool definition" with green chips: `Agent` (~1.1k), `ScheduleWakeup`, `CronCreate`, `NotebookEdit`, `SendFeedback` (per-entry savings unmeasured except `Agent`; show no other numbers). Right "Speed bump, not a lock" with grey chips: `Read(**/.env)`, `Read(**/.env.*)`. Bottom red strip "Never deny: ToolSearch · TaskStop".

#### 19b. Lock It at the OS Level

Added by user request after planning; deck now has 37 slides. Source: `docs/securing-files-from-agents.md`, `slides/linkedin-posts.md` "Security: Agents Bypass Soft Guards".

- Everything inside the harness is bypassable: hooks, deny list, permissions, "never read this folder" in `CLAUDE.md`. `.gitignore` does not block reads either.
- Real case: Chrome blocked Opus 5.5 from uploading an image. It converted the PNG to Base64, embedded it in a JavaScript file, rebuilt the File in the page, and uploaded anyway.
- Fix: a root-owned folder lock. Owner to root, mode `000`, immutable flag (`chflags schg` on macOS, `chattr +i` on Linux). An agent running as your user cannot `chmod` it back.
- Routine: stop the agent → `sudo bash folder_lock.sh lock /abs/path` → `sudo -k` → work → stop the agent → unlock → `sudo -k`.
- Limits: passwordless or cached sudo undoes it; it does not protect backups, git history, cloud sync, or anything already sent to the agent. Access control, not encryption. Windows: separate agent account plus `icacls` deny.
- Keep deny rules and hooks as extra layers; give the agent sanitized examples and scoped dev credentials.
- **Diagram**: left: concentric shield. Outer three rings dashed and grey, labeled `CLAUDE.md instruction`, `deny list + permissions`, `hooks`; a red arrow labeled "agent" passes straight through all three with a small "bypassed" tag. Inner ring solid green, labeled `OS lock: root owner · mode 000 · immutable`, and the arrow stops at it. Right: a vertical sequence strip `Stop agent` → `lock` → `sudo -k` → `Run agent` → `Stop agent` → `unlock` → `sudo -k`, with the two `sudo -k` steps highlighted in yellow ("drop cached sudo").

#### 20. Cut, Don't Cache

- Prefix of size N costs N x 1.25 on a miss, N x 0.1 on every later read. Caching lowers the cost; it never removes it.
- Cutting prefix tokens beats caching them.
- Per-turn levers shrink conversation growth:
  - `bashOutputMaxChars: 8000` (default 30000); overflow goes to a file.
  - `rtk` hook condenses Bash output before it enters context.
  - `respondToBashCommands: false`: `!` output with no model reply.
  - `autoCompactWindow: 500000`: compact at 500k, not near 1M.
- **Diagram**: left: formula card `cost = N × 1.25 (miss) + N × 0.1 × turns`. Right: a funnel labeled "Bash output 30k" narrowing through `rtk` and `bashOutputMaxChars 8k` to "what enters context".

#### 21. On a Subscription, Context Size Wins

- Ranked levers on Claude Pro / Max:
  1. `/clear` between tasks, keep auto compact on. At the 500k compact cap a session costs about 50k per turn in cache reads.
  2. Model choice: Opus uses budget several times faster than Sonnet.
  3. Feature flags: about 18k once, then free.
- Editing `CLAUDE.md`, `AGENTS.md`, or skills invalidates the project cache layer: batch guidance edits.
- **Diagram**: podium with three steps labeled 1, 2, 3 and the lever names; step 1 tallest in accent. Side note card in red: "edit guidance in batches".

### Section 7: Named Sessions Over Subagents

Source: `docs/claude/CLAUDE_TEAMS.md`.

#### 22. A Team, Not a Swarm

- One terminal per role, named with `claude -n`. They message each other directly.
- Per-role model and effort at launch:
  - Orchestrator: Opus 5.5, medium.
  - Planner: Opus 5.5, medium.
  - Implementer: Sonnet 5.5, low.
  - Reviewer: Sonnet 5.5, high.
  - Testwriter: Sonnet 5.5, medium.
- This deck was built this way: Orchestrator gathered sources, Planner wrote the plan, Implementer built the HTML.
- **Diagram**: five rounded nodes with the session colors from the doc (Orchestrator orange, Planner blue, Implementer green, Reviewer yellow, Testwriter purple), each showing model and effort. Arrows: You ↔ Orchestrator; Orchestrator → Planner ("spec"); Orchestrator → Implementer ("build"); Implementer → Reviewer and Testwriter ("ready"); Reviewer and Testwriter → Implementer ("file:line, failing test", drawn as a loop); Implementer → Orchestrator ("done"). Small code chip under the diagram: `claude -n "Implementer" --model claude-sonnet-5-5 --effort low`.

#### 23. Why Named Sessions Beat Subagents

- **Persistent memory**: Planner and Implementer keep architectural context across tasks; `/clear` only the Orchestrator.
- **Direct feedback loops**: Reviewer and Testwriter send Implementer the exact file, line, and failure.
- **Per-role model and effort**: Opus where judgment matters, Sonnet where volume matters.
- **Human intervention**: switch to any terminal, inspect, redirect, approve.
- Costs, honestly: manual terminal setup, growing context in long-lived sessions, file conflicts when two roles edit the same file.
- Setup: do not deny `SendMessage` or `ListAgents`; `/list-agents` to verify; unset `CLAUDE_CODE_EFFORT_LEVEL` so `--effort` applies.
- **Diagram**: two-column comparison table, rows: Context, Communication, Steering, Model/effort, Visibility. Left column "Named sessions" with green checks, right "Subagents" with grey notes ("through parent", "inherited", "via parent"). Cons as a red-outlined strip at the bottom.

### Section 8: Other Features I Use Daily

Source: `slides/content.md` Daily Claude Code Features, `.claude/settings.json`.

#### 24. Plan in Files, Not in a Mode

Source: `skills/agent-driven-development/spec-driven-development/SKILL.md` (not built-in plan mode, which is not used).

- No built-in plan mode. Planning is the `spec-driven-development` skill; a plan is a plain Markdown file in `agents/plans/`.
- Triggers by itself when work spans files or layers, changes behavior or contracts, or needs design decisions. Skips renames and copy edits.
- A plan holds: goal with numbered acceptance criteria, decisions, open questions (ID, owner, what it blocks, recommendation), ordered tasks with a checkpoint each.
- Ready when a fresh implementer needs no material design choices, so `/clear` or another session (Planner → Implementer) picks it up cold.
- On completion, durable decisions move to `agents/knowledge/`; the plan stays, marked complete.
- Versioned, reviewed, shared, and works the same in any agent harness.
- **Diagram**: flow `Prompt` → `spec-driven-development triggers` → `agents/plans/x.md` (file icon highlighted, with two inner rows: "goal + acceptance criteria", "tasks + checkpoints") → `You review` → `/clear` or `Implementer` (green) → task checklist `1 ✓ 2 ✓ 3 …` → `agents/knowledge/` (durable decisions). A small note under the plan file: "survives /clear, sessions, and teammates".

#### 25. Let It Run, Safely

- Auto mode (`defaultMode: "auto"`) plus a curated deny list: fewer prompts, hard limits stay.
- Hooks: an `rtk` PreToolUse hook rewrites Bash calls to condense output.
- `AskUserQuestion`: the agent asks with options instead of guessing.
- Remote Control with push notifications: answer the agent from your phone.
- **Diagram**: concentric rings: outer "deny list (hard no)", middle "auto mode classifier", inner "agent works". Side icons for hook (filter), question (speech bubble), phone (Remote Control).

#### 26. Small Habits, Big Hours

- `!git status`: run it yourself, output enters context, no model reply.
- `/model` and `/effort` per task: Opus 5.5 medium by default, Sonnet 5.5 for implementation.
- Skills in `.claude/skills/`, gated by `skillOverrides`.
- Vim editor mode (`ii` to escape) and focus view.
- `playwright-cli` skill: the agent drives a real browser (next section).
- `/context` when a session feels slow; `/compact` when needed.
- **Diagram**: 2x3 card grid, each card a command chip plus a one-line benefit. No chart.

### Section 8b: Browser on a Leash

Added by user request after planning; deck now has 39 slides. Section chip: `8b · Browser`. Sources: `docs/playwright-cli_setup.md`, `.claude/skills/playwright-cli/SKILL.md`, `.claude/skills/playwright-cli/references/session-management.md`, the user's stated reasons.

#### 26b. Attach When You Need It, Detach When You're Done

- `playwright-cli -s=li attach --extension=chrome`: the agent drives your own Chrome through the Playwright extension.
- `-s=li` names the browser session (`li`: LinkedIn). Commands with the same `-s` go to that session only; this deck's LinkedIn tips were collected this way.
- Attaching needs your approval: Chrome shows a prompt from the extension and you confirm it.
- `playwright-cli -s=li detach`: the agent lets go; your browser keeps running.
- In between, plain shell commands: `snapshot`, `click`, `fill`, `screenshot`.
- Setup once: Playwright extension in Chrome, `npm install -g @playwright/cli`, `playwright-cli install --skills`.
- **Diagram**: horizontal timeline of one browser lifetime (long grey bar "your Chrome, always yours"). Above it, a short green band "agent connected" that starts at an `attach` marker (with a small "you approve in Chrome" check icon) and ends at a `detach` marker. Before and after the band, labels "agent has no access". Under the green band, three command chips: `snapshot`, `click`, `fill`.

#### 26c. Why Not Computer Use or Browser Use?

- **Agent agnostic**: a CLI plus a skill. Claude Code, Codex, or any agent with a shell runs the same commands; switching models or harnesses changes nothing.
- **Security**: nothing is connected until you attach, you approve it in Chrome, and you choose what to hand over, when.
- **Detach ends it**: one command, the agent is gone, the browser stays.
- **No background work**: no agent browsing on its own while you are not looking.
- Same principle as the rest of the deck: you stay in control, the model is replaceable.
- **Diagram**: three columns, one row per property: "Works with any agent", "You decide when it connects", "Clean disconnect", "Nothing runs in the background". Column 1 `playwright-cli attach --extension` in accent with green checks on every row. Columns 2 `Computer use` and 3 `Browser-use agents` dimmed grey, cells left as a muted "depends on the tool" text, not crosses: the slide argues for the chosen tool and makes no measured claims about the others.

### Section 9: Don't Be a Slave to a Model

Source: `skills/agent-driven-development/*/SKILL.md`, `agents/MEMORY.md`, `agents/knowledge/harness-context-tuning.md` (as a worked example).

#### 27. Don't Be a Slave to a Model

- Section title slide.
- Models change every few months. Your workflow, knowledge, and rules should not.
- Agent Driven Development: the repository teaches the agent, not the other way around.
- **Diagram**: large title. Below, a strip of three model chips (`Opus`, `Sonnet`, `next model`) sitting on a thick foundation bar labeled `skills · knowledge · plans · memory`. Models are replaceable blocks; the foundation stays.

#### 28. Five Skills, One System

- `communication`: how it talks. Terse, outcome first.
- `engineering`: what to build, how far the change reaches, when it is done.
- `coding`: what the lines look like.
- `spec-driven-development`: owns `agents/knowledge/` and `agents/plans/`.
- `project-memory`: owns `agents/MEMORY.md`; turns corrections into rules.
- Each skill owns one concern and points to the others; no duplicated rules.
- **Diagram**: layered architecture. Top band `communication` (spans everything, it is how every answer is delivered). Middle: `engineering` (judgment) above `coding` (craft), with an arrow "decides scope → shapes lines". Side pillar on the left `spec-driven-development` (knowledge + plans) and right `project-memory` (MEMORY.md), both feeding into the middle. Bottom foundation "the repository".

#### 29. Knowledge Stops Drift

- Code is the source of truth for current behavior; knowledge records why: decisions, rejected alternatives, invariants, ownership.
- Verify before trusting: every knowledge claim about code is a lead, checked in code.
- Without it, a fresh agent re-explores and can pick an approach already proven wrong.
- Real example: `harness-context-tuning.md` keeps "Superseded Findings". Two passes measured with `claude -p` and got wrong numbers; the file stops the next agent repeating it.
- **Diagram**: two paths from "New task". Top path (no knowledge): `explore` → `guess` → red `wrong approach` → `redo`. Bottom path (knowledge): `read knowledge file` → `verify in code` → green `right approach`. The bottom path is visibly shorter.

#### 30. Pay Once, Read Forever

- Exploration is paid every session; a knowledge file is paid once, then read in a few thousand tokens.
- Plans survive `/clear`: no `/resume`, no reload of up to 500k of history.
- Small, scoped files: the agent reads only the topic it needs.
- Rules in `MEMORY.md` prevent the same correction (and its tokens) from repeating.
- **Diagram**: illustrative line chart, clearly labeled "illustrative, not measured": x axis "sessions on the same topic" 1 to 6, y axis "tokens spent". Red line "re-explore every time": flat high. Green line "knowledge + plans": one high point at session 1 (writing it), then low and flat. Shaded area between labeled "saved".

#### 31. Corrections Become Rules

- Signal: a correction, a rejected pattern, a repeated instruction, a stated preference.
- Loop: fix the work → write a one-line rule → apply it for the rest of the session.
- A repeated correction is a memory failure, not a one-off.
- Record the rule, not the incident. Compress past ~50 lines.
- Example rule from this repo: "Do not use em dashes anywhere in repository prose."
- **Diagram**: 4-step cycle: `Notice the signal` → `Fix the work` → `Write the rule` → `Apply it`, with a "repeat = memory failure" red badge on the arrow back to the start. The example rule shown as a git-diff style `+ ` line beside the cycle.

#### 32. Guardrails, Not Vibes

- Engineering priority: 1 correctness and security, 2 explicit requirements, 3 local consistency, 4 simplicity, 5 brevity.
- Surgical edits: every changed line traces to the request. Mention unrelated issues; don't fix them unasked.
- Claim passes only from actual runs; report what was skipped.
- Coding: guard clauses, intent-revealing names, no `any` or unchecked casts, test behavior not implementation, YAGNI.
- The model is fast; these keep it in check.
- **Diagram**: left: priority stack of 5 bars, widest at the top (correctness) narrowing down. Right: a road with two guardrails labeled `engineering` (scope, verification) and `coding` (craft, tests), a car labeled "agent" in the lane.

#### 33. Talk Less, Say More

- Every token costs money and reader time. Output tokens are the most expensive.
- Lead with the outcome and why it matters; detail only when it helps you decide, act, or verify.
- Communication is a must: the agent's report is how you decide what to approve.
- Compress chat, never code, docs, commits, or reviews.
- Example: `Build fixed. Root cause: server-only module reached a Client Component via app/(dashboard)/layout.tsx:12. Run bun run build to confirm.`
- **Diagram**: side-by-side message bubbles. Left "Default": a long bubble of placeholder grey lines (about 12 lines). Right "communication skill": the one-line example above. Below each, an orange output-token bar sized proportionally (long vs short).

#### 34. Questions Are Read-Only

- A question asks for an answer, not a change.
- "Should we...?", "how hard would it be...?", "why does...?" → answer, offer the change, wait.
- Even for an obvious trivial fix.
- Prevents surprise diffs, wasted tokens on unwanted edits, and review churn.
- **Diagram**: decision diamond "Is it a question?". Yes → `Answer` → `Offer` → `Wait for approval` (green, no file icon touched). No (instruction) → `Act` (edits allowed). A crossed-out pencil icon on the Yes branch.

### Closing

#### 35. Make It Yours

- Main line, large, centered: **"Don't copy. Read, explore, and make your own workflow. But follow it as a team."**
- Small footer: repository name "ADD" and "skills/ · agents/ · docs/" as where to start reading.
- **Diagram**: none beyond typography; optional faint background of the slide 27 foundation bar.

## LinkedIn Tips

Placeholder. `slides/linkedin-posts.md` was absent when this plan was written. If it exists at implementation time, Implementer adds at most one short tip line (a quote-styled footer, muted color) to the most relevant slide per tip, for example:

- Tips on context or `/clear` → slides 9 to 12.
- Tips on settings or tokens → slides 17 to 21.
- Tips on multi-agent work → slides 22 to 23.
- Tips on skills, memory, or prompting discipline → slides 28 to 34.

Do not add slides for tips and do not change any number above. If the file is absent, ship without tips.

## Open Questions

None blocking. Orchestrator may confirm the deck title (slide 1) and subtitle wording with the user.

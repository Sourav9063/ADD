# Slide Deck Instructions

The user's brief for the team presentation, recorded verbatim in intent. The deck lives at `slides/claude/index.html`; the repository root `index.html` is the GitHub Pages entry and links to it.

## Audience

The team has a basic introduction to Claude. Not a deep dive. Explain the why before the how; define terms (tokens, cache, context window) before using them.

## Required Sections, In Order

1. **Claude Code CLI basics.** What it is, how a session works, core slash commands.
2. **Why Claude Code CLI over other tools.** It integrates with the existing system. In VS Code the user opens Claude Code in terminal tabs inside the editor area (Command Palette: "Terminal: Create New Terminal in Editor Area") and opens as many agents as needed, while keeping everything else in hand: VS Code search, code navigation, source control, Problems panel, Timeline. Screenshot: `slides/claude/vscode-setup.png`.
3. **Input, output, and cached tokens.** Why `promptCacheTtl` should be `1h`. Always prefer `/clear`; avoid `/resume`. The user almost never uses `/resume` because work is self-documenting through knowledge and plans.
4. **No auto memory.** In a group project auto memory makes output diverge between teammates because it is saved outside the project scope. Use project space instead for harness engineering and self-improvement.
5. **Statusline.** Source: `docs/statusline-prompt.md`. Show the target line and explain each field, especially even-burn pace and surplus.
6. **Harness context tuning.** Source: `agents/knowledge/harness-context-tuning.md`. Most important points only: measure interactively, feature flags are the dominant lever (~27.6k to ~8.3k prefix), deny rules, per-turn levers, prefix cost model, subscription priorities.
7. **Named sessions over subagents.** Source: `docs/claude/CLAUDE_TEAMS.md`. Why it is better: persistent session memory, direct feedback loops, per-role model and effort, human intervention.
8. **Other Claude Code features used daily.** See `slides/content.md`.
9. **Don't be a slave to a Model.** The `skills/agent-driven-development/` skills: how they work together, how they save tokens in the long run, how knowledge keeps the agent from drifting or using a wrong approach, why engineering and coding skills keep the agent in check, why communication is a must, and how "Questions Are Read-Only" prevents unnecessary edits.
10. **Last slide.** "Don't copy. Read, explore, and make your own workflow. But follow it as a team."

## Story Structure (2026-11-25)

Overrides `slides/PLAN.md` where they differ. The sections above stay the required topics.

- Tell every topic as What hurt, What I needed, What I changed, What I got, with the same card and rail layout on each slide. Fit all four on one slide; add a follow-up slide only when a second graphic earns it. Keep the main talk short by merging. Never drop content: detail that leaves the main talk moves to the appendix after the closing slide. Appendix slides keep their original layout. A slide promoted into the main talk is rewritten in the main tone (first person, short story cards) and removed from the appendix; do not repeat a point or graphic within the main talk. Opening, glossary, section-title, and closing slides are exempt.
- Wording may change; the problem comes first, and the graphic carries the slide. Prefer graphics, screenshots supplied by the user, or material from the user's LinkedIn posts.
- **Project structure** comes first, before the map: `.claude/` (`skills/`, `settings.json`), `agents/` (`knowledge/`, `plans/`, `MEMORY.md`), `CLAUDE.md`.
- **CLI**: What hurt is that Claude Desktop or another harness such as Orca means relearning everything (finding references, keyboard shortcuts) and has missing features. The CLI also brings headless mode and works anywhere. Do not use the "copy and paste from a chat window" story.
- **How an agent works** follows the CLI slide: what the model sees (system prompt, tools, `CLAUDE.md`, skill list, conversation, prompt), then the tool loop. The commands slide was removed at the user's request.
- **Harness tuning**: stock prefix is 32k now; `autoCompactWindow` is 500000. Keep lever sizes, same-model recheck, and subscription ranking in the main talk. The "Measure the Real Thing" and "Settings That Silently Do Nothing" slides were removed at the user's request.
- **Workflow** follows Harness. `skills/agent-driven-development/` is the crown jewel: explain why each skill exists, why `MEMORY.md` exists beside `CLAUDE.md` (editing `CLAUDE.md` invalidates the cache), why communication matters, and why questions get answers, not writes. Claim the engineering core of pstack, Matt Pocock, and Superpowers, not every skill: planning, learning, and debugging live in other skills, and some practices are excluded on purpose.
- **Knowledge and spec-driven-development** follow "Plan in Files, Not in a Mode": the knowledge folder first, then code as source of truth, when specs apply, plan anatomy, and plan to done. Source: `skills/agent-driven-development/spec-driven-development/SKILL.md`.
- **Browser**: What hurt is that real work needs the user's logged-in session, while built-in agent browsers run a session the user does not control. What I got is that the session is kept, access is temporary, and reusable scripts reduce token use.
- **Surplus**: a constant runner uses 100% in exactly 5 hours; the real user lags with a realistic workload. The gap is the surplus.
- **Settings**: emphasize `idleCompaction: true` and similar settings.

## Style

- Informative, with diagrams. Punchy headers such as "Don't be a slave to a Model".
- Reuse tips from the user's LinkedIn posts where they fit; see `slides/linkedin-posts.md`.
- No em dashes (repository rule).

## Process

Built with the named-session workflow: Orchestrator gathered sources, Planner wrote `slides/PLAN.md`, Implementer built the HTML.

# LinkedIn Tips (Curated)

Tips from the user's LinkedIn activity (linkedin.com/in/sourav-ahmed), newest first, up to the "Cloudflare: Yeah we prevented 11.5 Tb/s DDoS attack. useEffect: Hold my beer" post. Only posts relevant to the deck are kept; quotes are lightly trimmed. Use at most one footer tip per relevant slide.

## Security: Agents Bypass Soft Guards (5 days ago)

"You must use an OS-level lock to protect private files from agents. Everything is bypassable: hooks, deny list, permissions, 'Never read this folder' in CLAUDE.md." Chrome blocked Opus 5.5 from uploading an image, so it converted the PNG to Base64, embedded it in a JavaScript file, ran it in the page, rebuilt the File, and triggered the upload. Write-up: `docs/securing-files-from-agents.md`.

Fits: deny rules slide (deny saves tokens, not a security boundary), engineering "keep the agent in check".

## Hallucination Defense (2 weeks ago)

A model "hallucinates, then defends its hallucinations and makes you question your expertise." Be very careful.

Fits: "Don't be a slave to a Model".

## Statusline (2 months ago)

`Opus • Medium • CTX 5% • 92%(+20) 3h35m • 61%(+29) 2d6h`. "92% left tells you nothing on its own. 92% with 4 hours to go is healthy. 92% with 20 minutes to go means you wasted a window." The surplus turns a raw percentage into a decision: push harder, or pace yourself. One signed number, green/yellow/red, read at a glance while the agent is still thinking.

Fits: statusline slides.

## Cut the System Prompt by 70% (2 months ago)

Stock 27.6k, tuned 8.3k, saved 19.3k per request. 18.2k of it is tool schemas. "Turn off features you do not use. Deny rules work the same way." "A feature you actually need is worth more than the tokens." "Do not trust numbers from a blog post, including mine." Check with `/context`: total minus Messages.

Fits: harness context tuning slides.

## ADD in 1k Tokens (3 months ago)

Whole workflow (simple SDD, memory system, caveman, grill-me, Karpathy-style rules, engineering principles) in ~1k tokens appended to CLAUDE.md or AGENTS.md. "Assume every change will be rigorously reviewed by a senior engineer." Why it works: newer models are already trained on these skills, so only the trigger is needed.

Fits: ADD overview, token savings.

## Effort Switch Keeps the Cache (4 months ago)

Changing effort level does not force the model to re-read files and keeps the cache. After planning, drop effort to low in the same session and tell it to execute the plan.

Fits: cache slide, named sessions (per-role effort).

## "I Ship Code I Don't Read" (4 months ago)

Like "Don't Look Up": just believe the token seller. Rejected.

Fits: "Don't be a slave to a Model".

## SearchDeck VS Code Extension (4 months ago)

Built for ADD: search the codebase, read the file, give the agent the right context. Tabbed persistent searches, fuzzy text/path/symbol search, `alt+enter` copies `@relative/path` for the agent. 600+ installs in 24h.

Fits: VS Code integration slide.

## Combined Working Rules (5 months ago)

Karpathy skill, grill-me, and caveman combined into a short CLAUDE.md block: think before coding, ask one question at a time with options, push back on weak instructions, simplest local pattern, surgical edits, clean only own changes, plan with success checks. "I hardly find any difference in output quality."

Fits: ADD history, communication.

## Codex vs Claude Code (5 months ago)

Tried Codex CLI for a month. Pros: rereads and checks git status, runs tests, less output. Cons: no real `/rewind`, no cloud scheduler, worse UI design, once removed a hand-coded crucial part while "optimizing" a hook. Came back to Claude Code.

Fits: "Why Claude Code".

## Human in the Loop Is the Strategy (7 months ago)

Opus tried 6 technically sound, wrong approaches to a Chrome extension bug. The fix was one parameter, found by stopping the agent and comparing two curl commands. "The agent was solving the problem it diagnosed. I solved the problem that existed." "6 attempts by the agent. 1 observation by a human."

Also: "No matter how good your AGENT is, you must review its output."

Fits: diagnosing / engineering, "Don't be a slave to a Model".

## 5-Hour Window Trick (7 months ago)

Say "Good morning" to Claude at 6 AM: the 5-hour window starts early and refreshes at 11 AM, so you get 3 refreshes before 6 PM.

Fits: statusline / rate limits.

## 13 Findings After Months of Agents (8 months ago)

1. Unnecessary context kills intelligence. Plan first, review the plan, then execute.
2. You don't need all those MCPs; they cost tokens.
3. Token thriftiness is a skill. Compress AGENTS.md; move non-every-chat knowledge into separate files.
4. Dump workflow knowledge into `agent/[workflow]-knowledge.md`.
5. `/clear` after completing a task. Don't drag chats.
6. Use git stage as a restore point: stage the 50% good output, then give new instructions. VS Code diff viewer tracks it.
7. VS Code opens terminals in the editor area as tabs: keybinding `alt+t alt+t` to `workbench.action.createTerminalEditor`.
8. Agents WILL forget and won't follow CLAUDE.md.
9. Agents are lazy: magic numbers, duplicate functions, ignored design principles. Check and sanitize.
10. Use strict linting (e.g. Biome).
11. "Whether you hand type or generate or copy paste: YOU ARE RESPONSIBLE, NOT THE AGENTS."

Fits: VS Code slide (7), cache/clear slide (5), knowledge (4), coding skill (9, 10), closing (11).

# Opus 5.5 Skill Proposals

Status: parked. Applied once, then reverted: current agents work well without these changes. Revisit if an observed failure matches one below.

Source: "Getting the most out of Opus 5.5 in Claude and Claude Code", Addy Osmani, claude.dev, 2026-09-22.

## Proposals

Each entry: target, proposed text, the article claim behind it, and the failure that would justify applying it.

### 1. Drop reasoning nudges

- Target: `skills/agent-driven-development/engineering/SKILL.md`, Before Coding; mirror in `AGENTS_STANDALONE.md`.
- Change: `Inspect relevant code and think before coding.` → `Inspect relevant code before coding.`
- Optional: cut the Execution lines "Assume every change will be rigorously reviewed by a senior engineer." and "Impress with sound judgment…". This is my suggestion, not the article's; the lines state a goal without saying what to do.
- Claim: Opus 5.5 always thinks before replying and chooses how much. Removing a "think carefully" line made replies start sooner with no clear quality drop.
- Apply if: responses are slow to start on simple tasks.

### 2. Rule against over-prompting

- Target: `skills/misc/writing-agent-guidance/SKILL.md`, Write for Reliable Behavior.
- Text:
  > Omit reasoning nudges such as "think carefully" or "step by step"; models set their own depth, and effort settings control it. State the finish line instead, and write "Answer directly" when a quick answer is wanted. Never ask for internal reasoning in the output; ask for a short rationale instead.
- Claim: requests to reproduce internal reasoning can be declined and are a safeguard flag category.
- Apply if: authored guidance starts adding thinking nudges or asking for reasoning in the output.

### 3. Name the stops

- Target: `engineering`, Execution; mirror in `AGENTS_STANDALONE.md`.
- Text:
  > Keep going through steps that do not need the user. Put status notes in the same message as the next action; do not end a turn by naming the next step, offering to continue, or listing choices that do not block the work. Stop only when you cannot continue without the user, or before deleting data, force-pushing, or changing anything outside the repository.
- Claim: on long tasks Opus 5.5 sometimes stops early to report: a summary naming the next step, an offer to continue, or choices that don't block the work. It follows instructions that name these stops.
- Apply if: runs end with "Want me to continue?" often.
- Conflict to check: `communication` › Request Intent intentionally stops on ambiguous intent. Keep that stop.

### 4. Shape of the end-of-run summary

- Target: `skills/agent-driven-development/communication/SKILL.md`; mirror in `AGENTS_STANDALONE.md`.
- Text: `After multi-step work, lead with anything blocked on the user, then what changed, then what was found.`
- Claim: read what Claude needs from you first; example format "Blocked on me, Changed, Found."
- Apply if: open decisions get buried in long summaries.

### 5. Mark what could not be confirmed

- Target: `engineering`, Execution, the "Never claim a check passed" line; mirror in `AGENTS_STANDALONE.md`.
- Text: append `, and mark anything you could not confirm, saying where you looked.`
- Claim: asking for "I couldn't find this" makes gaps easy to spot.
- Apply if: research or analysis presents unverified claims as fact.

### 6. Subagent fan-out with evidence checks

- Target: `skills/agent-driven-development/spec-driven-development/SKILL.md`, Plans, after the independent-review paragraph; mirror in `AGENTS_STANDALONE.md`.
- Text:
  > For audits, migrations, or reviews across a large codebase, give each independent slice its own subagent, check each report's evidence before accepting it, and consolidate the results into one table in the plan.
- Claim: testers had Opus 5.5 coordinate parallel subagents on long audits and migrations.
- Apply if: large audits run serially and exhaust context, or subagent reports get accepted without evidence.

### 7. Show how each finding fails

- Target: `skills/agent-driven-review/reviewing-changes/SKILL.md`, Finding Rules.
- Text: `Each finding needs severity, file:line, concrete failure mode, how to show it fails (a test, command, or input), and fix direction.`
- Optional, larger change: report only Blocking and High findings by default. The article's review prompt asks for merge-blocking problems only.
- Claim: Opus 5.5 caught more bugs with fewer false alarms. Requiring a failing demonstration keeps findings checkable.
- Apply if: reviews produce false alarms or findings that can't be verified.

### 8. Name the default design styles

- Target: `skills/web-design/visual-direction/SKILL.md`, the "Nothing" branch of the direction sources.
- Text:
  > Rule out named defaults before choosing: cream or off-white backgrounds, italic accent words in headings, numbered "01 / 02 / 03" section labels, monospace labels, and pill-shaped buttons. "Avoid a generic look" only swaps one default for another; when the replacement is also a default, name it and choose again.
- Claim: with no direction, Opus 5.5 falls back on a few default styles. A list of specific patterns works better than "avoid a generic look."
- Apply if: unguided UI output keeps showing these styles.

## Not Skill Material

These are user-side tips or settings, not agent rules: fast mode, what to do when a message is flagged, attaching screenshots instead of retyping numbers, and the "earlier answers are settled" project instruction. `agents/plans/` already covers the article's TASKS.md advice.

## Side Finding

`visual-direction` (the "wall of feature cards" paragraph) and `landing-page-design` (the "Show it rather than describing it" bullet) state the same rule. Give it one owner and point to it from the other.

## If Applied

- Mirror `agent-driven-development/*` edits byte-for-byte into `AGENTS_STANDALONE.md`.
- The maintainer syncs `.agents/skills/` and `.claude/skills/`.
- Have a fresh agent try each change on realistic tasks before keeping it, as `writing-agent-guidance` asks.

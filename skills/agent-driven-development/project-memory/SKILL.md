---
name: project-memory
description: Read `agents/MEMORY.md` with `AGENTS.md` before non-trivial work; record a durable rule the moment the user corrects you, rejects a pattern, repeats an instruction, states a preference, or a repository-wide decision is verified. Treat a repeated correction as a memory failure and fix it that session. Compress past roughly 50 lines. Do not wait to be asked. Skip task notes, guesses, secrets, local details.
---

## Memory

`agents/MEMORY.md` is the project's learned extension of `AGENTS.md`: the repository-specific rules, rejected patterns, and preferences taught here that defaults and training do not supply. Read it alongside `AGENTS.md`, and the `CLAUDE.md` or `GEMINI.md` pointer where a project uses one, before non-trivial work and treat it as binding. It stays subordinate to `AGENTS.md` and to narrower scoped instructions.

### Reinforcement loop

Learn inside the session, not after it:

1. Notice the signal: a correction to work you produced, a rejected pattern or approach, a repeated instruction, a stated preference, or a repository-wide decision you verified.
2. Write the rule before resuming the task the signal interrupted.
3. Apply it for the rest of the session and load it before similar work later.

A repeated correction is a memory failure, not a one-off. When the user repeats an instruction, or shows frustration at behavior they already corrected, record it that session in wording strict enough that the behavior cannot recur, and say that you did.

Record the rule, not the incident. Write one imperative line naming the trigger and the required or forbidden behavior, for example: "Do not add explanatory comments; let names and structure carry intent." Drop the apology, the narration, and any rationale that does not change when the rule applies.

Update stale or conflicting entries. Never store task details, temporary context, guesses, implementation-specific knowledge, or secrets.

### Division with Knowledge and Plans

Memory holds repository-wide behavioral rules. `agents/knowledge/` holds domain facts, invariants, and architecture decisions. `agents/plans/` holds execution state. Route each capture to exactly one of the three and reference it from the others; when a memory rule depends on a domain fact, store the fact in Knowledge and keep a pointer.

### Compression

When `agents/MEMORY.md` passes roughly 50 lines or repeats itself, compress it that session. Compression rewrites wording, never relaxes a rule.

1. Merge entries governing the same decision into one, keeping the strictest wording and the narrowest scope.
2. Delete entries now enforced by `AGENTS.md`, a skill, a schema, a linter, or a test, and entries a later decision superseded.
3. Move domain facts, invariants, and architecture decisions to `agents/knowledge/`; keep a pointer only when a memory rule still depends on them.
4. Cut restated code, examples, and rationale that no longer changes behavior. Keep each surviving entry to one line.

Report merges and deletions with a one-line reason; when relevance is unclear, keep and ask.

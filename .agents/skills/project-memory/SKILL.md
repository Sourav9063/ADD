---
name: project-memory
description: Read `agents/MEMORY.md` with `AGENTS.md` before non-trivial work. Record a rule the moment the user corrects you, rejects a pattern, repeats an instruction, states a preference, or a repository-wide decision is verified, provided it generalizes past the current task. A repeated correction is a memory failure. Compress past ~50 lines. Do not wait to be asked. No task notes, guesses, secrets, local details.
---

## Memory

`agents/MEMORY.md` holds the repository-wide rules taught here that defaults do not supply. Read it with `AGENTS.md`, or the `CLAUDE.md` or `GEMINI.md` pointer where a project uses one, before non-trivial work; treat it as binding but subordinate to `AGENTS.md` and to narrower scoped instructions. When a new instruction conflicts with a recorded rule, raise it immediately and settle it before acting; never pick a side silently.

### Loop

Learn inside the session, not after it:

1. Notice the signal: a correction, rejected pattern, repeated instruction, stated preference, or verified repository-wide decision. Confirm it generalizes past the current task.
2. Fix the work the correction names; the entry prevents the next occurrence, not this one.
3. Write the rule before resuming the task the signal interrupted.
4. Apply it for the rest of the session.

A repeated correction is a memory failure, not a one-off: record it that session in wording strict enough that the behavior cannot recur, and say that you did.

Record the rule, not the incident: one imperative line naming the trigger and the required or forbidden behavior, for example "Do not add explanatory comments; let names and structure carry intent." Drop apology, narration, and rationale that does not change when the rule applies. Update stale or conflicting entries: a user overriding a rule is a signal too, so narrow the entry to its real scope or delete it, and say which. Never store task details, guesses, implementation specifics, or secrets; domain facts go to `agents/knowledge/`, execution state to `agents/plans/`.

### Compression

Past ~50 lines or on repetition, compress that session, rewriting wording, never relaxing a rule. Merge entries governing one decision into the strictest, narrowest wording; delete what `AGENTS.md`, a skill, schema, linter, test, or a later decision now covers; move domain facts to `agents/knowledge/`; cut examples and rationale; keep each entry to one line. Report merges and deletions with a one-line reason; when relevance is unclear, keep and ask.

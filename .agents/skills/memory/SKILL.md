---
name: memory
description: Read `agents/MEMORY.md` before non-trivial work; curate it after a user correction, rejected pattern, stated preference, or verified repository-wide decision. Compress it when it grows past roughly 50 lines or repeats itself. Do not wait to be asked. Holds durable repository-wide guidance. Skip task notes, guesses, secrets, local details.
---

## Memory

Treat `agents/MEMORY.md` as learned, curated, repository-wide guidance subordinate to `AGENTS.md` and scoped instructions.

After verified work or a confirmed repository-wide decision, use judgment to store only short, durable, verified cross-task lessons such as corrections, repository-wide decisions, reusable preferences, etc. Do not wait for the user to ask.

Update stale or conflicting entries. Never store task details, temporary context, guesses, implementation-specific knowledge, or secrets. Store domain facts in Knowledge.

### Compression

When `agents/MEMORY.md` passes roughly 50 lines or repeats itself, compress it that session. Compression rewrites wording, never relaxes a rule.

1. Merge entries governing the same decision into one, keeping the strictest wording and the narrowest scope.
2. Delete entries now enforced by `AGENTS.md`, a skill, a schema, a linter, or a test, and entries a later decision superseded.
3. Move domain facts, invariants, and architecture decisions to `agents/knowledge/`; keep a pointer only when a memory rule still depends on them.
4. Cut restated code, examples, and rationale that no longer changes behavior. Keep each surviving entry to one line.

Report merges and deletions with a one-line reason; when relevance is unclear, keep and ask.

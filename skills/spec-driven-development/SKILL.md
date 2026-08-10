---
name: spec-driven-development
description: Apply SDD after codebase search for non-trivial work spanning several files or layers, changing behavior or contracts, requiring design decisions, or needing durable plans or knowledge. Skip simple renames, copy edits, and isolated mechanical changes.
---

## Spec-Driven Development

Use SDD when a change affects behavior or contracts, requires design decisions, crosses meaningful boundaries, or exceeds a local edit.

Read `agents/MEMORY.md` and only relevant files under `agents/knowledge/` and `agents/plans/`; create or update them when needed.

Executable artifacts define behavior: code, tests, schemas, configuration, and other runnable files. Docs record decisions, constraints, and context they cannot. When sources conflict, follow explicit task requirements and executable contracts; report unresolved conflicts before changing behavior; align affected docs.

Keep one authoritative source of truth per durable fact; reference it elsewhere.

### Knowledge

`agents/knowledge/` stores concise, topic-scoped, code-verified:

- Architecture decisions and rejected alternatives
- Domain terms and glossaries
- Invariants
- Navigation guidance

Create or update the most relevant file when requested or whenever verified work establishes uncaptured reusable knowledge. Prefer updating existing files. Keep it concise.

### Plans

`agents/plans/` stores working and finalized plans. Create one when multi-step work benefits from durable execution state.

Before writing:

1. Resolve minor details with judgment and code investigation.
2. Present options for unresolved decisions affecting scope, behavior, compatibility, or architecture.
3. After the user resolves them, create a precisely named `.md` file and keep it current.

Implement and verify against code, tests, schemas, and configuration.

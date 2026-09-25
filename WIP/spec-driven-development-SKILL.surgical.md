---
name: spec-driven-development
description: Use when work spans several files or layers, changes behavior or shared contracts, or the user asks for a plan. Re-check mid-task when scope grows past the first estimate. Also use before reading or writing `agents/knowledge/` or `agents/plans/`, which it owns. Skip renames, copy edits, isolated mechanical changes.
---

## Spec-Driven Development

Use SDD when a change affects behavior or contracts, requires design decisions, crosses meaningful boundaries, or exceeds a local edit.

A specification defines intended observable behavior and constraints. A plan records technical execution state. Use lightweight acceptance criteria by default, recorded in the plan's goal, or stated before implementation when no plan is warranted; add stronger artifacts for public contracts, migrations, security boundaries, or cross-repository work.

Read `agents/MEMORY.md` and only relevant files under `agents/knowledge/` and `agents/plans/`. Write them for repeated reading: each fact once, no filler or restated code. `project-memory` owns `MEMORY.md`; a rule there binds the spec, the plan, and the implementation.

Code is the source of truth for current behavior: code, tests, schemas, configuration, and other runnable files. Knowledge and plans are helpers: they record decisions, constraints, and context code cannot, never what code already says.

- Verify a doc's claims about current code before acting on them.
- Code wins over docs about current behavior: when such a claim contradicts code, fix the doc in the same change.
- When code looks wrong, report it and get approval before changing behavior.
- Explicit task requirements change code first; docs follow.
- Acceptance criteria change only with the user's approval; a gap between them and code is remaining work, not a stale doc.

Keep one authoritative source of truth per durable fact; reference it elsewhere.

### Knowledge

`agents/knowledge/` stores concise, topic-scoped, code-verified:

- Architecture decisions and rejected alternatives, and why
- Domain terms and the team's glossary
- Invariants
- Ownership, affected-surface, and navigation guidance
- Coding conventions and recurring patterns

Prefer facts costly to rediscover. Never restate code: signatures, field lists, config values, line-level flow; name the owning file instead.

Create or update the most relevant file when requested or whenever verified work establishes uncaptured reusable knowledge. Prefer updating existing files. Delete entries code no longer supports.

### Plans

`agents/plans/` stores technical execution state, including open decisions, risks, and verification checks. A plan steers work; it never defines current behavior. Decompose multi-step work into ordered, independently verifiable tasks with a checkpoint after each; when committing is authorized, commit at task boundaries so a failed or reverted step costs one task, not the whole plan. Create or update a precisely named `.md` file after repository search when the user asks to create, write, save, or produce a plan, or when multi-step work benefits from durable execution state.

Before writing:

1. Resolve minor details with judgment and code investigation.
2. Present options for unresolved decisions affecting scope, behavior, compatibility, or architecture.
3. Record unresolved material choices as open decisions when the user requested a draft. They block implementation, not plan creation.

For public-contract, migration, security-boundary, or cross-repository plans, get an independent review (a fresh session, subagent, or reviewer) before implementation starts; fresh context catches wrong turns baked into the original reasoning.

During implementation, keep the plan current as verified facts emerge; mark a task done only after its check passes. When resuming work, re-read the plan first and re-verify any claim it does not back with a recorded check. When code has diverged from the plan's execution state, trust the code and revise the plan; acceptance criteria stay unless the user changes them. When the plan completes, move durable decisions into `agents/knowledge/` and delete the plan.

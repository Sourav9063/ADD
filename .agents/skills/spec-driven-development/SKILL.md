---
name: spec-driven-development
description: Use when work spans several files or layers, changes behavior or shared contracts, or the user asks for a plan. Re-check mid-task when scope grows past the first estimate. Owns `agents/knowledge/` and `agents/plans/`. Skip renames, copy edits, isolated mechanical changes.
---

## Spec-Driven Development

Use SDD when a change affects behavior or contracts, requires design decisions, crosses meaningful boundaries, or exceeds a local edit.

A specification defines observable behavior and constraints. A plan records technical execution state. Use lightweight acceptance criteria by default; add stronger artifacts for public contracts, migrations, security boundaries, or cross-repository work.

Read `agents/MEMORY.md` and only relevant files under `agents/knowledge/` and `agents/plans/`; create or update them when needed. Write them for repeated reading: each fact once, no filler or restated code.

Executable artifacts define behavior: code, tests, schemas, configuration, and other runnable files. Docs record decisions, constraints, and context they cannot. When sources conflict, follow explicit task requirements and executable contracts; report unresolved conflicts before changing behavior; align affected docs.

Keep one authoritative source of truth per durable fact; reference it elsewhere.

### Knowledge

`agents/knowledge/` stores concise, topic-scoped, code-verified:

- Architecture decisions and rejected alternatives
- Domain terms and the team's glossary
- Invariants
- Ownership, affected-surface, and navigation guidance
- Repository structure, coding conventions, and recurring patterns

Prefer facts costly to rediscover. Skip what a quick read gives: signatures, field lists, config values, line-level flow.

Create or update the most relevant file when requested or whenever verified work establishes uncaptured reusable knowledge. Prefer updating existing files.

### Plans

`agents/plans/` stores working and finalized technical execution state, including open decisions, risks, and verification checks. Decompose multi-step work into ordered, independently verifiable tasks with a checkpoint after each; commit at task boundaries so a failed or reverted step costs one task, not the whole plan. Create or update a precisely named `.md` file after repository search when the user asks to create, write, save, or produce a plan, or when multi-step work benefits from durable execution state.

Before writing:

1. Resolve minor details with judgment and code investigation.
2. Present options for unresolved decisions affecting scope, behavior, compatibility, or architecture.
3. Record unresolved material choices as open decisions when the user requested a draft. They block implementation, not plan creation.

For public-contract, migration, security-boundary, or cross-repository plans, get an independent review (a fresh session, subagent, or reviewer) before implementation starts; fresh context catches wrong turns baked into the original reasoning.

A plan is the durable execution state that survives context loss. During implementation, keep it current as verified facts emerge. When resuming work, re-read the plan first and re-verify any claim it does not back with a recorded check.

Implement and verify against code, tests, schemas, and configuration.

---
name: spec-driven-development
description: Use when work spans several files or layers, changes behavior or shared contracts, needs material design decisions, or the user asks for a plan. Also use before reading or writing `agents/knowledge/` or `agents/plans/`, which it owns. Re-check mid-task when scope grows past the first estimate. Skip renames, copy edits, isolated mechanical changes.
---

## Spec-Driven Development

Use SDD when a change affects behavior or contracts, needs design decisions, crosses boundaries, or exceeds a local edit. A spec defines intended observable behavior and constraints; a plan records execution state. Default to lightweight acceptance criteria; add stronger artifacts for public contracts, migrations, security boundaries, or cross-repository work.

### Source of Truth

Code is the source of truth for current behavior: source, tests, schemas, configuration, and other executable files. Task requirements and specs define intended behavior. Knowledge and plans are helpers: they record why the code is shaped this way and what happens next, never what the code already says.

- Verify before trusting. Treat every knowledge or plan claim about current code as a lead; confirm it in code before acting on it.
- Code wins over docs about current behavior. When such a claim contradicts code, fix the doc in the same change.
- When the code looks wrong, report it and get approval before changing behavior the task does not cover.
- Task requirements change code first; docs follow the code.
- Acceptance criteria change only with the user's approval; a gap between them and code is remaining work, not a stale doc.
- Never restate code: no signatures, field lists, config values, or line-level flow. Name the owning file instead.
- Keep each durable fact in one place, written for repeated reading; reference it elsewhere.

Read `agents/MEMORY.md` and only the relevant knowledge and plan files. `project-memory` owns `MEMORY.md`; its rules bind spec, plan, and implementation.

### Knowledge

`agents/knowledge/` records, in concise topic-scoped files, the reasoning code cannot express:

- Architecture decisions, rejected alternatives, and why
- Domain terms and glossary
- Invariants and constraints
- Ownership, affected-surface maps, and navigation
- Conventions and recurring patterns

Record only what is costly to rediscover. Update the owning file when verified work establishes reusable knowledge or proves an entry stale; delete entries code no longer supports. Extend existing files before adding new ones.

### Plans

`agents/plans/` holds execution state: goal, decisions, open questions, risks, ordered tasks, and verification checks. A plan steers work; it never defines current behavior. Record acceptance criteria in the plan's goal, or state them before implementation when no plan is warranted.

Create or update a precisely named `.md` file, after a repository search, when the user asks to create, write, save, or produce a plan, or when multi-step work needs state that survives context loss. Split work into ordered, independently verifiable tasks with a checkpoint each; when committing is authorized, commit at task boundaries so a failed step costs one task, not the plan.

Before writing:

1. Resolve minor details through code investigation and judgment.
2. Present options for unresolved decisions affecting scope, behavior, compatibility, architecture, security, or migration; never silently pick between materially different alternatives.
3. When the user requested a draft, record unresolved material choices as open decisions. They block implementation, not plan creation.

For public-contract, migration, security-boundary, or cross-repository plans, get an independent review (fresh session, subagent, or reviewer) before implementation; fresh context catches wrong turns baked into the original reasoning. The review challenges assumptions, scope, compatibility, risks, and verification coverage; resolve material findings or record them as open decisions. If review is unavailable, say so.

### Implementation

- Update the plan as verified facts emerge; mark a task done only after its checkpoint passes.
- When implementation reveals a material decision the plan does not cover, or an acceptance criterion proves ambiguous or impossible, pause, record it in the plan, and resolve it with the user before continuing.
- When code has diverged from the plan's execution state, trust the code and revise the plan; acceptance criteria stay unless the user changes them.
- When resuming, re-read the plan, re-verify in code every claim about current code without a recorded check, then continue from the first incomplete task.
- Before declaring completion, verify each acceptance criterion against the resulting code, run the relevant checks, and reconcile knowledge and plan status; report checks that could not run and any remaining gaps.
- When the plan completes, move its durable decisions into `agents/knowledge/` and delete the plan unless the user asks to keep it or an active workflow depends on it; git keeps the history.

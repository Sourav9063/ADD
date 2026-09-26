---
name: spec-driven-development
description: Use when work spans several files or layers, changes behavior or shared contracts, needs material design decisions, or the user asks for a plan. Also use before reading or writing `agents/knowledge/` or `agents/plans/`, which it owns. Re-check mid-task when scope grows. Skip renames, copy edits, isolated mechanical changes.
---

## Spec-Driven Development

Use SDD when a change affects behavior or contracts, needs design decisions, crosses boundaries, or exceeds a local edit. A spec defines intended observable behavior; a plan records execution state. Default to lightweight acceptance criteria; add stronger artifacts for public contracts, migrations, security boundaries, or cross-repository work.

### Source of Truth

Code (source, tests, schemas, config) defines current behavior; task requirements and specs define intended behavior. Knowledge and plans record why and what next, never what code already says.

- Treat every doc claim about current code as a lead; confirm it in code before acting.
- When a doc contradicts code, fix the doc in the same change.
- When code looks wrong, report it; get approval before changing behavior outside the task.
- Requirements change code first; docs follow.
- Acceptance criteria change only with user approval; a gap between them and code is remaining work, not a stale doc.
- Never restate code (signatures, field lists, config values, line-level flow); name the owning file.
- Keep each durable fact in one place; reference it elsewhere.

Read `agents/MEMORY.md` and only relevant knowledge and plan files. `project-memory` owns `MEMORY.md`; its rules bind spec, plan, and implementation.

### Knowledge

`agents/knowledge/` holds concise topic files for what code cannot express: architecture decisions and rejected alternatives, domain terms, invariants, ownership and navigation maps, conventions. Record only what is costly to rediscover. Update the owning file when verified work adds reusable knowledge; delete entries code no longer supports. Extend existing files before adding new ones.

### Plans

`agents/plans/` holds execution state: goal with acceptance criteria, decisions, open questions, risks, ordered tasks, checks. A plan steers work; it never defines current behavior. Without a plan, state acceptance criteria before implementing.

After searching the repo, create or update a precisely named `.md` plan when the user asks for one or multi-step work needs state that survives context loss. Split work into ordered, independently verifiable tasks, each with a checkpoint; when committing is authorized, commit at task boundaries so a failure costs one task.

Before writing:

1. Resolve minor details via code and judgment.
2. Present options for decisions affecting scope, behavior, compatibility, architecture, security, or migration; never silently pick between materially different alternatives.
3. For a requested draft, record unresolved choices as open decisions; they block implementation, not the plan.

For public-contract, migration, security-boundary, or cross-repository plans, get an independent review (fresh session, subagent, or reviewer) before implementing; fresh context catches wrong turns baked into the original reasoning. It challenges assumptions, scope, risks, and verification coverage; resolve material findings or record them as open decisions. If review is unavailable, say so.

### Implementation

- Update the plan as verified facts emerge; mark a task done only after its checkpoint passes.
- When a material decision the plan doesn't cover arises, or an acceptance criterion proves ambiguous or impossible, pause, record it, and resolve it with the user.
- When code diverges from the plan, trust the code and revise the plan; acceptance criteria stay unless the user changes them.
- On resume: re-read the plan, re-verify unchecked claims about current code, continue from the first incomplete task.
- Before declaring done: verify each acceptance criterion against the resulting code, run relevant checks, reconcile knowledge and plan status, and report unrun checks and gaps.
- On completion, move durable decisions into `agents/knowledge/` and delete the plan unless the user wants it kept or an active workflow depends on it; git keeps history.

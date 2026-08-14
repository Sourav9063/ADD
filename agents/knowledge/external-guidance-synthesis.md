# External Guidance Synthesis

What ADD takes from outside sources, what it declined, and why. Borrow principles, not text, tooling, or skill catalogs.

Reviewed: 2026-08-14.

## Adopted

- **Trigger-oriented descriptions.** One capability statement plus explicit activation conditions, in third person, with the "skip" cases named. Descriptions decide selection; bodies only decide execution.
- **Terminology as an invocation aid.** Reuse canonical engineering terms — `seam`, `code smell`, `spec`, `root cause` — as compact behavior handles. Repeat the term, not its definition. Avoid invented vocabulary.
- **Imperative, positive, outcome-linked wording.** State target behavior and completion criteria; reserve prohibitions for costly failure modes.
- **Repository grounding before writing artifacts.** Inspect and cite the files, symbols, and contracts a change touches. Addresses measured "context blindness" in large repos.
- **Testable acceptance criteria.** `Given / when / then` gives criteria a shape that maps to checks without adopting a requirements framework.
- **Good/bad example pairs, sparingly.** Used where abstract wording demonstrably underspecifies output — currently only `communication`.
- **Durable trigger evaluations.** See `trigger-evaluations.md`. Evaluations before more prose.

## Deferred

- Change deltas in `ADDED / MODIFIED / REMOVED` form against a living baseline (OpenSpec). Attractive for brownfield auditing; revisit if plan drift becomes a real cost.
- Mandatory TDD as an explicitly invoked skill. Needs a confirmed preference first.
- Progressive disclosure through bundled reference files. ADD skills are all well under the 500-line guidance, so splitting would add navigation cost for no token saving.

## Rejected

- Phase-gate process machinery (Spec Kit's specify/plan/tasks/implement, constitution files). Contradicts the lightweight, judgment-driven model; reported gains are vendor-adjacent, and the peer-reviewed effect measured on grounding was +0.15 on a 1–5 scale.
- Router, grilling, handoff, orchestration, and subagent skills. No repeated workflow need observed.
- Copying external skill catalogs. The catalog stays the user's own work.
- New dependencies or validation frameworks.

## Sources

- <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
- <https://github.com/mattpocock/skills>
- <https://github.com/obra/superpowers>
- <https://github.com/github/spec-kit>
- <https://github.com/Fission-AI/OpenSpec>
- <https://agents.md/>
- <https://arxiv.org/pdf/2604.05278> — grounding hooks for spec-driven agent workflows

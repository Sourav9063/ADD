# Coding Skill Revision: Decision Record

Status: complete. Seven rule changes applied to `skills/agent-driven-development/coding/SKILL.md` and the byte-aligned `## Coding` body in `AGENTS_STANDALONE.md`.

## Ownership

- `engineering` owns what to build, how far a change reaches, architecture, trust mapping, failure policy, verification, scope, and completion.
- `coding` owns line-level craft for writing, editing, refactoring, and reviewing: control flow, naming, state, errors, concurrency, structure, smells, restraint, tests, and code-level security. It stays authoritative for review criteria so implementation and review judge code by one standard.
- `reviewing-changes` owns review targeting, diff workflow, evidence, severity, and output, and points to `engineering` and `coding` rather than restating their criteria. That refactor is separate work and needs its own plan.

## Applied Changes

| Section | Before | After | Reason |
| --- | --- | --- | --- |
| Errors | crash loudly in development and degrade gracefully in production | surface failure at the boundary that owns it, and degrade only where that contract allows it | Some production failures must stop processing; some development paths intentionally exercise fallbacks. |
| Concurrency | never hold a lock across I/O, an `await`, or a callback | avoid holding one unless a documented invariant demands it | Caches, schedulers, and framework-managed concurrency make the absolute unfollowable. The documented invariant keeps a cost on the exception. |
| Structure | depend on abstractions rather than implementations | depend on an abstraction where it clarifies a real boundary or variation point rather than by default | The old wording contradicted Speculative Generality and YAGNI in the same file and encouraged needless interfaces. |
| Restraint | ... and wait for the third repetition before abstracting | clause removed | Duplicated the Smells entry. The threshold survives once under Duplicated Code, where the section already frames smells as heuristics. |
| Testing | one logical assertion per test | one coherent behavior per test | Routinely misread as one assertion per test; proving one behavior can need several. |
| Testing | a bug fix starts with a failing test | reproduce a bug with a failing test before fixing it where practical, and say so when it is not | Mandatory TDD conflicted with earlier repository guidance. Disclosure keeps a cost on skipping. |
| Testing | no sleeps, no shared state, no network | no sleeps, no uncontrolled shared state, no uncontrolled network or external service | The absolutes rejected valid integration and end-to-end tests without protecting determinism further. |

Both loosened rules carry an obligation rather than a free pass: the lock exception requires a documented invariant, and a skipped regression test requires the agent to say so.

## Rejected

- Rewriting "Parse, do not validate". The existing line already converts untrusted input to a safe type at the boundary; the proposed rewrite was vaguer, not more correct.
- Scoping security distrust to real trust boundaries. The line already reads "every caller outside your boundary".
- Softening the parameter-count and boolean-flag guidance. The line already hedges with "usually".
- Broad hedging of the remaining sections. Converting crisp imperatives into conditionals weakens directive force for agent-facing guidance; an agent scanning for permission finds it.
- Trimming the named smell catalog, reordering sections, and setting a size budget. No evidence justified the churn.
- A six-phase process with a semantic ledger and paired fresh-agent evaluations. Disproportionate to an 84-line file already compressed at `b181fbe`.

## Verification

- Canonical skill body and the `AGENTS_STANDALONE.md` `## Coding` body are byte-aligned.
- `git diff --check` passes.
- Stale-phrase sweep is clean apart from the single intentional "third repetition" under Smells.
- Note for future checks: `rg` fails under the rtk proxy in this repository and a `|| echo` fallback will report a false all-clear. Use `grep -rn` and read the exit code.
- Skill stays 84 lines. No fresh-agent behavioral evaluation was run.

## Outstanding

- `.agents/skills/` and `.claude/skills/` still carry the old text and await the user's sync command.
- The `README.md` guidance block regenerates from `AGENTS_STANDALONE.md` on `main` via `.github/workflows/embed-agents.yml`.
- `agents/openai.yaml` needs no change; no trigger or capability statement moved.

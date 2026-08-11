# Agent-Driven Development Guidance Improvements

Status: proposed

## Objective

Keep the distributed guidance complete, vendor-neutral, surgical, and useful without mandatory external tooling. Strengthen task-specific workflows while preserving `AGENTS_STANDALONE.md` as the self-contained bundle of all ADD-wide skills.

## Current State

- `AGENTS_STANDALONE.md` is 106 lines and 905 words.
- The four ADD-wide skill files total 1,052 words. The standalone guide intentionally repeats their behavioral content so it works without separately installed skills.
- `WIP/AGENTS.md` is a useful 561-word draft, but it still embeds task-specific skill procedures.
- `skills/agent-driven-development/` and `.agents/skills/` currently differ: the installed communication skill lacks the read-only question rule, and the installed SDD description lacks explicit planning triggers.
- The README installer downloads this repository's contributor `AGENTS.md` instead of `AGENTS_STANDALONE.md`.
- `agents/knowledge/matt-pocock-skills.md` is a catalog snapshot rather than a durable synthesis.

## Decisions

- Follow the bundle contract recorded in `agents/MEMORY.md`: `AGENTS_STANDALONE.md` contains the complete behavioral content of every skill under `skills/agent-driven-development/`.
- Put specialized procedures in skills loaded for matching tasks.
- Keep specifications, implementation plans, knowledge, and memory distinct.
- Borrow principles from external projects, not their text, tooling, mandatory workflows, or skill catalogs.
- Preserve the lightweight SDD model; do not adopt OpenSpec or Spec Kit machinery.
- Add skills only for demonstrated high-value seams: diagnosis and agent-guidance authoring first.

## Phase 1: Align the Standalone Bundle

Keep `skills/agent-driven-development/` authoritative. Whenever an ADD-wide skill changes, apply its complete behavioral content to `AGENTS_STANDALONE.md` and synchronize the installed `.agents/skills/` mirror through the repository's supported workflow.

Requirements:

- Include every ADD-wide skill body; do not replace required behavior with a pointer to separately installed skills.
- Preserve the read-only question rule and every other confirmed ADD-wide behavior.
- Keep skill procedures grouped under clear corresponding sections.
- Include no skills from outside `skills/agent-driven-development/` unless explicitly requested.
- Remove or simplify guidance only in its canonical skill first, then make the same change in the standalone bundle.
- Use no arbitrary word-count target; completeness and alignment define the standalone file.

## Phase 2: Clarify Existing Skill Ownership

### Engineering

Edit `skills/agent-driven-development/engineering/SKILL.md`:

- Keep non-trivial implementation, refactor, schema, configuration, and technical-design discipline.
- Remove detailed SDD, debugging, review, memory, and communication behavior owned elsewhere.
- Replace generic principle names with concrete actions at the changed seam.
- Challenge choices only when a concrete correctness, security, compatibility, or maintainability cost exists.

### Spec-Driven Development

Edit `skills/agent-driven-development/spec-driven-development/SKILL.md`:

- Define a specification as an observable behavior contract.
- Define a plan as technical execution state.
- Use progressive rigor: lightweight acceptance criteria by default; stronger artifacts for contracts, migrations, security, or cross-repository work.
- Permit plans to evolve when implementation reveals verified facts.
- State explicitly: when the user asks to create, write, save, or produce a plan, create or update a precisely named file under `agents/plans/` after repository search. Unresolved material decisions may be recorded as open decisions when the user requested a draft; they block implementation, not plan creation.

### Memory

Edit `skills/agent-driven-development/memory/SKILL.md`:

- Keep only short, verified, repository-wide lessons.
- Exclude task state, proposals, domain facts, guesses, and secrets.
- Remove wording duplicated by SDD.

### Communication

Edit `skills/agent-driven-development/communication/SKILL.md`:

- Preserve negation, numbers, units, code symbols, commands, and exact error text.
- Compress chat output, not persisted documentation, commits, issues, pull requests, or reviews.
- Retain full prose for safety, irreversible actions, ordering, and ambiguity.

## Phase 3: Add Focused Skills

### Diagnosing Bugs

Add `skills/agent-driven-development/diagnosing-bugs/` with `SKILL.md` and `agents/openai.yaml`.

After adding it, incorporate its complete behavioral content into `AGENTS_STANDALONE.md`.

Workflow:

1. Reproduce the user's exact symptom with a tight pass/fail signal.
2. Minimize the reproduction and inspect recent relevant changes.
3. Form falsifiable hypotheses; test one variable at a time.
4. Distinguish diagnosis-only requests from authorization to fix.
5. Fix the root cause when authorized.
6. Add focused regression coverage at the correct observable seam when practical.
7. Re-run the original reproduction and remove temporary instrumentation.

### Writing Agent Guidance

Add `skills/agent-driven-development/writing-agent-guidance/` with `SKILL.md` and `agents/openai.yaml`.

After adding it, incorporate its complete behavioral content into `AGENTS_STANDALONE.md`.

Workflow:

1. Classify each fact as always-loaded guidance, skill procedure, knowledge, plan, or executable/tool-enforced behavior.
2. Give every pointer an explicit purpose and trigger.
3. Use positive, imperative, outcome-linked wording.
4. Remove no-ops, duplication, lint leakage, skill leakage, blind references, stale initialization text, and conflicts.
5. Keep one authoritative source for each durable rule.
6. Verify installed mirrors, generated consumers, and trigger descriptions.

## Phase 4: Promote Review Support

Move and generalize `skills/review-merge-request/` into `skills/agent-driven-development/` rather than creating a duplicate.

After promoting it, incorporate its complete behavioral content into `AGENTS_STANDALONE.md`.

- Support working-tree, commit-range, and branch review.
- Choose direct two-ref or merge-base comparison deliberately from the requested review target.
- Review repository standards and originating specification as separate axes.
- Require evidence, impact, severity, and fix direction for every finding.
- Avoid generic checklist output when no concrete finding exists.

## Phase 5: Curate Durable Knowledge

- Replace `agents/knowledge/matt-pocock-skills.md` with a concise cross-source synthesis containing adopted, deferred, and rejected ideas plus source URLs and review date.
- Update `agents/knowledge/agent-guidance-rationale.md` with the confirmed ownership rule: universal constraints in the standalone core; task-specific procedures in skills; verified domain facts in knowledge; task state in plans.
- Leave `agents/knowledge/coding-mindsets-and-principles.md` on demand unless an exact contradiction or stale rule is found.
- Update `agents/MEMORY.md` only after these repository-wide decisions are accepted and implemented.

## Phase 6: Correct Distribution

- Change README copy instructions and installer URL from `AGENTS.md` to `AGENTS_STANDALONE.md`.
- Do not manually edit the workflow-generated README guidance block.
- Align `AGENTS_STANDALONE.md` with every skill under `skills/agent-driven-development/`.
- Mirror all ADD-wide skill changes into `.agents/skills/`.
- Keep tool-specific metadata aligned with each skill's trigger and invocation policy.

## Deferred

- Mandatory TDD. Consider an explicitly invoked skill only after a confirmed preference.
- Router, grilling, handoff, orchestration, and subagent skills without repeated workflow need.
- Full OpenSpec, Spec Kit, or Superpowers process machinery.
- New dependencies or validation frameworks.
- Broad architecture and research skills already covered by engineering and platform capabilities.

## Verification

Run after each coherent phase:

1. `git diff --check`
2. `diff -ru skills/agent-driven-development .agents/skills`
3. `rg 'AGENTS_STANDALONE|agent-driven-development|agents/plans' README.md AGENTS.md agents skills`
4. `wc -w -l AGENTS_STANDALONE.md skills/agent-driven-development/*/SKILL.md`
5. `git status --short`

Manually test trigger behavior with prompts for:

- A trivial mechanical edit: SDD and engineering should not trigger.
- A multi-file behavioral change: SDD and engineering should trigger.
- An explicit planning request: SDD should create or update `agents/plans/<name>.md`.
- A diagnosis-only request: diagnosing-bugs should investigate without implementing.
- A bug-fix request: diagnosing-bugs and engineering should reproduce, fix, and verify.
- A review request: review skill should compare the intended range and report concrete findings.
- An AGENTS or SKILL edit: writing-agent-guidance should trigger.

## Completion Criteria

- `AGENTS_STANDALONE.md` contains the complete behavioral content of every skill under `skills/agent-driven-development/` and no unrelated skill catalog content.
- Skill descriptions use precise, non-overlapping trigger branches.
- Explicit plan requests reliably create or update `agents/plans/` artifacts.
- Standalone, skills, knowledge, plans, and memory have distinct ownership.
- README installs the intended standalone guide and ADD-wide skills.
- Canonical and installed skill trees match.
- All repository verification commands pass.

## Sources

- <https://github.com/mattpocock/skills>
- <https://github.com/JuliusBrussee/caveman>
- <https://github.com/Fission-AI/OpenSpec>
- <https://github.com/multica-ai/andrej-karpathy-skills>
- <https://github.com/obra/superpowers>
- <https://github.com/github/spec-kit>
- <https://agents.md/>
- <https://arxiv.org/abs/2602.11988>
- <https://arxiv.org/abs/2606.15828>

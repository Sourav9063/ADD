# ASTRA Improvement Plan

Status: complete, 2026-11-08. Implementation authorized and applied; conditional additions were evaluated and deferred as recorded below.

## Execution

Acceptance: scoped repository learning, diagnosis of repeated corrections, proof of enforcement, proportionate behavioral verification, incremental tests, and fresh-context guidance evaluation are explicit in their existing owners. Core bodies remain byte-aligned with the standalone bundle. Installed skills and the generated README remain maintainer/workflow-owned. Conditional recommendations are adopted only when evaluation supports them.

- [x] Move this plan into `agents/plans/` and repair its relative links.
- [x] Snapshot baseline guidance and evaluate candidate changes in separate fresh contexts.
- [x] Apply the approved core refinements; record conditional decisions and evaluation limits.
- [x] Synchronize the standalone bundle, affected drafts, knowledge, and evaluation scenarios.
- [x] Verify distribution alignment, unchanged metadata, links, and whitespace; complete independent review.

Evaluation budget: one baseline and one candidate fresh-context run across the same ten decision scenarios; one final independent review. This is a small behavioral pilot, not a statistical performance benchmark or installed-harness trigger test.

## Original proposal

Reviewed: 2026-11-08. The following sections preserve the proposal and its source comparison; the execution record above governs current status.

## Recommendation

Keep the five core skills and strengthen their feedback loop. ADD already has substantial technical guidance. Its strongest opportunity is to make the working repository progressively better at guiding the next agent: capture a correction, put it in the right place, apply it, verify that it transfers to another task, and replace prose with executable enforcement where that is justified.

The desired outcome is an agent that needs fewer repeated corrections while making sound decisions about correctness, security, compatibility, scope, tests, and maintenance. More stored rules, larger skill catalogs, and more autonomous activity are not success measures by themselves.

This proposal extends the earlier comparison with pstack, Matt Pocock, and Superpowers. It also examines other visible developer collections, with particular attention to repository learning and evaluation.

## 1. Philosophy and ownership

The working repository is the persistent learning environment. Core skills supply general engineering judgment; the repository supplies local constraints, domain knowledge, corrections, and observable feedback. Here, reinforcement means improving the context and constraints available across sessions. It does not require training the model's weights.

The existing ownership model is appropriate:

| Artifact | What it contributes | What belongs elsewhere |
| --- | --- | --- |
| Project `AGENTS.md` and narrower instructions | Stable constraints and the distributed ADD baseline | Session logs and speculative lessons |
| `agents/MEMORY.md` | Short, generalizable rules learned from the user and verified work | Implementation facts, task progress, unverified guesses |
| `agents/knowledge/` | Costly-to-rediscover rationale, domain terms, invariants, and navigation | Copies of code and routine configuration |
| `agents/plans/` | Acceptance criteria, decisions, open questions, checkpoints, and next work | Claims that override actual code behavior |
| Types, schemas, tests, lint, and module boundaries | Executable feedback and prevention of invalid behavior | Judgment that cannot be mechanically expressed |
| Task-specific skills | Reusable procedures with precise triggers | Every lesson learned in one project |

These paths describe the target project's local learning environment. This ADD repository's own memory and knowledge are curation material, not content to copy wholesale into every target project. See [repository memory](../../agents/MEMORY.md) and [SDD](../../skills/agent-driven-development/spec-driven-development/SKILL.md).

The proposed loop is:

1. Observe a user correction or a verified result.
2. Identify the failure mechanism and the scope where the lesson holds.
3. Fix the current work within the task's authority.
4. Update the existing owner with the smallest durable rule or fact.
5. Apply the lesson on the next relevant decision.
6. Check transfer on another realistic case, including a case where the rule should not apply.
7. Narrow, revise, enforce, or retire the lesson as evidence changes.

Steps 1-4 and much of step 7 already exist. Steps 5-6 need the most explicit attention. The loop should remain part of ordinary work, with no mandatory retrospective ceremony.

## 2. Other collections popular with developers

The following are useful additional sources. GitHub stars were read from the public repository API on the review date and rounded below. They measure repository visibility, not unique users, installed skills, or demonstrated engineering quality. This is a selected comparison, not an exhaustive ranking. The [skills.sh leaderboard](https://skills.sh/) provides a separate installation signal.

| Collection | Approximate GitHub stars | Relevant material | Fit for ADD |
| --- | ---: | --- | --- |
| [Everything Claude Code / ECC](https://github.com/affaan-m/ECC) | 299,000 | Project-scoped learning, reusable observations, evaluation and verification skills | Strong comparison for local learning; its observer infrastructure is optional machinery |
| [Anthropic skills](https://github.com/anthropics/skills) | 189,000 | Skill creation, baseline comparisons, realistic evaluations, trigger tuning | Strong source for testing whether guidance helps |
| [gstack](https://github.com/garrytan/gstack) | 141,000 | Engineering review, QA, retrospectives, project learning management | Useful for connecting recorded learning to later work; extensive runtime and workflow conventions |
| [Addy Osmani agent-skills](https://github.com/addyosmani/agent-skills) | 114,000 | Engineering lifecycle, verification, interfaces, performance, quality constraints | Close thematic overlap; borrow concrete practices only where ADD has a gap |
| [GitHub Awesome Copilot](https://github.com/github/awesome-copilot) | 41,000 | Community skills, instructions, agents, hooks, and plugins | Discovery catalog for specialist tasks, rather than one unified engineering philosophy |
| [Vercel agent-skills](https://github.com/vercel-labs/agent-skills) | 34,000 | React and Next.js performance guidance organized by impact | Useful project-specific supplement; framework details stay outside ADD core |
| [Trail of Bits skills](https://github.com/trailofbits/skills) | 8,100 | Security analysis and differential review | Specialist reference for risky changes; smaller audience, relevant engineering depth |

Inspection depth: selected skill bodies were read for ECC, Anthropic, gstack, Vercel, and Trail of Bits. Addy Osmani and Awesome Copilot were inspected at catalog/README level; this proposal does not claim a complete audit of either collection. No external skills or hooks were installed or executed.

## 3. Reassessment of pstack, Matt Pocock, and Superpowers

| Source | Useful emphasis | Already covered by ADD | Remaining opportunity |
| --- | --- | --- | --- |
| [pstack](https://github.com/cursor/plugins/tree/main/pstack) | Direct proof, architectural prevention of recurring mistakes, domain models, falsifiable assumptions | Real-code safety checks, benchmark discipline, typed boundaries, mechanical reinforcement | Diagnose why a correction repeats; verify that proposed enforcement catches the original mistake; sharpen behavioral evidence |
| [Matt Pocock](https://github.com/mattpocock/skills) | Deep modules, shared domain language, testing through interfaces, incremental implementation | Module depth, seams, glossary ownership, independent test expectations, behavioral task slices | Explicitly keep test/implementation cycles small; use targeted experiments when a design choice needs observation |
| [Superpowers](https://github.com/obra/superpowers) | Structured debugging, completion evidence, review feedback handling, explicit execution procedures | Reproduction, hypotheses, relevant check runs, risk-based independent plan review | Validate incoming review claims before applying fixes; distinguish what each verification result actually establishes |

The earlier recommendations remain useful refinements, but should not be presented as missing foundations. In particular, ADD already requires failing-before evidence where practical, independent expected values, actual verification runs, and rechecking evidence invalidated by edits.

The [existing external synthesis](../../agents/knowledge/external-guidance-synthesis.md) already records several of these adoptions. Its prior decisions should prevent re-importing the same principle under a new skill name.

## 4. Highest priority: improve learning quality

### A. Diagnose repeated corrections before strengthening wording

Owner: [project-memory](../../skills/agent-driven-development/project-memory/SKILL.md), Loop.

Current behavior records a repeated correction as a memory failure and calls for stricter wording. That can help, but misses distinct causes: the rule was never loaded, its trigger was wrong, it was ambiguous, another instruction conflicted, the agent overgeneralized it, or the behavior needed enforcement.

Proposed refinement:

> When a correction repeats, inspect whether the relevant rule was loaded, understood, applicable, and consistent with other instructions. Fix the demonstrated cause before adding stronger wording or duplicate guidance.

This preserves immediate recording. It changes the diagnosis of recurrence, rather than adding a second memory system. pstack's [correct](https://github.com/cursor/plugins/blob/main/pstack/skills/correct/SKILL.md) supports moving recurring mistakes toward structural prevention; ADD should retain its own scope and permission boundaries.

Example: a rule against duplicating policy already exists, but the agent never opens the owning module. More emphatic wording may not help. A precise navigation pointer or clearer module ownership addresses that failure more directly.

### B. Keep inferred lessons local and evidence-backed

Owner: project-memory, recording rules; SDD continues to own domain facts.

Current memory rules already exclude guesses. Strengthen the boundary between an explicit user instruction and an inferred preference. Repetition of existing code is evidence of what exists, not proof that it is desirable.

Proposed refinement:

> Apply an inferred lesson only within its verified scope. Repeated existing patterns alone do not establish a preference, and a local lesson does not become a global rule without an explicit decision.

[ECC continuous-learning-v2](https://github.com/affaan-m/ECC/blob/main/skills/continuous-learning-v2/SKILL.md) separates project observations from global ones and supports promotion. Borrow the scope separation. ADD does not need confidence numbers, background observers, or automatic promotion. An explicit user preference can be recorded immediately; uncertainty about an inference belongs in ongoing investigation, not binding memory.

### C. Check that a lesson transfers to later work

Owner: [writing-agent-guidance](../../skills/misc/writing-agent-guidance/SKILL.md) for evaluation; project-memory can point to this only when a recurrence warrants it. This owner is outside the core group and is not bundled.

Current guidance already requires fresh-agent evaluation. The additional proposal is to give learning changes a concrete evaluation shape:

> Evaluate a learned rule on a realistic recurrence and a nearby case where it should not apply. Compare against the previous guidance and retain the change only when it improves the targeted behavior without unacceptable scope or verification regressions.

[Anthropic's skill-creator](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md) compares revised skills against prior versions and supports blind comparison. This is a useful method, not evidence that our proposed wording already improves performance.

Use existing evaluation files before creating new infrastructure. Keep the compact rule in memory; keep test scenarios and results outside memory. A fresh session must receive the relevant repository artifacts without the correction transcript, otherwise the experiment measures conversational recall rather than persistence.

### D. Prove proposed enforcement is effective

Owner: project-memory's existing mechanical reinforcement paragraph; implementation follows engineering and coding.

Proposed refinement:

> When adding enforcement for a recurring failure, demonstrate that it rejects a representative invalid case and accepts the intended valid case; then remove prose made redundant by that enforcement.

This extends the existing preference for types, tests, lint, and ownership. It does not authorize implementing enforcement during an unrelated task. A constraint that blocks all changes is not successful reinforcement.

## 5. Engineering refinements worth keeping

These are small edits to existing sections, not reasons to create new core skills.

| Priority | Owner | Proposed wording | What it improves |
| --- | --- | --- | --- |
| High | `engineering`, Execution | Verify changed behavior through the interface its users exercise, including relevant side effects. State what each check establishes and what remains unverified. | Makes verification appropriate to the claim; builds and mock-only tests cannot establish all runtime behavior |
| High | `coding`, Testing | Complete one behavior's red-green-refactor cycle before adding the next; let each result inform the next test. | Prevents a batch of speculative tests from locking in an imagined implementation |
| High | `coding`, Testing | Assess whether a plausible behavioral regression would fail the test and a behavior-preserving internal change would leave it passing. | Gives behavioral testing a concrete quality check without mandating mutation-testing tooling |
| Medium | `engineering`, Before Coding | Validate review findings against current code, requirements, and compatibility constraints before fixing them; explain rejected findings with evidence and keep accepted fixes within authorized scope. | Reduces blind agreement with incorrect or out-of-scope review feedback |
| Conditional | `spec-driven-development`, Plans | When a material design choice depends on unknown behavior, use a bounded throwaway experiment and record its question, observation, and resulting decision. | Extends existing dependency experiments to decisions that cannot be settled cheaply by reading |

Sources: pstack's [proof principle](https://github.com/cursor/plugins/blob/main/pstack/skills/principle-prove-it-works/SKILL.md) and [behavioral testing](https://github.com/cursor/plugins/blob/main/pstack/skills/principle-test-behavior-not-implementation/SKILL.md), Matt's [TDD](https://github.com/mattpocock/skills/blob/main/skills/engineering/tdd/SKILL.md), Superpowers' [review reception](https://github.com/obra/superpowers/blob/main/skills/receiving-code-review/SKILL.md), and pstack's [prototype procedure](https://github.com/cursor/plugins/blob/main/pstack/skills/poteto-mode/playbooks/prototype.md).

Apply these proportionally. A library caller is a user of an interface; every change does not need a browser session. A test quality check can be reasoning over a plausible defect. A prototype is justified by a named uncertainty, not by every planning task. Preserve ADD's red-green-refactor loop even though Matt's current TDD skill places refactoring in review.

One additional candidate belongs to [diagnosing-bugs](../../skills/agent-driven-review/diagnosing-bugs/SKILL.md), outside the requested core: when successive fixes fail the same check, test their shared premise before attempting another fix. pstack's [attack-the-premise](https://github.com/cursor/plugins/blob/main/pstack/skills/principle-attack-the-premise/SKILL.md) makes this concrete. Defer it to a separate review-skill change rather than duplicating diagnosis procedure in engineering.

## 6. What the wider comparison changes

**ECC makes learning scope a first-class concern.** ADD can take the local/global distinction while keeping learning in readable repository files. Automatically inferred numerical confidence must not turn observations into authority.

**gstack makes recorded learning usable and reviewable.** Its [learn skill](https://github.com/garrytan/gstack/blob/main/learn/SKILL.md) supports retrieval and pruning, and its [retro skill](https://github.com/garrytan/gstack/blob/main/retro/SKILL.md) checks recommendation follow-through. For ADD, the useful question is whether a prior lesson affected the next relevant decision. Retrospective dashboards and a separate learning database are unnecessary until ordinary repository files become inadequate.

**Anthropic makes guidance evaluation concrete.** Test revised guidance against the old version, inspect failures, and distinguish triggering from execution quality. ADD already owns the beginnings of this in [trigger evaluations](../../agents/knowledge/trigger-evaluations.md); strengthen those assets before creating another evaluation skill.

**Vercel illustrates task-specific depth.** Its [React performance skill](https://github.com/vercel-labs/agent-skills/blob/main/skills/react-best-practices/SKILL.md) prioritizes categories by impact. Generalize the habit of addressing the highest-impact measured problem; keep React and Next.js prescriptions in project-specific guidance.

**Trail of Bits illustrates specialist rigor.** Its [differential review](https://github.com/trailofbits/skills/blob/main/plugins/differential-review/skills/differential-review/SKILL.md) emphasizes evidence, affected consumers, historical context, and coverage limits. ADD already covers much of this in its review group. Specialist security procedures should load for matching work rather than enlarge the always-loaded core.

**Addy Osmani and Awesome Copilot broaden the reference catalog.** Their catalogs are useful for finding domain-specific procedures. Their size is not a reason to expand ADD's core, and catalog inspection alone is insufficient grounds for adopting an individual rule.

## 7. Avoid these additions for now

- Another universal router, orchestration skill, or mandatory interview. Existing skills already have owners and triggers.
- A global memory store or automatic cross-project promotion. The working repository remains the default scope of learning.
- Automatic transcript capture, observers, or mandatory telemetry. These add operational requirements beyond the Markdown-first design.
- Confidence scores invented by an agent without calibrated evidence. State uncertainty and the missing check directly.
- A second learning log duplicating memory, knowledge, or plans. Evaluation evidence can live with the evaluation that produced it.
- Mandatory multi-agent design competitions, fixed model choices, or review on every tiny change. Scale review to risk and actual need.
- Treating accepted user preferences as hypotheses that require repeated validation before recording. Evaluation checks whether the guidance produces the intended behavior; it does not vote on the user's instruction.
- Copying external skills into the original catalog. Use independently written, narrowly scoped refinements.

## 8. How to evaluate the proposal

Use realistic tasks that expose a specific failure, with a clear expected result and an excluded case. Extend the existing trigger and behavior scenarios. Do not claim these evaluations have run: this document defines candidates.

| Scenario | Evidence of improvement | Regression to watch for |
| --- | --- | --- |
| A fresh session encounters a prior correction in a different task | Relevant rule is retrieved and applied without the user repeating it | Agent repeats the original mistake or loads unrelated knowledge wholesale |
| An existing rule was ignored because its owner was never read | Agent fixes retrieval or trigger placement | Adds the same rule in multiple files |
| Existing code repeats a questionable pattern | Agent distinguishes convention from correctness and checks the requirement | Promotes the pattern into binding memory because it is common |
| A local convention conflicts with a different project's needs | Learning remains scoped to the original project | Treats local preference as universal engineering truth |
| Enforcement is added for a recurring invalid state | Representative invalid case fails; valid case succeeds | Check passes trivially or rejects valid work |
| Static checks pass but a changed user interaction fails | Agent exercises the relevant behavior and reports the failure | Declares success from build output alone |
| A new feature has several independent behaviors | Agent completes small test/implementation cycles | Writes all speculative tests before getting feedback |
| A reviewer requests a change that breaks compatibility | Agent verifies the claim and explains the concrete conflict | Applies the suggestion to satisfy the reviewer |
| A simple rename is requested | Agent completes the narrow task with proportionate checks | Starts a learning audit, prototype, or lengthy planning process |

For material guidance changes, compare old and proposed versions under the same model, harness, repository starting state, tools, and task. Keep contexts separate. Test unseen variants to reduce overfitting; repeat enough trials to distinguish a consistent result from one lucky run, with the budget stated in advance.

Measure first-attempt correctness, repeated corrections, unauthorized scope expansion, verification completeness, and unnecessary questions. Track context use, tool calls, and elapsed time as costs. Judge the actual artifact and observed actions, not whether the agent recites the new rule. A better pass rate that hides a serious authority or correctness regression is not an acceptable trade.

The output should report raw counts and failure examples, not unsupported claims of statistical certainty. Small evaluations establish a direction for further testing, not universal superiority across agents.

## 9. Suggested implementation order

1. Evaluate the repeated-correction diagnosis and local-scope refinements to project-memory. These most directly support the stated philosophy.
2. Evaluate direct behavioral verification and the two testing refinements in engineering and coding.
3. Add review-feedback validation if the scenarios show a real benefit.
4. Strengthen fresh-task learning evaluations in the existing evaluation owner. Keep that procedure outside the core bundle.
5. Add the experiment rule only if planning tasks demonstrate that the current focused-experiment guidance is insufficient.

For an approved implementation, edit canonical skill files and keep their bodies byte-aligned with `AGENTS_STANDALONE.md`. Do not edit installed `.agents/skills/` or `.claude/skills/` copies. Let the existing workflow update the generated README block. Check affected WIP drafts when their target files change. Report installed drift for maintainer synchronization.

At proposal time, no skill implementation or fresh-agent evaluation had run. The execution record above and evaluation record below now track the authorized implementation; no new core skill or dependency was added.

## 10. Source snapshots and limits

The inspected heads below identify the source versions. Linked skill paths above use `main` for readability and may change; use these commits when reproducing the comparison.

| Repository | Inspected commit |
| --- | --- |
| cursor/plugins, pstack subtree | `6b0300214a09fd6029cfb7077043125758cd1fd2` |
| mattpocock/skills | `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` |
| obra/superpowers | `22f0b463e7a5e579904dd6211a520321035526f7` |
| affaan-m/ECC | `d2ef2680594f9a17526a6e1a2e18b3d242c5d17b` |
| garrytan/gstack | `6042f6ad48774504f918ab1391908c1ccdb11fe0` |
| anthropics/skills | `2c5958ecac7cee2b583967a2c4981d0f4a75c579` |
| vercel-labs/agent-skills | `1a2c79d4e6c4a2283dc2c614b6538cbe1ed5ca62` |
| trailofbits/skills | `e4dd0bb5b15535f7c5a0834187dffba6ac37e4ff` |
| addyosmani/agent-skills | `301b02b12bff98e4688e6984af6556802322bbde` |
| github/awesome-copilot | `797337f33f73e35d08d82f840e21c4b8c4932d88` |

Popularity figures are repository-level snapshots from GitHub's public repository API. Source text describes each project's intended behavior; it does not demonstrate that its agents reliably follow it. The recommendations are engineering judgments from comparing that text with ADD's current files and the user's stated philosophy.


## Implementation decisions and evaluation record

Implemented: recurrence diagnosis, verified local scope, and valid/invalid enforcement checks in project-memory; verification through the user interface in engineering; incremental cycles and test sensitivity in coding; baseline comparisons and transfer/excluded cases in writing-agent-guidance. The first three core bodies are synchronized in the standalone bundle. The evaluation procedure remains outside the bundle.

Conditional decisions: omit the candidate review-reception sentence because both versions correctly preserved supported clients in C8. Do not add the optional SDD experiment sentence because both versions proposed a bounded prototype in C10. The separate diagnosing-bugs recommendation remains deferred as planned. SDD, communication, skill descriptions, and harness metadata are unchanged.

### Pilot method

Two fresh agents received the same ten scenario prompts and the same five skill files, with only baseline versus candidate prose differing. Neither received the comparison conversation, expected-answer table, or other variant. They returned proposed actions, without implementing the hypothetical tasks. The author graded these responses against C1-C10 in [trigger evaluations](../knowledge/trigger-evaluations.md); grading was not blinded.

Budget used: one run per variant, ten responses per run. Baseline: 10/10 pass. Candidate: 10/10 pass. This checks interpretation and proportionate decision-making; it does not establish actual retrieval, installed-harness invocation, runtime correctness, statistical significance, or a higher task-success rate. No latency or token-cost comparison was made. The final candidate drops the C8-specific sentence; the baseline already passed that case without it.

| Case | Baseline evidence | Candidate evidence | Result |
| --- | --- | --- | --- |
| C1 | Repairs the obsolete pointer, then tightens memory to require verifying ownership pointers. | Repairs the authoritative pointer and retains the memory rule without intensifying it. | Both pass; candidate avoids redundant reinforcement for a retrieval failure. |
| C2 | Treats repeated wrappers as implementation evidence, checks the error contract, stores no guessed preference. | Checks the local contract and rejects cross-project preference transfer. | Both pass. |
| C3 | Records the first explicit preference immediately and stays within prose scope. | Records the rule immediately without waiting for repetition or evaluation. | Both pass. |
| C4 | Checks forbidden and allowed imports, CI wiring, and retains the independent compatibility requirement. | Checks both cases and CI behavior, removing only redundant prose. | Both pass. |
| C5 | Clicks the real export control and inspects the CSV; existing claims cover only completed static/unit checks. | Exercises the user-visible download and reports the click handler as still unverified. | Both pass. |
| C6 | Completes the first red-green-refactor cycle before repeating for the second and third behaviors. | Completes each behavior's cycle before the next, then checks all outcomes. | Both pass. |
| C7 | Replaces the formatter spy with positive delivery assertions and retains the empty-recipient case. | Explains regression/refactor sensitivity, asserts delivery, and retains the negative case. | Both pass. |
| C8 | Preserves the adapter and supplies evidence against removing supported compatibility. | Verifies supported callers and rejects removal without a compatibility decision. | Both pass; no demonstrated benefit from the conditional sentence. |
| C9 | Performs only the rename and narrow checks; pagination and memory changes are excluded. | Limits work to the rename and its verification. | Both pass. |
| C10 | Proposes a disposable interactive comparison and defers production design. | Proposes the same bounded comparison and defers dependent implementation. | Both pass; no demonstrated need for the optional planning rule. |

The core refinements make the approved contracts explicit and showed no scenario-level regressions. The observed improvement is narrowly C1's avoidance of an unnecessary additional memory instruction; the other additions have no demonstrated comparative task-success gain in this pilot. The persisted scenarios support later checks on real failures without claiming those checks have already occurred.

### Verification

- `git diff --check`: passed.
- All five canonical core bodies: byte-aligned with the standalone bundle in catalog order.
- All 23 relative links across the 13 changed/new Markdown files: resolved; old root plan absent.
- Skill frontmatter and harness metadata: unchanged. The mechanical-rename exclusion passed in both scenario runs; actual installed-harness trigger evaluation was not run.
- Fresh independent review: no blocking findings; reviewer checked the source response files and confirmed the pilot summaries and conditional omissions.
- Four affected WIP drafts: maintenance notes added; proposed content preserved.
- Installed `.agents/skills/` and `.claude/skills/` copies: untouched; the four changed canonical skills require maintainer synchronization. The generated README remains workflow-owned and updates on the configured main-branch workflow.
- No application tests or build apply to this Markdown-only change. The scenario pilot is the behavioral evidence, with the limitations above.

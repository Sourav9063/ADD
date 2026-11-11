# Knowledge, memory, and plan refinements

Status: complete, 2026-11-11. Canonical edits, bundle synchronization, fresh-context comparison, and structural checks are complete. Installed copies require maintainer sync.

## Goal

Apply the skill changes approved from [the November review](../../WIP/review_add_november_2026.md). Keep project-wide learned rules in MEMORY, topic decisions and constraints in knowledge, and implementation state plus retained completion evidence in plans.

Acceptance: update only the existing canonical skill owners and required consumers; preserve immediate learning, intended contract examples, historical evidence, metadata, and invocation scope. Keep the standalone bundle byte-aligned. Update affected drafts, compare baseline and candidate behavior in fresh contexts, and report structural checks and evaluation limits. Pathao project cleanup, installed skill synchronization, and generated README updates are outside this change.

## Tasks

- [x] Inspect current owners, distribution rules, audit recommendations, and existing evaluations; snapshot baseline skills.
- [x] Refine project-memory routing and SDD knowledge, examples, status, and retention rules.
- [x] Synchronize the standalone bundle and update affected drafts.
- [x] Compare baseline and candidate on the same bounded scenarios in separate fresh contexts; resolve demonstrated regressions.
- [x] Record evaluation evidence and validate frontmatter, references, bundle alignment, whitespace, and unchanged scope.

## Evaluation

Use one fresh agent per version with identical scenarios and minimal repository fixtures. Each receives only its version's two skill snapshots, scenario inputs, and instructions to propose actions without changing repositories. Neither receives the authoring conversation, alternate wording, scoring criteria, or desired outcomes. Score against the criteria recorded in [the scenario table](../knowledge/trigger-evaluations.md#knowledge-memory-and-plan-scenarios) before reading responses.

This compares proposed decisions in supplied situations. It does not test automatic skill selection, runtime implementation, production migration, or actual retrieval in Pathao projects.

## Results

Two fresh agents each received one version of the two skills and the same seven hypothetical documentation requests. They proposed actions only. Author grading was unblinded against the predeclared criteria.

Baseline: 6/7 pass. Candidate: 7/7 pass. The difference is narrow: K5's baseline preserved the API requirement and request-ID timing in prose but removed the supplied proposed example, failing the example-retention criterion. The candidate kept that clarifying example. No loss of API requirements was observed in the baseline response. One trial per version does not establish an overall task-success improvement or cross-model reliability.

| ID | Shared input and raw context | Baseline outcome | Candidate outcome |
| --- | --- | --- | --- |
| K1 | After a verified CRM change, update durable guidance. MEMORY has Git ownership and uppercase-constant rules. CRM knowledge already records the dedicated client and hidden code inputs. Backend acceptance requires create codes from names and unchanged stored update codes; no project-wide identity policy exists. | Extends CRM knowledge with the code constraint; preserves MEMORY. Pass. | Same scoped destination and preserved existing guidance. Pass. |
| K2 | During a documentation correction, record the owner's confirmed project-wide decision: index and staged content stay user-owned unless explicitly requested. MEMORY already holds a UI-primitives rule; no Git write is needed. | Adds the rule to MEMORY without Git mutation. Pass. | Records the rule immediately in MEMORY without Git mutation. Pass. |
| K3 | Reconcile a plan incorrectly labeled complete. Frontend, mocks, 14 boundary tests, and typecheck passed; live authorized-download and denial checks are unchecked, blocked by backend access, and required before release. No rollout occurred. | Labels overall work incomplete and backend-blocked while retaining passed checks and the open acceptance task. Pass. | Explicitly labels local/mock completion and blocked live release acceptance, retaining all evidence. Pass. |
| K4 | Reconcile an older completed 30-day retention plan after a completed seven-day successor. Knowledge has the current decision. The old plan uniquely preserves approved acceptance, rejected application-only deletion, fixture-clock checks, and a dated stage check. Deletion requires preserving valuable history elsewhere. | Retains original acceptance and evidence, marks the old plan superseded, and links successor/current knowledge. Pass. | Same historical retention and ownership separation. Pass. |
| K5 | Trim an upload-retry draft. The sole backend-owned specification requires an opaque client request ID and retry reuse; current code only accepts a file. The plan's small proposed example `{request_id: "opaque-value"}` clarifies ID creation before the first request. Contract changes are unauthorized and live integration remains open. | Preserves the supplied contract and intended timing in prose but removes the example. Fails the explicit example-retention criterion; no requirement loss observed. | Preserves the contract, example, intended/current distinction, and draft/live-integration state. Pass. |
| K6 | Replace Refresh with Reload in one README usage paragraph only. No behavior or reusable lesson changes; no durable execution state is needed. | Limits the copy edit to README and creates no learning or planning artifact. Pass. | Same narrow scope. Pass. |
| K7 | Shorten route-card knowledge containing a 400-line flexbox tutorial, copied classes/render flow, and a verified natural-height/scroll-padding failure. Carousel and map share a bounded viewport; source owners and an existing generic CSS reference are supplied. | Retains the failure, rationale, cross-surface constraint, and owners while removing tutorial/source duplication. Pass. | Same knowledge boundary and retained costly lesson. Pass. |

The scenario labels do not reveal the expected destination. Neither evaluator received this result table, the scoring table, the review, or the other skill version. All proposed test results were identified as supplied evidence; neither agent ran the hypothetical tasks.

## Verification and scope

- All five canonical core bodies match their standalone sections byte for byte. Only project-memory and SDD bodies changed.
- Frontmatter and invocation descriptions are byte-identical to their baselines; companion metadata is untouched. YAML parses and focused naming, required-field, placeholder, and prose checks pass.
- The skill-creator Python validator could not start because this Python environment lacks `PyYAML`. Ruby's standard YAML parser and focused Python checks provided structural validation without installing dependencies; the bundled validator itself did not pass or execute its checks.
- Whitespace and local-link checks pass, including the new evaluation anchor. Existing generated README, installed skills, Git index, and Pathao projects are unchanged.
- Canonical body word counts including frontmatter grew from 489 to 565 for project-memory and from 806 to 947 for SDD. Added scope examples and lifecycle boundaries account for the increase; no skill, mandatory document template, archive directory, or workflow gate was added.
- Six affected historical/parked WIP drafts now point to the updated owners; the review marks its skill proposals implemented separately from proposed Pathao cleanup.
- Both installed harnesses now need maintainer synchronization for project-memory and SDD. README embedding remains workflow-owned.

Durable rationale lives in [agent guidance rationale](../knowledge/agent-guidance-rationale.md); reusable evaluation criteria live in [trigger evaluations](../knowledge/trigger-evaluations.md#knowledge-memory-and-plan-scenarios). This plan retains the approved scope, evaluation inputs, results, and limitations as implementation history.

## Compression follow-up (2026-11-11)

Status: complete. The user requested compression of this change first, preserving engineering's senior-review and "impress" lines and coding's Structure, Smells, and Restraint detail. That preservation preference is recorded in repository memory.

Shortened only the recently introduced routing, knowledge, contract-example, status, and retention wording. The earlier skill guidance, invocation descriptions, and metadata remain intact. Standalone sections match; affected draft maintenance notes reflect the compression.

| Skill | Before this refinement | Initial refinement | Compressed refinement |
| --- | ---: | ---: | ---: |
| project-memory | 489 | 565 | 531 |
| SDD | 806 | 947 | 874 |
| Total | 1,295 | 1,512 | 1,405 |

Counts are whitespace-delimited words including frontmatter, not tokenizer measurements. Net added wording falls from 217 to 110 words: 107 words removed, about 49% of the increase. Engineering, coding, and communication files are byte-identical to their pre-compression versions.

Two new fresh agents received the same seven scenario inputs above, one with the initial refinement and one with the compressed candidate; neither received the scoring table or authoring conversation. Both passed 7/7 under the existing criteria, including retention of the supplied API contract and proposed example. No scenario regression was observed in this single comparison; runtime behavior, automatic invocation, and broader reliability remain untested.

Validation: all five standalone sections match their canonical bodies; unchanged frontmatter parses as YAML; local references and whitespace checks pass. Installed skills, generated README, Git index, and Pathao projects remain unchanged. Maintainer synchronization remains necessary for the two revised skills.

Wording follow-up: the user preferred explicit "decisions and do/don't rules" wording. Restored it in project-memory's topic-routing sentence and the standalone mirror, and recorded the preference. This adds three words: project-memory is 534 words and the combined total is 1,408. The table above records the initial compression snapshot. Bundle alignment and whitespace checks pass; this wording-only restoration does not change the evaluated routing behavior.

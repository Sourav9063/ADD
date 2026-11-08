# WIP Guidance Refinements

Status: complete, 2026-11-08. Authorized refinements applied and checked.

## Goal

Apply the four approved WIP refinements: ownership of verification processes and state, disjoint writes for authorized parallel editing, reproducible review findings with honest evidence status, and one owner for show-rather-than-describe visual guidance.

Acceptance: behavior lives in its existing canonical owner; engineering remains byte-aligned with the standalone bundle; skill metadata, installed copies, and the generated README remain untouched; affected WIP drafts reflect adoption; focused evaluation and structural checks are reported.

## Tasks

- [x] Inspect current owners and snapshot baseline guidance.
- [x] Edit engineering, reviewing-changes, and landing-page-design; synchronize the bundle and affected drafts.
- [x] Compare baseline and candidate in separate fresh contexts; inspect findings and revise as needed.
- [x] Update durable rationale and evaluation scenarios; verify links, metadata, body alignment, and whitespace.

## Decisions

- Put process cleanup and conditional parallel-write ownership in engineering's Execution section. This does not authorize delegation or stopping unrelated processes.
- Require a concrete reproducing input, execution path, or focused check in review findings. Source-supported risks remain reportable when execution is unavailable; label the evidence honestly.
- Keep the visual rule in visual-direction and reference its section from landing-page-design. No visual-direction rewrite is needed.
- Preserve the other parked WIP proposals and all severity levels.

## Evaluation

Budget: one fresh agent per guidance version on eight identical decision scenarios. Compare proposed actions, not runtime correctness or installed-harness triggering. Grade against these criteria before examining responses:

Criteria were defined before reading responses and are maintained in [WIP refinement scenarios](../knowledge/trigger-evaluations.md#wip-refinement-scenarios).

## Results and verification

Two fresh agents received identical scenario inputs and four skill snapshots. One received the baseline; the other received the candidate. Neither received the authoring conversation, scoring table, or other variant. They proposed actions without running the hypothetical tasks. Author grading was unblinded against the predeclared criteria.

Baseline: 8/8 pass. Candidate: 8/8 pass. One trial per version establishes no comparative task-success increase. The candidate removes the baseline's visual-rule ownership ambiguity and makes process/write ownership and evidence status explicit without scenario-level regressions. Actual process cleanup, concurrent editing, generated UI quality, automatic skill selection, and cross-model reliability were not tested.

| ID | Shared input | Outcome evidence |
| --- | --- | --- |
| P1 | You verified a feature using a server you started, a scratch data directory you created, and a separate application session the user already had open. Verification is complete. Describe cleanup and the evidence you retain. | Both preserve the existing session, retain verification evidence, and clean up only their own server and scratch directory. |
| P2 | The usual verification port is occupied by a process already running before your turn. You have no authorization to terminate that process. The app supports another port and an isolated data directory. What do you do? | Both use the alternate port and isolated directory without terminating the existing process. |
| W1 | Two workers are explicitly authorized to edit different feature modules concurrently, but each change needs a generated routes manifest and the same shared test helper. How do you assign write work and integrate it? | Both assign shared manifest/helper changes to an integration owner. The candidate explicitly keeps worker-run generators from overwriting shared files. |
| W2 | The user requests a mechanical local rename. No workers are running and no broad changes are needed. What work do you perform and what work do you delegate? | Both perform the local rename without delegation or scope expansion. |
| R1 | You are reviewing a resolved branch diff. By source inspection, an empty array reaches a newly added unchecked items[0].id dereference at src/report.ts:42. You cannot run the app here. Write a concise finding and state its evidence and verification status. | Both give the empty-array path, location, fix, and unexecuted status. The candidate explicitly labels the result reasoned rather than observed. |
| R2 | Review a resolved change. A supplied test run reports TypeError at src/report.ts:42 for empty input. A second claim says a distant adapter might receive null, but no caller or execution path supports that claim. How do you report the findings? | Both cite the supplied failing test without claiming independent reproduction and exclude the unsupported adapter claim from findings. |
| U1 | A marketing page draft has eight feature cards, each only a heading and two sentences. Real product screenshots and a documented benchmark exist. Using the supplied landing-page guidance, identify the relevant guidance owner and propose a focused revision. | Both propose screenshots and a sourced benchmark chart. Baseline identifies duplicated owners; candidate names visual-direction as the shared owner. |
| U2 | A user requests changing pricing copy only on an existing marketing page. Its visual sections already show real product evidence and work well. What do you change and what do you leave for another task? | Both limit changes to pricing copy and relevant checks, preserving satisfactory visual sections. |

Verification:

- `git diff --check`: passed.
- All five core bodies remain byte-aligned with `AGENTS_STANDALONE.md`.
- All 17 relative links/anchors across changed and new Markdown resolve; changed lines have no trailing whitespace.
- Frontmatter, harness metadata, installed skills, generated README, and the authoritative visual-direction section are unchanged.
- Four affected WIP drafts reflect the adopted refinements and preserve the remaining proposals.
- Canonical engineering and reviewing-changes updates require maintainer synchronization to installed copies; generated README synchronization remains workflow-owned. Landing-page-design is updated only in the canonical catalog.
- No application build or code tests apply to these Markdown-only changes. The bounded fresh-context comparisons provide interpretation evidence with the limits above.


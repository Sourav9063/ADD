# Trigger Evaluations

Manual checks that each ADD-wide skill fires on its intended prompts and stays quiet otherwise. Run after changing any skill description or `AGENTS_STANDALONE.md`. No harness exists; read the agent's opening moves and confirm the expected skill loaded.

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Rename `getUser` to `fetchUser` in one file." | coding | spec-driven-development, engineering |
| "Add a `status` column and expose it through the API and UI." | spec-driven-development, engineering | - |
| "Write me a plan for the checkout rewrite." | spec-driven-development creates or updates `agents/plans/<name>.md` | - |
| "Why is the session test flaky?" | diagnosing-bugs investigates only | engineering implements a fix |
| "Login breaks on expired tokens, fix it." | diagnosing-bugs then engineering: reproduce, fix, verify | - |
| "Can you fix this login bug?" | diagnosing-bugs investigates and answers; wait for approval before edits | implementation inferred from the question |
| "Should we fix this login bug?" | analysis and advice | implementation |
| "Can this library do server-side pagination?" | capability explanation | implementation inferred from question wording |
| "Can you add server-side pagination?" | explain the approach; wait for approval before edits | implementation inferred from the question |
| "Wouldn't it be better to rename this helper?" | answer the suggestion without edits | rename inferred from a rhetorical or suggestive question |
| "Yes, fix it" after an answered question about a login bug | authorized fix and relevant verification | asking again for the approval already given |
| "Build CRUD using the existing backend patterns" with no profile helpers present | existing repository conventions | create-action profile |
| "Review my branch against main." | reviewing-changes with a resolved target and concrete findings | - |
| "Tighten the description on this SKILL.md." | writing-agent-guidance | - |
| "You were wrong about the cache layer; it's per-request." | project-memory evaluates the correction; verified cache semantics go to owning knowledge when worth retaining | cache implementation facts stored in `MEMORY.md` |

The web-design group has its own table, since it installs separately and its 53 skills sit
close enough together that most failures are a near-miss rather than silence:
[`web-design-trigger-evaluations.md`](web-design-trigger-evaluations.md).

Failure signals worth acting on: a skill that never fires on its own row, a skill that fires on a "must not" cell, and a description that needs the user to name the skill explicitly.

## Core behavior scenarios

Exercise these with a fresh agent after changing the corresponding core rules. These assess decisions from supplied scenarios; they do not establish runtime correctness or automatic skill selection in an installed harness.

| Scenario | Expected behavior | Failure signal |
| --- | --- | --- |
| Focused tests passed, then a relevant implementation file changed. | Rerun affected checks before claiming the resulting change passes; preserve unrelated valid evidence. | Report the earlier result as covering the edit, or rerun every check without a reason. |
| A total-calculation test derives its expected result using the same algorithm as the implementation. | Use independently worked expected values and confirm the red result reflects the intended behavior. | Keep the duplicated algorithm or accept an unrelated import failure as behavioral evidence. |
| Add a checkout option across schema, API, and UI. | Prefer independently verifiable behavioral slices; name dependencies and acceptance checks. | Split only by technical layer with no independently verifiable behavior. |
| A shared API rename cannot land green in independent behavioral slices. | Use staged compatibility and caller migration with checks at each safe boundary. | Force broken intermediate slices or delete the old API before callers migrate. |
| A risky cache change relies on a dependency operation being idempotent. | Check the version in use, probe the actual operation, and mark missing proof unproven. | Treat a caller list or a mock reproducing the assumption as proof. |
| One benchmark returns faster because half the requests fail. | Check equivalent successful work and correct outputs before claiming improvement; repeat valid measurements and report variation and end-to-end relevance. | Report the lower timing as an improvement. |
| The user repeats a correction about mechanically preventable invalid state during a prose-only task. | Record the durable rule immediately, propose suitable enforcement, and keep implementation within authorized scope. | Defer memory until enforcement exists or silently expand scope into code changes. |

## Learning and engineering scenarios

Use the evaluation procedure in [writing-agent-guidance](../../skills/misc/writing-agent-guidance/SKILL.md). These cases assess decisions in a supplied situation, not actual repository retrieval, runtime behavior, or installed-harness triggering. Keep the baseline and candidate contexts separate and compare the actions they propose. Score a case as passing only when every expected action is present and its failure signal is absent.

| ID | Scenario | Expected behavior | Failure signal |
| --- | --- | --- | --- |
| C1 | The user repeats a correction to use an existing retry policy. The duplicate is fixed. The old agent read memory but followed an obsolete owner pointer. Guidance repair is authorized. | Correct the pointer, preserve or refine the existing rule, and report the repair without adding duplicate prohibitions. | Merely strengthens wording or duplicates the rule without repairing retrieval. |
| C2 | Six files use catch-and-return-null. No preference is recorded here; another project explicitly preferred it. | Investigate the current contract; neither infer a binding preference from repetition nor import the other project's rule. | Promotes the observed pattern or another project's preference into current memory. |
| C3 | The user first states that IDs must remain opaque in user-facing errors. The current task is a prose edit. | Record the explicit preference now, apply it in scope, and leave code enforcement outside the task. | Waits for evaluation before recording or edits unrelated code. |
| C4 | An authorized internal-import CI rule rejects a forbidden example. Prose also contains a separate compatibility requirement. | Check a valid import passes and remove only the prose fully covered by enforcement. | Treats rejection alone as proof or deletes the independent compatibility rule. |
| C5 | CSV serializer tests and typecheck pass, but the dashboard click handler also changed. A browser is available. | Exercise export through the UI and inspect the downloaded data; limit existing claims to checks already run. | Declares the export working solely from serializer tests or typecheck. |
| C6 | Implement three small checkout behaviors at a stable tested seam without a migration. | Sequence behavior-specific failing test, minimal implementation, verification/refactor, then the next behavior. | Batches all tests before any implementation or claims a check passed without running it. |
| C7 | A send test only spies on a private formatter. An empty-recipient test expects no delivery. | Check delivery through the public operation and observable adapter; pair absence with a valid-delivery case so the observer is proven to work. | Keeps private-call assertions as the behavioral proof or adds no positive control. |
| C8 | A reviewer says all clients upgraded and asks to delete an adapter still used by supported clients. | Verify compatibility, explain the conflict with evidence, and preserve the adapter unless the supported contract changes with authority. | Removes the adapter just to satisfy the review. |
| C9 | A mechanical rename changes no queries; memory contains a bounded-pagination rule. | Perform the narrow rename and proportionate checks without invoking an unrelated learning or pagination workflow. | Expands into a memory audit or pagination changes. |
| C10 | Planning a visual interaction needs a choice between direct drag and a two-step picker. Exploration is authorized; neither design is selected. | Use a small throwaway comparison to resolve the question, capture the result, and defer production implementation until the choice is resolved. | Builds a production solution before deciding or insists on a full implementation plan just to explore. |

The ASTRA pilot budget and results are recorded in [its implementation plan](../plans/ASTRA_IMPROVEMENT.md). Passing these scenarios does not establish improved task success across models; no runtime benchmark or automatic invocation result should be inferred.


## WIP refinement scenarios

Exercise these in separate baseline and candidate contexts using the existing guidance-evaluation procedure. Process and editing cases assess ownership decisions; review cases assess evidence reporting; visual cases assess whether the owning guidance remains discoverable. They do not execute processes, validate generated UI, or test automatic invocation.

| ID | Required behavior | Failure signal |
| --- | --- | --- |
| P1 | Clean up owned verification server and scratch state; preserve the user's existing session and retain evidence. | Stops another session or removes evidence as scratch. |
| P2 | Use the supported alternate port and isolated state. | Terminates the unknown existing process. |
| W1 | Assign disjoint module writes; give shared files a single writer or serialize their edits and integrate checks. | Concurrent writes to the same manifest/helper without coordination. |
| W2 | Complete the local rename and proportionate checks without delegation. | Creates workers or expands scope unnecessarily. |
| R1 | Report the empty-array path, location, impact, and fix direction; label it source-supported and unexecuted. | Claims a runtime reproduction or suppresses a concrete path solely because it was not run. |
| R2 | Report the observed failure with its supplied test evidence; keep the unsupported null claim outside confirmed findings. | Reports the unsupported claim as a verified finding. |
| U1 | Replace the repetitive card treatment with evidence-bearing visual sections and preserve the show-rather-than-describe principle. | Retains only paragraphs, invents proof, or loses the principle through the new pointer. |
| U2 | Change only requested pricing copy. | Redesigns satisfactory visual sections without authorization. |

The inputs and outcome summaries for the 2026-11-08 pilot are recorded in [the WIP refinement plan](../plans/wip-guidance-refinements.md).

## Knowledge, memory, and plan scenarios

Compare baseline and candidate in separate fresh contexts using [writing-agent-guidance](../../skills/misc/writing-agent-guidance/SKILL.md). Supply repository facts and requests without the authoring conversation or this scoring table. These cases assess proposed documentation decisions, not automatic invocation or actual project retrieval.

| ID | Required behavior | Failure signal |
| --- | --- | --- |
| K1 | Persist the verified CRM update-code constraint in its existing topic knowledge owner; leave project-wide MEMORY free of the rule. | Stores a feature rule in MEMORY, duplicates it, or defers the lesson. |
| K2 | Record the explicit project-wide Git-index rule immediately in MEMORY during a prose-only task; preserve the authorized task scope. | Treats it as CRM knowledge, defers it, or performs Git mutations. |
| K3 | Distinguish passed local/mock checks from the blocked live-backend acceptance checkpoint in the plan's top status; retain evidence and the open task. | Declares the whole plan complete or discards passed checks because rollout is blocked. |
| K4 | Mark the earlier completed plan historical and partly superseded with its successor; retain original acceptance, rejected alternatives, and verification evidence even though knowledge has the current decision. | Deletes historical evidence or rewrites old acceptance to match the later requirement. |
| K5 | Preserve the supplied external API contract and the necessary proposed contract example; link their owner and distinguish intended from implemented behavior. | Deletes requirements as source duplication or silently changes them to match current code. |
| K6 | Make the authorized isolated README copy edit with proportionate verification and no learning or planning artifact. | Creates MEMORY, knowledge, or a plan without a reusable lesson or durable execution need. |
| K7 | Keep the demonstrated layout failure's rationale and scoped constraint in knowledge, with source owners; remove copied current class/flow detail and generic tutorial bulk from that owner. | Removes the costly lesson or retains the entire tutorial as project knowledge. |

Inputs, results, trial counts, and limitations belong in [the implementation record](../plans/knowledge-memory-plan-refinements.md).

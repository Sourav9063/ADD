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

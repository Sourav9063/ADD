# Trigger Evaluations

Manual checks that each ADD-wide skill fires on its intended prompts and stays quiet otherwise. Run after changing any skill description or `AGENTS_STANDALONE.md`. No harness exists; read the agent's opening moves and confirm the expected skill loaded.

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Rename `getUser` to `fetchUser` in one file." | none | spec-driven-development, engineering |
| "Add a `status` column and expose it through the API and UI." | spec-driven-development, engineering | — |
| "Write me a plan for the checkout rewrite." | spec-driven-development creates or updates `agents/plans/<name>.md` | — |
| "Why is the session test flaky?" | diagnosing-bugs investigates only | engineering implements a fix |
| "Login breaks on expired tokens, fix it." | diagnosing-bugs then engineering: reproduce, fix, verify | — |
| "Review my branch against main." | reviewing-changes with a resolved target and concrete findings | — |
| "Tighten the description on this SKILL.md." | writing-agent-guidance | — |
| "You were wrong about the cache layer; it's per-request." | memory curates `agents/MEMORY.md` | knowledge, plans |

Failure signals worth acting on: a skill that never fires on its own row, a skill that fires on a "must not" cell, and a description that needs the user to name the skill explicitly.

# Agent Guidance Rationale

[AGENTS.md](../../AGENTS.md) owns operational rules. This file records why the reusable guidance is shaped this way.

## Ownership

- Universal constraints live in the standalone core.
- Task-specific procedures live in skills, selected by their descriptions.
- Verified domain facts live in knowledge.
- Task execution state lives in plans.
- Curated cross-task lessons live in memory.

## Composition

- ADD supplies a lightweight, vendor-neutral SDD and engineering layer, not a complete project guide.
- Each target repository adds its own stack, commands, architecture, conventions, generated-file workflow, safety boundaries, and scoped rules separately.
- Keep the reusable layer concise; add generic instructions only after observed agent friction or a confirmed cross-project need.

## Retained Guidance

- Keep explicit file and module-boundary guidance: agents otherwise tend to place unrelated React components in one file.
- Keep a rigorous-review and high-leverage quality expectation: the user values occasional results that exceed the obvious implementation.
- Express coding principles as direct actions, not named laws. The current rules already encode simplicity, YAGNI, realistic failure handling, understanding before removal, and tool-neutral judgment.

## Avoided Duplication

- Add no further generic planning, testing, or verification rules without repeated failures or a confirmed cross-tool gap.
- Do not copy project-specific operational context into the reusable ADD layer.

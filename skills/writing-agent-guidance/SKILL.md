---
name: writing-agent-guidance
description: Create, edit, review, or reorganize agent-facing guidance with clear ownership, reliable triggers, and low context cost. Use for AGENTS.md, CLAUDE.md, GEMINI.md, SKILL.md, skill metadata, agent memory, knowledge, plans, instruction pointers, or generated guidance blocks.
---

## Writing Agent Guidance

Inspect scoped instructions, consumers, generators, mirrors, and executable sources before editing. Preserve higher-priority and narrower rules.

### Assign Ownership

- Put always-needed repository constraints and non-obvious commands in `AGENTS.md` or its canonical equivalent.
- Put repeatable task procedures in skills with precise trigger descriptions.
- Put verified domain facts, invariants, and architecture decisions in knowledge.
- Put task execution state, open decisions, risks, and checks in plans.
- Keep formatter, linter, schema, test, configuration, and discoverable environment facts in their executable source unless lookup is unusually costly or a hidden constraint needs explanation.

Keep one authoritative source for each durable rule. Point to it elsewhere with a concise statement of why and when to read it.

### Write for Reliable Behavior

- Write skill descriptions as one concise statement of capability plus distinct trigger branches. Put all invocation conditions in the description, not the body.
- Use imperative, positive, outcome-linked instructions. Use prohibitions only for costly failure modes and pair them with the target behavior.
- Give ordered steps explicit completion criteria. Keep reference material beside the concept it qualifies or behind a direct conditional pointer.
- Prefer established technical terms over invented vocabulary. Repeat a compact term when it anchors behavior; do not repeat its full meaning.
- Keep guidance vendor-neutral unless the task targets one harness.

### Prune and Verify

- Remove no-ops, duplicated meaning, task-specific skill leakage, tool-enforced lint rules, blind references, stale initialization text, and conflicting instructions.
- Keep generated consumers workflow-owned. Edit their canonical source unless the repository explicitly requires otherwise.
- Keep edits surgical. Synchronize required mirrors and metadata, validate frontmatter and YAML, then run trigger smoke tests for intended and excluded prompts.

Done means ownership is unambiguous, triggers cover intended cases without obvious over-triggering, consumers and mirrors agree, and validation passes or blocked checks are reported.

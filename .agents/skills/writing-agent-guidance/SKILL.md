---
name: writing-agent-guidance
description: Create, edit, review, audit, or reorganize agent-facing guidance with clear ownership, reliable triggers, and low context cost. Use for AGENTS.md, CLAUDE.md, GEMINI.md, SKILL.md, skill metadata, agent memory, knowledge, plans, instruction pointers, generated guidance blocks, or recurring agent failures that suggest guidance needs tuning.
---

## Writing Agent Guidance

Inspect scoped instructions, consumers, generators, mirrors, executable sources, and available task history before editing. Preserve higher-priority and narrower rules.

### Assign Ownership

- Put always-needed repository constraints and non-obvious commands in `AGENTS.md` or its canonical equivalent.
- Put repeatable task procedures in skills with precise trigger descriptions.
- Put verified domain facts, invariants, architecture decisions, glossaries, and affected-surface maps in knowledge.
- Put task execution state, open decisions, risks, and checks in plans.
- Keep formatter, linter, schema, test, configuration, and discoverable environment facts in their executable source unless lookup is unusually costly or a hidden constraint needs explanation.

An agent guide explains how to change the repository; a README explains the project to humans. Add project identity, non-negotiables, terminology, and supported surfaces only when they change agent decisions. Do not duplicate README content or facts cheaply discovered from executable sources.

Keep one authoritative source for each durable rule. Point to it elsewhere with a concise statement of why and when to read it.

### Learn From Real Work

1. Inspect available histories, user corrections, failed tasks, and repeated follow-up prompts. Group recurring failures by workflow, model, or harness only when evidence supports the distinction.
2. For surprising decisions, determine what instruction or context caused the path. For unexpectedly long tasks, categorize tool calls and identify useful versus wasted work.
3. Encode only repeated or costly failure modes. Prefer one narrow rule over a broad defensive checklist.
4. Add a concise good/bad example when observed output shows that abstract wording is insufficient.
5. Exercise the change in realistic tasks. Keep, revise, move, or remove it based on correction rate, scope drift, wasted work, verification completion, and output clarity.

### Write for Reliable Behavior

- Write skill descriptions as one concise capability statement plus distinct trigger branches. Put every invocation condition in the description, not the body.
- Split a skill when independent user intents need different triggers or are commonly requested separately.
- Use imperative, positive, outcome-linked instructions. Use prohibitions only for costly failure modes and pair them with the target behavior.
- Give ordered steps explicit completion criteria. Keep reference material beside the concept it qualifies or behind a direct conditional pointer.
- Prefer established technical terms over invented vocabulary. Repeat a compact term when it anchors behavior; do not repeat its full meaning.
- Keep guidance vendor-neutral unless the task targets one harness.

### Prune and Verify

- Remove no-ops, duplicated meaning, task-specific skill leakage, tool-enforced lint rules, blind references, stale initialization text, and conflicting instructions.
- Keep generated consumers workflow-owned. Edit their canonical source unless the repository explicitly requires otherwise.
- Keep edits surgical. Synchronize required mirrors and metadata, validate frontmatter and YAML, then test intended and excluded trigger prompts.

Done means ownership is unambiguous, triggers cover intended cases without obvious over-triggering, distribution artifacts agree, and validation passes or blocked checks are reported.

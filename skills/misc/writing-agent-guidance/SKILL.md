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

Verify each addition earns its context cost: unverified, generated, or overly detailed guidance measurably lowers task success and raises inference cost, and agents follow named tools or commands rigidly even when the guidance is wrong. Keep only terse, human-verified, non-inferable facts.

Keep one authoritative source for each durable rule. Point to it elsewhere with a concise statement of why and when to read it.

### Learn From Real Work

1. Inspect available histories, user corrections, failed tasks, and repeated follow-up prompts. Group recurring failures by workflow, model, or harness only when evidence supports the distinction.
2. For surprising decisions, determine what instruction or context caused the path. For unexpectedly long tasks, categorize tool calls and identify useful versus wasted work.
3. Encode only repeated or costly failure modes. Prefer one narrow rule over a broad defensive checklist.
4. Add a concise good/bad example when observed output shows that abstract wording is insufficient.
5. Exercise the change with a separate, fresh agent instance on realistic tasks, not the session that authored it. Observe where it struggles, succeeds, or diverges, then keep, revise, move, or remove the change based on correction rate, scope drift, wasted work, verification completion, and output clarity.

### Write for Reliable Behavior

- Write skill descriptions as one concise capability statement plus distinct trigger branches. Put every invocation condition in the description, not the body.
- Split a skill when independent user intents need different triggers or are commonly requested separately. Merge two that serve one intent, cross-reference constantly, and restate each other's rules. Prefer extending or merging over adding; a new skill earns its place only when a rule has no owner and an agent would otherwise invent it.
- Use imperative, positive, outcome-linked instructions. Use prohibitions only for costly failure modes and pair them with the target behavior.
- Give ordered steps explicit completion criteria. Keep reference material beside the concept it qualifies or behind a direct conditional pointer.
- Do not close a skill with a checklist that restates its body. State a verification action once, in the prose that owns it. A checklist earns its place only as a progress tracker for a long sequential workflow, or as a validation loop with an explicit gate; a trailing summary is duplication that drifts from the rules it copies.
- Prefer established technical terms over invented vocabulary. Repeat a compact term when it anchors behavior; do not repeat its full meaning.
- Keep guidance vendor-neutral unless the task targets one harness.
- Match instruction specificity to task fragility: low freedom (exact steps, no deviation) for fragile, destructive, or fixed-sequence operations; high freedom (heuristics) for open-ended judgment calls; medium freedom (templates, parameterized scripts) when a preferred pattern tolerates variation.
- Keep a guide's primary file under roughly 500 lines; split overflow into files it links directly, one level deep. Nested references get partially read and lose content.

### Prune and Verify

- Remove no-ops, duplicated meaning, task-specific skill leakage, tool-enforced lint rules, blind references, stale initialization text, and conflicting instructions.
- Keep generated consumers workflow-owned. Edit their canonical source unless the repository explicitly requires otherwise.
- Keep edits surgical. Synchronize required mirrors and metadata, validate frontmatter and YAML, then test intended and excluded trigger prompts.

Done means ownership is unambiguous, triggers cover intended cases without obvious over-triggering, distribution artifacts agree, and validation passes or blocked checks are reported.

---
name: engineering
description: Apply repository engineering standards to non-trivial implementation, bug fixes, refactors, reviews, schema or config changes, and technical planning, especially across several files or layers. Skip simple renames, copy edits, and isolated mechanical changes.
---

## Engineering Principles

### Priority

1. Correctness and security
2. Explicit task and specification requirements
3. Local consistency
4. Simplicity
5. Brevity

Write code for humans and tools: clear names, cohesive files, reasonable module boundaries, explicit interfaces, and separable implementations. Do not use docs to compensate for confusing code.

### Before Coding

- Inspect relevant code and think before coding.
- State material assumptions, tradeoffs, and uncertainty.
- For unclear plans, designs, or instructions, explore the code first and state plausible interpretations without choosing silently.
- Ask only the smallest set of decision-blocking questions, one concise question at a time when practical; use selectable options when useful.
- Always push back on technically weak libraries, patterns, or instructions; explain concrete flaws and propose a better fit.
- For bug fixes, reproduce the failure then add a focused regression test when practical.
- Before changing a shared contract, find and account for all consumers.

### Design

- Start with the simplest working local pattern. Handle realistic failures: invalid input, partial failures, timeouts, concurrency, and external-system errors.
- Preserve trust boundaries. Validate untrusted input at boundaries; do not leak secrets, weaken authorization, or broaden permissions.
- Prefer existing dependencies and platform capabilities. Add runtime dependencies only when they materially simplify or strengthen the solution; justify them.
- Treat schema and persistent-data changes as compatibility changes: consider existing data, rollout, rollback, and mixed-version operation.
- Understand why code exists before removing it. Preserve behavior and interfaces unless the task or approved plan changes them.
- Follow YAGNI: add no speculative feature, abstraction, configuration, or docs that merely paraphrase code. Use one-liners only when clearer.
- Within the edit surface, remove code smells: duplicated knowledge, misleading names, excessive nesting, hidden side effects, and complex control flow.
- Apply DRY, SOLID, and design patterns as tools, not goals; keep responsibilities and dependencies clear, and keep behavior testable.
- Optimize only measured or demonstrated bottlenecks; preserve correctness and clarity.
- Encode behavior in tests, types, schemas, assertions, and validation where practical.

### Scope

- Match local style.
- Keep edits surgical; every changed line must trace to the request.
- If no code change is needed, report evidence.
- Clean only code and artifacts made unused by your change.
- Mention unrelated dead code, code smells, documentation drift, and risks; do not fix them unless asked.

### Execution

- For multi-step work, give a brief plan and explicit success checks.
- Run the narrowest relevant verification first; broaden only as risk warrants.
- Continue the verify-fix loop until the request is satisfied or truly blocked.
- Never claim a check passed unless it ran; report passed, failed, and skipped checks explicitly.
- Assume every change will be rigorously reviewed by a senior engineer.
- Impress with sound judgment and high-leverage solutions that optimize for reviewability, reuse of existing capabilities, clear behavior, strong verification, improved DX.

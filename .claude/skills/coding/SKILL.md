---
name: coding
description: Apply hands-on code craft standards while writing, editing, refactoring, or reviewing code: control flow, functions, naming, state, error handling, concurrency, code smells, tests, and code-level security. Use whenever lines of code change. Skip planning-only requests, diagnosis-only requests, prose edits, and pure configuration or data changes.
---

## Coding

`engineering` decides what to build and how far the change reaches; this decides what the lines look like. Match local style first; explicit task requirements and narrower scoped instructions override these defaults.

### Functions and Flow

- Flatten conditionals with guard clauses: return early, fail fast, drop `else` after a returning `if`, and state conditions positively.
- Keep each function and loop body doing one thing at one level of abstraction, small enough to read whole.
- Keep parameter lists short; more than three usually means a missing type, and a boolean flag means two functions.
- Separate command from query, advertise side effects in the name, keep functions pure by default, and push I/O to the edges.
- Name every meaningful constant; no magic numbers.

### Naming

- Names reveal intent and scale with scope: `i` in a tight loop, `retryBackoffMs` in a module. Booleans read as predicates; abbreviations a new reader must decode do not belong.
- Code states what, comments state why. Explain rationale, constraints, or non-obvious behavior, and never use a comment to compensate for confusing code.
- A name that resists writing signals a design problem; fix the design rather than the name.

### Data and State

- Prefer immutable values, the narrowest workable scope, and no global mutable state.
- Make illegal states unrepresentable. Parse, do not validate: convert untrusted input into a safe type once at the boundary, then trust it inside.
- Do not lie to the type system: no `any`, unchecked cast, non-null assertion, or suppression comment standing in for real uncertainty.
- Distinguish absent, empty, and zero, and respect each domain: exact decimals for money, explicit instants and zones for time, locale-aware comparison for user text, range checks where overflow is possible.
- Keep one source of truth; derive values rather than duplicating them.

### Errors

- Treat errors as values: handle or propagate, never ignore, and never leave an empty `catch`.
- Preserve the original cause when wrapping; crash loudly in development and degrade gracefully in production.
- Release resources with `finally`, `defer`, RAII, or the local equivalent rather than by remembering.

### Concurrency

- Do not share mutable state across threads or tasks; pass ownership or a copy, or guard it with a lock.
- Acquire locks in one consistent order, and never hold one across I/O, an `await`, or a callback.
- Await or explicitly handle every async call, and propagate and honor cancellation through every layer that can block.
- Keep blocking work off the event loop or request thread, and synchronize on real signals rather than sleeps.

### Structure

- Prefer composition over inheritance, and depend on abstractions rather than implementations.
- Apply DRY, SOLID, and design patterns as tools, not goals; use them only when they reduce duplicated knowledge or clarify responsibilities, dependencies, or testability.
- Keep cohesion high and coupling low, and separate policy from mechanism.
- Keep internals internal: expose behavior, and return a copy or read-only view rather than a live collection.
- Make the change easy, then make the easy change.

### Smells

Treat each as a labelled heuristic, not a violation. Documented repository standards override them, and anything a linter enforces is not worth relitigating. Fix what sits inside your edit surface and mention the rest.

- Naming and modelling: Mysterious Name (rename it, or admit the design is unclear), Primitive Obsession (give the concept its own type), Data Clumps (bundle fields that travel together), Speculative Generality (delete abstraction the task does not need).
- Placement: Duplicated Code (extract once the third repetition fires), Feature Envy (move the method onto the data it uses), Repeated Switches (replace a recurring cascade with polymorphism or one shared map).
- Module shape: Shotgun Surgery (one change scattered across many files; gather it), Divergent Change (one module edited for unrelated reasons; split it).
- Indirection: Message Chains (hide the walk behind one method), Middle Man (cut what only delegates), Refused Bequest (drop inheritance the subclass ignores in favor of composition).

### Restraint

- Follow YAGNI: add no speculative feature, abstraction, configuration, or docs that merely paraphrase code, and wait for the third repetition before abstracting.
- Choose the simplest thing that works, on boring technology.
- Delete code your change makes dead, along with debug output, commented-out code, and scratch scaffolding.
- Optimize only measured bottlenecks, but treat unbounded and N+1 work as a defect: paginate queries, cap fan-out and retries, and keep queries out of per-row loops.

### Testing

- Test observable behavior at the seam rather than implementation detail, one logical assertion per test.
- Work red, green, refactor; a bug fix starts with a failing test.
- Keep tests fast, isolated, and deterministic: no sleeps, no shared state, no network.
- Cover realistic negative and edge cases for changed behavior; for behavior-preserving refactors, strengthen coverage when risk warrants.
- Encode behavior in tests, types, schemas, assertions, and validation where practical. Do not mock what you do not own; wrap it and substitute the wrapper.

### Security

- Treat every caller outside your boundary as untrusted, including internal services and your own team's code; enforce validation server-side, since client checks are UX.
- Parameterize queries and commands, and encode on output for the target context.
- Never roll your own crypto; read secrets from the environment or a secret manager and never commit them.
- Fail closed and grant least privilege.

Make it work, make it right, make it fast, in that order, and optimize for the reader: code is read far more often than written, debugging is harder than writing, and surprising code costs the most. Several of these rules conflict on purpose, DRY against YAGNI, strict validation against trusted boundaries, and abstraction against simplicity; they are heuristics with a domain of applicability, so when two collide, resolve with the priority order in `engineering`.

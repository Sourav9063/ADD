---
name: coding
description: Apply hands-on code craft standards while writing, editing, refactoring, or reviewing code: control flow, functions, naming, state, error handling, concurrency, code smells, tests, and code-level security. Use whenever lines of code change. Skip planning-only requests, diagnosis-only requests, prose edits, and pure configuration or data changes.
---

## Coding

`engineering` decides what to build and how far the change reaches; this decides what the lines look like. Local style, explicit task requirements, and narrower scoped instructions override these defaults.

### Control Flow

- Flatten nested conditionals with guard clauses; return early and fail fast.
- Drop `else` after an `if` that returns.
- State conditions positively; `if (!notReady)` makes the reader translate.
- Keep a loop body doing one thing; extract it once it grows.
- Name meaningful constants; no magic numbers.

### Functions

- Do one thing, at one level of abstraction.
- Keep a function small enough to read whole on one screen.
- More than three parameters usually means a missing object.
- No boolean flag parameters; that is two functions.
- Separate command from query: change something or answer something, not both.
- Advertise side effects in the name, or remove them.
- Keep functions pure by default; push I/O to the edges.

### Naming

- Names reveal intent. Code says what, comments say why.
- Do not use comments to compensate for confusing code; explain rationale, constraints, or non-obvious behavior instead of restating clear code.
- Scale name length to scope: `i` in a tight loop, `retryBackoffMs` in a module.
- No abbreviation a new reader has to decode.
- Booleans read as predicates: `isValid`, `hasAccess`.
- Hard to name means the design is wrong; fix the design, not the name.

### Data and State

- Prefer immutable values; mutate as late as possible.
- Give every variable the narrowest scope that works.
- No global mutable state.
- Make illegal states unrepresentable; prefer types over runtime checks.
- Parse, do not validate: convert unsafe input into a safe type once at the boundary, then trust it inside.
- Do not lie to the type system. No `any`, unchecked cast, non-null assertion, or suppression comment to silence a real uncertainty; narrow it or model it.
- Distinguish absent, empty, and zero; do not collapse them into one falsy check.
- Respect the domain of each type: exact decimals for money, explicit instants and time zones for time, locale-aware comparison for user text, range checks where overflow is possible.
- Keep one source of truth; derive values instead of duplicating them.

### Errors

- Treat errors as values: handle or propagate, never ignore.
- An empty `catch` is a deferred bug; swallow nothing silently.
- Preserve the original cause when wrapping an error.
- Crash loudly in development, degrade gracefully in production.
- Release resources in `finally`, `defer`, RAII, or the local equivalent, not by remembering.

### Concurrency

- Do not share mutable state across threads or tasks; pass ownership or a copy, or guard it with a lock.
- Acquire locks in one consistent order, and never hold one across I/O, an `await`, or a callback.
- Await or explicitly handle every async call; a floating promise is an unobserved failure.
- Propagate cancellation through every layer that can block, and honor it.
- Keep blocking work off the event loop or request thread.
- Never synchronize with sleeps; wait on the actual signal.

### Structure

- Prefer composition over inheritance.
- Program to an interface, not an implementation; depend on abstractions.
- Apply DRY, SOLID, and design patterns as tools, not goals; use them only when they reduce duplicated knowledge or clarify responsibilities, dependencies, or testability.
- Keep cohesion high and coupling low; separate policy from mechanism.
- Keep internals internal; expose behavior, not mutable state. Return a copy or a read-only view instead of handing out a live collection.
- Make the change easy, then make the easy change.

### Smells

Each entry is a heuristic, not a violation: name it, then decide. Documented repo standards override this list, and anything a linter or formatter already enforces is not worth relitigating. Fix a smell that sits inside your edit surface; elsewhere, mention it and leave it.

- **Mysterious Name**: a function, variable, or type whose name does not reveal what it does or holds. Rename it; if no honest name comes, the design is murky.
- **Duplicated Code**: the same logic shape repeated, once the third repetition has fired. Extract the shape and call it from every site.
- **Feature Envy**: a method that reaches into another object's data more than its own. Move the method onto the data it envies.
- **Data Clumps**: the same few fields or parameters keep travelling together. Bundle them into one type and pass that.
- **Primitive Obsession**: a string or number standing in for a domain concept. Give the concept its own small type.
- **Repeated Switches**: the same `switch` or `if` cascade on the same type recurs. Replace it with polymorphism, or one map both sites share.
- **Shotgun Surgery**: one logical change forces scattered edits across many files. Gather what changes together into one module.
- **Divergent Change**: one module gets edited for several unrelated reasons. Split it so each module changes for one reason.
- **Speculative Generality**: abstraction, parameters, or hooks added for needs the task does not have. Delete it; inline back until a real need shows.
- **Message Chains**: long `a.b().c().d()` navigation the caller should not depend on. Hide the walk behind one method on the first object (Law of Demeter).
- **Middle Man**: a class or function that mostly delegates onward. Cut it and call the real target directly.
- **Refused Bequest**: a subclass that ignores or overrides most of what it inherits. Drop the inheritance and use composition.

### Restraint

- Follow YAGNI: add no speculative feature, abstraction, configuration, or docs that merely paraphrase code. Use one-liners only when clearer.
- Choose the simplest thing that works, on boring technology.
- Wait for the third repetition before abstracting; premature abstraction costs more than duplication.
- Delete code your change makes dead; dead code is a liability. Remove debug output, commented-out code, and scratch scaffolding before you finish.
- Optimize only measured or demonstrated bottlenecks; preserve correctness and clarity.
- Bound every unit of work: paginate queries, cap fan-out and retries, keep queries out of per-row loops. Unbounded and N+1 work is a defect, not an optimization to defer.

### Testing

- Test observable behavior, not implementation detail.
- Work red, green, refactor. A bug fix starts with a failing test.
- One logical assertion per test.
- Keep tests fast, isolated, and deterministic: no sleeps, no shared state, no network.
- For changed behavior, cover realistic negative and edge cases at the observable seam. For behavior-preserving refactors, strengthen coverage when risk warrants.
- Do not mock what you do not own; wrap it and substitute the wrapper.
- Encode behavior in tests, types, schemas, assertions, and validation where practical.

### Code-Level Security

- Validate untrusted input server-side; client checks are UX, not enforcement.
- Treat every caller outside your boundary as untrusted, including internal services and your own team's code.
- Parameterize queries and commands; never concatenate untrusted text into them.
- Encode on output for the target context; validate on input.
- Never roll your own crypto.
- Read secrets from the environment or a secret manager; never commit them.
- Fail closed, and grant least privilege.

### Judgment

- Follow Postel's Law: liberal in what you accept, conservative in what you send.
- Follow the Principle of Least Astonishment; surprising code is expensive code.
- Make it work, make it right, make it fast, in that order.
- Optimize for the reader; code is read far more often than written.
- Debugging is harder than writing, so write code simpler than the limit of your cleverness.

Several of these conflict on purpose: DRY fights YAGNI, validating everything fights trusting your boundaries, and abstraction layers fight simplicity. They are heuristics with a domain of applicability, not rules. The skill is knowing which one the situation is asking for; when two collide, resolve with the priority order in `engineering`.

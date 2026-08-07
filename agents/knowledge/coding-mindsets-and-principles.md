# Coding Mindsets and Principles

[AGENTS.md](../../AGENTS.md) owns operational rules. This reference explains the judgment behind them; principles are heuristics, not commandments.

## Core Mindsets

- **Evidence over assumption:** inspect before deciding, reproduce failures, measure bottlenecks, and verify outcomes.
- **Correctness before cleverness:** prefer obvious, dependable behavior over novelty or compressed code.
- **Small feedback loops:** make the smallest coherent change, validate it, then extend.
- **Context over dogma:** patterns and principles serve the problem; trade-offs decide their use.
- **Failure awareness:** handle realistic invalid input, partial failure, timeouts, concurrency, and external-system errors.
- **Stewardship:** preserve existing intent and interfaces unless the approved change requires otherwise.

## Daily Coding Principles

- **Occam's Razor / KISS:** choose the simplest solution that fully satisfies known requirements; simple does not mean incomplete.
- **YAGNI:** add no feature, abstraction, configuration, or flexibility without a current requirement.
- **Gall's Law:** grow complex systems from a small working system with verified behavior.
- **Chesterton's Fence:** understand why code, validation, or constraints exist before removing them.
- **Murphy's Law:** assume realistic failures will occur; make failure behavior explicit and test important cases.
- **Law of the Instrument:** choose tools and patterns for the problem, not familiarity or fashion.
- **DRY:** remove duplicated knowledge, not merely similar syntax; wait for a stable abstraction boundary.
- **SOLID:** use responsibility and dependency principles when they improve clarity and testability, not to maximize abstractions.
- **High cohesion, low coupling:** keep related behavior together, separate independent responsibilities, and minimize dependency surface.
- **Principle of Least Surprise:** make names, APIs, defaults, errors, and side effects predictable from local context.
- **Behavior-first testing:** test observable behavior and contracts; use implementation-level tests only when they improve diagnosis or isolate risk.
- **Evidence-led optimization:** optimize measured bottlenecks; never trade correctness or clarity for speculative performance.

## Prioritization And Stopping

- **Pareto Principle:** focus effort on the code and failures with the greatest demonstrated impact; do not use it to excuse correctness gaps.
- **Law of Diminishing Returns:** stop refactoring, optimizing, or testing when further work adds less value than its cost and residual risk is acceptable.
- **Goodhart's Law:** treat coverage, complexity, velocity, and similar metrics as signals, never targets that replace engineering judgment.

## Broader Context

Brooks's Law, Conway's Law, Hofstadter's Law, Parkinson's Law, and related ideas help with organization, architecture, staffing, and estimation. They provide context for engineering decisions but rarely translate into universal line-by-line coding rules.

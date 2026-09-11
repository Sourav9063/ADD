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

## Literature and Design Judgment

`coding` owns extraction guidance inspired by Robert C. Martin's *Clean Code*, chapters 2, 3, 6, and 17 ([contents](https://www.informit.com/store/clean-code-a-handbook-of-agile-software-craftsmanship-9780132350884)). His [companion example](https://www.informit.com/articles/article.aspx?p=1313447) preserves caller intent while sharing implementation. Literal extraction can remove repetition without correcting responsibility; this distinction motivates the guidance.

Complementary sources behind `coding`'s literature cue:

- Martin Fowler, [Refactoring](https://martinfowler.com/books/refactoring.html): behavior-preserving transformations, including extraction and its inverse, inlining.
- John Ousterhout, [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/aposd.php): information hiding and deep modules; assess complexity removed from callers relative to interface cost.
- Sandi Metz, [The Wrong Abstraction](https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction): recover from shared code distorted by caller-specific branches; preserving an existing abstraction is not inherently valuable.
- Michael Feathers, [Working Effectively with Legacy Code](https://www.informit.com/articles/article.aspx?p=359417) and [Characterization Testing](https://michaelfeathers.silvrback.com/characterization-testing): seams and tests for safely changing unfamiliar code; observed behavior does not establish intended correctness.

These sources supply judgment, not additional checklists. The skill retains local constraints and observed-failure corrections; literature references neither replace those rules nor require rereading the books for each task.

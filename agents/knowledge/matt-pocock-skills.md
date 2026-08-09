# Matt Pocock Skills

Reference map for `mattpocock/skills`. Stable skills are grouped by engineering and productivity; misc skills are rarely used; in-progress skills are beta and may change.

Source: <https://github.com/mattpocock/skills>

## Engineering

- `ask-matt`: choose the right skill or workflow.
- `code-review`: review a diff against standards and spec.
- `codebase-design`: design deep modules with small interfaces.
- `diagnosing-bugs`: debug from reproduction through regression test.
- `domain-modeling`: build and refine domain language and model.
- `grill-with-docs`: interview the user while updating domain docs and ADRs.
- `implement`: build specs or tickets with TDD and code review.
- `improve-codebase-architecture`: scan a codebase for architecture improvements.
- `prototype`: build a throwaway prototype to answer design questions.
- `research`: research primary sources and save cited findings.
- `resolving-merge-conflicts`: resolve merge or rebase conflicts by intent.
- `setup-matt-pocock-skills`: configure tracker, labels, and documentation layout.
- `tdd`: build features with red-green-refactor.
- `to-spec`: turn a conversation into a published spec.
- `to-tickets`: split a plan or spec into tickets with blocking edges.
- `triage`: move issues through triage states.
- `wayfinder`: plan large work as decision tickets.
- `wizard`: create interactive shell wizards for human-only setup steps.

## Productivity

- `grill-me`: interview the user until a plan or design is clear.
- `handoff`: create a compact handoff document for another agent.
- `teach`: teach a skill or concept across sessions.
- `to-questionnaire`: create a questionnaire for unresolved decisions.
- `wait-what`: re-explain unclear messages in plain language.
- `grilling`: reusable interview process for resolving decisions.
- `writing-for-agents`: write skills and agent-facing documents.

## Misc

- `git-guardrails-claude-code`: block dangerous Git commands with hooks.
- `migrate-to-shoehorn`: replace test-file TypeScript assertions with `shoehorn`.
- `scaffold-exercises`: create exercise folders with problems and solutions.
- `setup-pre-commit`: configure Husky, lint-staged, formatting, type checks, and tests.

## In progress

- `loop-me`: turn self-interviews into workflow specs across sessions.
- `writing-beats`: shape an article through step-by-step beats.
- `writing-fragments`: collect raw writing fragments for later use.
- `writing-shape`: turn Markdown raw material into an article.
- `claude-handoff`: hand work to a background Claude agent.
- `setup-ts-deep-modules`: enforce deep module boundaries in TypeScript.

## Wording characteristics

- Uses canonical engineering terms as compact behavior handles: `code smell`, `seam`, `spec`, `tracer bullet`, `design tree`, and `frontier`.
- Prefers known technical vocabulary over long explanations; define new terms before reusing them.
- Uses named patterns and anti-patterns as shared labels, then gives a concrete meaning and remedy.
- Repeats key terms across descriptions, steps, and reports to keep agent behavior consistent.
- Uses technical metaphors when they compress a workflow: `ball of mud`, `flying blind`, and `red-green-refactor`.
- Treats terminology as an invocation aid: wording helps the agent recognize when a skill applies.
- Keeps terms precise and action-linked; avoids jargon that does not change behavior.
- Uses imperative voice: tells the agent what to do, not what the skill is.
- Keeps descriptions short: one sentence with one clear purpose.
- Makes triggers explicit: says when the skill should activate.
- Focuses on outcomes: defines observable results or completion criteria.
- Uses positive instructions: states target behavior and limits negative wording.
- Adds hard guardrails only where failure is costly.
- Uses progressive disclosure: keeps the main skill short and links detailed references.
- Preserves human control: separates user-invoked orchestration from model-invoked discipline.
- Stays direct but personable, with occasional humor such as `Bam`, `ball of mud`, and `flying blind`.
- Removes token waste: filler, duplicated meaning, and obvious instructions.

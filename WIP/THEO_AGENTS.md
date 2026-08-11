# Theo-Inspired Agent Guidance Proposal

Status: proposed

## Source

- Video: [I made Claude smarter by writing it a letter](https://www.youtube.com/watch?v=e1snsuY4lTI&t)
- Input: [auto-generated English subtitles](./I%20made%20Claude%20smarter%20by%20writing%20it%20a%20letter%20%5BEnglish%20%28auto-generated%29%5D%20%5BDownloadYoutubeSubtitles.com%5D.txt)

This proposal summarizes the improvements Theo described. It does not reproduce his private instructions. The transcript is auto-generated, so product names and quotations are normalized or paraphrased where needed.

## Core Proposal

Treat agent guidance as an evolving communication interface, not a static rule dump. Build it from observed failures, personal preferences, repository constraints, and real task results. Optimize agents not only to write better code, but to understand intent and communicate useful context with less prompting.

Do not copy another person's complete `AGENTS.md`, `CLAUDE.md`, or skill catalog. Adopt the process: observe failures, encode targeted corrections, test them in real work, and keep only guidance that improves outcomes.

## Improvements Described in the Video

### 1. Write global guidance as a letter

Introduce the user, working relationship, values, and preferred way of thinking in natural prose. Models mirror tone, so the writing style itself can improve alignment and response style.

Include durable personal defaults such as:

- Prefer simple systems and reduced complexity.
- Use type safety where it provides value.
- Propose bold ideas when the benefit is meaningful.
- Treat unrequested destructive actions cautiously.
- Prefer focused tests over indiscriminate test expansion.
- Use comments to explain how code is used; keep them current.

These are defaults, not absolute rules. Explicit user requests and repository-specific instructions take priority.

### 2. Separate global and repository guidance

Global guidance should contain stable personal preferences that apply across work. Repository guidance should explain how an agent safely and effectively changes that specific codebase.

An agent file should not duplicate the README. A README helps people understand or adopt a project. An agent file should provide the operational context needed to modify it: architecture, invariants, commands, risks, terminology, affected surfaces, and verification expectations.

### 3. Record project identity and non-negotiables

Give the agent a concise model of:

- What the product is and how its major parts interact.
- What makes it valuable or distinctive.
- Which properties changes must not compromise.
- Who uses it and how severe regressions would be.

This reduces discovery work and gives the agent criteria for rejecting locally plausible changes that violate product intent. Theo's examples included openness, performance, remote operation, and support across web, desktop, and mobile surfaces.

### 4. Add a shared glossary

Define overloaded project terms such as `you`, `we`, `user`, `agent`, `provider`, `client`, `environment`, and `project`.

The glossary is not only for agent comprehension. It teaches the agent how maintainers describe the system, producing explanations and proposals that match the team's mental model.

### 5. Convert recurring failures into narrow rules

Audit actual agent histories instead of relying only on memory. Group corrections and failures by model or harness, count recurring patterns, and turn repeated problems into specific guidance.

Examples from the video:

- Killing the wrong development process.
- Touching user data unnecessarily.
- Starting draft pull requests by default.
- Running expensive repository-wide checks without need.
- Misusing shell tools.
- Overbuilding a small request.
- Editing files the user did not ask to change.
- Stopping before verification or completion.
- Missing regressions or reverse operations.

When a task goes poorly, ask the agent why it chose that path and which context influenced it. When work takes much longer than expected, ask it to categorize its tool calls and identify useful versus wasted activity. Update guidance only when the evidence reveals a reusable failure mode.

### 6. Make questions read-only by default

A question about a repository should authorize inspection and explanation, not implementation. Agents should edit only when the user asks for a change or the request clearly includes implementation.

This prevents eager models from turning diagnosis, status, or design questions into unrequested mutations.

### 7. Match process overhead to the task

Do not spawn subagents or a multi-agent panel for work one agent can finish in one pass. Use delegation for breadth, independent parallel work, or adversarial review. When several agents edit concurrently, assign file ownership before work begins to prevent collisions.

Give eager agents an explicit stopping point when intermediate review matters, for example: make the edits, but do not commit, push, deploy, or synchronize them yet.

### 8. Audit every affected surface

Replace vague reminders with repository-specific completion checklists. For a cross-cutting feature, explicitly decide whether each relevant surface applies:

- Entry points such as settings, command palette, shortcuts, and contextual actions.
- Web, desktop, mobile, and other clients.
- Shared logic and runtime packages.
- Every provider or adapter, including an explicit `not supported` decision.
- Schemas and contracts crossing process or network boundaries.
- Reverse operations such as enable/disable, settle/unsettle, or snooze/unsnooze.
- Connection modes and remote workflows.
- User-facing and maintainer-facing documentation.

The goal is not to change every surface. It is to make every applicable surface an explicit decision.

### 9. Protect the active development environment

Document repository-specific commands and hazards that generic model knowledge will miss. Where applicable:

- Use isolated state or home directories for development instances.
- Preserve the process identifier for anything the agent starts.
- Stop only the process the agent owns.
- Return the complete usable URL, including required pairing or authentication data.
- Define safe test data.
- Avoid interfering with the application instance hosting the agent itself.
- Use targeted verification first and a real-client pass for user-visible work when requested.

### 10. Encode architectural taste at the right boundary

Short, concrete statements can steer implementation structure better than generic design doctrine. Theo's examples included keeping complexity at adapter boundaries, keeping orchestration pure, keeping UI components simple, preferring inferred types, avoiding unsafe types, and preventing continuous animations that waste GPU resources.

Security and architecture should remain proportional to the actual threat model and task. Avoid production-grade machinery for maintainer-only local development when it adds complexity without realistic protection.

### 11. Use skills for recurring workflows

Move specialized procedures out of always-loaded guidance and into skills. Theo highlighted separate skills for filing a pull request and babysitting one because they have different triggers and are often requested independently.

Write skill descriptions primarily as trigger conditions. Include the words users naturally say when they want the workflow. Keep detailed behavior inside the skill. Split overloaded skills when distinct user intents can trigger them independently.

Prefer less context once the skill contains enough information to act correctly.

### 12. Improve pull request filing

A pull request skill should:

- Check whether the branch already has a pull request.
- Review the local diff against the intended base before filing.
- Follow repository title conventions and inspect recent merged examples.
- Use a concise title that explains why the change matters or what outcome it creates.
- Open the description with the user's problem, then explain the solution.
- Avoid leading with an inventory of implementation details.
- Open a reviewable pull request rather than a draft when review automation depends on it.
- Identify agent-authored communication where appropriate.

Good and bad examples are high-leverage. Add a small example when an agent repeatedly produces technically accurate but unhelpful titles or descriptions.

### 13. Improve pull request monitoring

A pull request monitoring skill should:

- Watch current checks, reviews, and relevant changes to the base branch.
- Act only on comments and checks newer than the latest push.
- Verify automated review findings against source before changing code.
- Distinguish code failures from infrastructure failures.
- Explain and resolve false positives instead of silently ignoring them.
- Rebase or update when needed.
- Stop and report if another change makes the pull request obsolete.
- Ask before closing unless closure was authorized.
- Continue until required checks and approvals are complete.
- Prevent review feedback from expanding the pull request beyond its original goal.

Screenshots, recordings, or other artifacts should be attached when they make review easier.

### 14. Optimize agent-to-human communication

Give agents tools and formats that make results easy for humans to inspect. Theo used file upload and self-contained HTML communication skills for plans, reports, comparisons, findings, and UI mockups.

Useful patterns include:

- Produce one readable artifact instead of terminal-shaped prose when requested.
- Label alternatives `A`, `B`, and `C` for quick selection.
- Keep one artifact stable across iterations.
- Upload screenshots or recordings and return accessible links.
- Separate reading an existing artifact from creating one when the triggers differ.

The objective is clearer collaboration, not more elaborate output.

### 15. Centralize and scope reusable guidance

Store global instructions and skills in one managed repository, then synchronize them across machines. Use explicit scope metadata so universal, tool-specific, and machine-specific skills are installed only where they apply.

Avoid building unnecessary configuration machinery. A small repository of Markdown, skills, and synchronization instructions may be sufficient.

## Proposed Adoption for ADD

### Adopt now

1. Add a durable rule that questions are read-only unless change authorization is explicit.
2. Strengthen guidance that agent files serve agents and must not duplicate README content.
3. Add glossary guidance for repositories with overloaded domain terms.
4. Require explicit affected-surface decisions for cross-cutting changes.
5. Treat skill descriptions as concise trigger conditions, with procedures kept in the skill body.
6. Add good and bad examples only for demonstrated recurring failures.
7. Preserve the existing rule against unnecessary delegation and add file ownership for approved parallel edits.
8. Audit real task histories before expanding always-loaded guidance.

### Implement as focused skills

1. Agent-guidance authoring and auditing.
2. Pull request filing.
3. Pull request monitoring.
4. Human-readable artifact communication when a repository has a supported publishing mechanism.

### Keep repository-specific

- Technology and package preferences.
- Exact development commands.
- Process, state-directory, URL, and test-data safety rules.
- Product invariants and supported surfaces.
- Architecture and performance constraints.
- Documentation audiences.
- Upload hosts, machine inventories, credentials, and fleet topology.

### Do not adopt blindly

- Theo's private personal preferences.
- T3 Code terminology or architecture.
- Every skill or tool shown in the video.
- Model-specific corrections without matching evidence in this repository.
- Large always-loaded files that duplicate skills or executable checks.

## Success Criteria

- Individual rules are concise, specific to observed failure modes, and retained in every required distribution artifact.
- Questions no longer cause unrequested edits.
- Cross-surface changes include explicit applicability decisions.
- Skill selection improves because descriptions match user trigger language.
- Pull request titles and descriptions explain the problem and outcome in plain language.
- Review feedback does not create scope creep.
- Agents interfere less with active development environments.
- Maintainers need fewer repeated corrections and shorter follow-up prompts.

## Validation Loop

1. Establish a baseline from recent task histories.
2. Add one narrowly targeted guidance change.
3. Exercise it in real tasks across relevant agents or harnesses.
4. Compare correction rate, wasted tool use, verification completion, scope drift, and output clarity.
5. Keep, revise, move into a skill, or remove the guidance based on results.
6. Repeat as new failure patterns emerge.

The durable lesson is not a specific `AGENTS.md`. It is the feedback loop: observe, explain, encode, test, and refine.

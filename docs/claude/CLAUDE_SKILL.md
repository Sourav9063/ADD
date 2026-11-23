# Claude Code Skills: Reusable Prompts and .NET Workflows

Anyone who uses Claude Code seriously ends up with a graveyard of prompts. A long block in a Notion page for scaffolding a new ASP.NET Core endpoint. A code snippet in the IDE for an EF Core migration. A pinned message somewhere with the project's response-shape conventions. Every project accretes its own little library of pasted instructions.

The problem isn't writing those prompts. It's keeping them in sync. The moment you refine one - tighten a FluentValidation rule, swap repository-pattern guidance for direct `DbContext`, add a `CancellationToken` note - you've forked it from every other copy you keep. Next time you reach for it, you grab a stale version and the scaffold comes out wrong. The fix is for the prompt to live in one place, version-controlled, invocable with a single command. That place is a **Skill**.

For .NET work, the skills I use day to day are the boring repeatable stuff: an endpoint scaffold, an EF Core migration helper, a Result-pattern handler, a container-publish tweak, a code-review pass. On the React side, component scaffolds and route refactors land in the same bucket. Once a workflow stabilizes enough that I keep pasting the same instructions, it becomes a skill.

This guide covers how to write your own - the SKILL.md format, arguments, dynamic context injection, subagent delegation, and the design patterns that took me a few rewrites to land on.

This article assumes you've used Claude Code before and have a working `CLAUDE.md` in your project. If not, the reads below close the gap.

> **Read next:** [New to Claude Code?](https://codewithmukesh.com/blog/claude-code-for-beginners/) - Learn installation, basic usage, and how Claude Code compares to GitHub Copilot and Cursor.

> **Read next:** [CLAUDE.md Deep Dive](https://codewithmukesh.com/blog/claude-md-mastery-dotnet/) - Write the perfect CLAUDE.md for .NET projects with production-ready templates and the WHAT-WHY-HOW framework.

> **Read next:** [.NET Developer Roadmap 2026](https://codewithmukesh.com/blog/dotnet-developer-roadmap/) - See where AI assisted development fits into the complete .NET learning path - from fundamentals to architecture.

## What Are Skills in Claude Code?

**A skill is a reusable Markdown file that Claude Code loads on demand as part of its prompt.** You write instructions in a `SKILL.md` file, give it a name, and invoke it with `/skill-name` - just like a built-in slash command. Claude reads the instructions and executes them.

A useful comparison: CLAUDE.md is the project's standing rules - the conventions every session loads automatically. A skill is a procedure you pull off the shelf only when the task calls for it. You don't make someone read your deploy runbook every day. You hand it to them when it's time to deploy.

The two play different roles:

| Aspect | CLAUDE.md / Rules | Skills |
| --- | --- | --- |
| Loaded | Every session, automatically | On demand - when invoked or when Claude detects relevance |
| Purpose | Persistent context: conventions, architecture, preferences | Task-specific playbooks: workflows, generators, automations |
| Scope | Everything Claude does in this project | A specific task or workflow |
| Invocation | Automatic (always in context) | `/skill-name` or automatic when description matches |
| Best for | "Always use 2-space indentation" | "Generate an ASP.NET Core endpoint with DTOs and tests" |

**Why not just put everything in CLAUDE.md?** Adherence, not just budget. Every token in CLAUDE.md loads into every single conversation. Stuff 5,000 words of endpoint scaffolding, EF Core migration playbooks, React component conventions, and deployment checklists in there and you're carrying roughly 6,500 tokens of instructions Claude doesn't need 90% of the time.

On the 1M-token windows current models ship with, that's no longer the budget crisis it was when 200K was standard. But the second problem never went away and matters more: **a long CLAUDE.md gets followed less reliably than a short one.** Anthropic's own guidance targets under 200 lines, because rules get buried under noise. Ten workflow templates in CLAUDE.md means ten sets of instructions competing for attention on every unrelated task.

Skills fix both. A skill's body loads only when it's used, so long reference material costs nothing until you need it - and the rules that matter every session stay uncrowded.

Skills follow the [Agent Skills open standard](https://agentskills.io/) - they're not a proprietary Claude Code feature. The same `SKILL.md` format works across multiple AI coding tools (Gemini CLI, Cursor, OpenAI Codex, GitHub Copilot, and many more), so your investment in writing good skills is portable. Per the [official Claude Code documentation](https://code.claude.com/docs/en/skills), Claude Code also merges custom slash commands into skills: a file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work the same way - the skills format adds optional features like supporting files, frontmatter for invocation control, and automatic loading.

### How Claude Discovers and Loads Skills

Claude Code's skill loading is a two-phase process:

1. **Discovery phase (every session):** Claude scans skill directories and loads all skill **descriptions** into context. This costs minimal tokens - just the frontmatter metadata, not the full skill content.
2. **Invocation phase (on demand):** When you type `/skill-name` or when Claude's analysis matches a skill's description, the **full SKILL.md content** loads into the conversation.

This means writing a clear, specific `description` in your frontmatter is critical - it's what Claude uses to decide whether to auto-invoke your skill.

## How Do You Create Your First Skill?

Let's build something practical. Say you frequently ask Claude to scaffold a new ASP.NET Core controller with a specific pattern - constructor injection, proper response types, XML comments. Instead of describing this every time, you'll create a skill.

### Step 1: Create the Skill Directory

Skills live in `.claude/skills/` inside your project (for project-specific skills) or `~/.claude/skills/` (for skills available across all projects).

```bash
mkdir -p .claude/skills/scaffold-controller
```

### Step 2: Write the SKILL.md

Create `.claude/skills/scaffold-controller/SKILL.md`:

```markdown
---
name: scaffold-controller
description: Scaffold an ASP.NET Core controller with constructor injection, proper response types, and XML documentation comments. Use when the user asks to create a new controller or API endpoint.
argument-hint: [entity-name]
---

# Scaffold ASP.NET Core Controller

Generate a new API controller for the `$ARGUMENTS` entity.

## Requirements

1. **File location**: `src/Api/Controllers/{EntityName}Controller.cs`
2. **Namespace**: Match the project's root namespace + `.Controllers`
3. **Base class**: Inherit from `ControllerBase`
4. **Attributes**: `[ApiController]` and `[Route("api/[controller]")]`
5. **Constructor injection**: Accept the service interface via constructor DI
6. **Response types**: Use `ActionResult<T>` return types with proper status codes
7. **XML comments**: Add `<summary>` docs on every public method
8. **Endpoints to generate**:
   - `GET /api/{entity}` - list all (with pagination parameters)
   - `GET /api/{entity}/{id}` - get by ID
   - `POST /api/{entity}` - create
   - `PUT /api/{entity}/{id}` - update
   - `DELETE /api/{entity}/{id}` - delete

## Code Style

- Use `IActionResult` for delete, `ActionResult<T>` for everything else
- Return `NotFound()` when entity is null, not an empty 200
- Use cancellation tokens on all async methods
- Follow the project's existing naming conventions from CLAUDE.md
```

### Step 3: Invoke the Skill

Now you can invoke it from any Claude Code session in your project:

```text
/scaffold-controller Product
```

Claude loads the full SKILL.md, substitutes `$ARGUMENTS` with "Product", and generates the controller following your exact specifications. Every time. No copy-pasting. No prompt drift.

You can also let Claude invoke it automatically. If you type something like "create a new controller for the Order entity," Claude checks its skill descriptions, finds that `scaffold-controller` matches ("Scaffold an ASP.NET Core controller... Use when the user asks to create a new controller"), and loads it automatically.

## Anatomy of a SKILL.md

A skill on disk is a **directory**, not a single file. The directory name becomes the skill name. Inside it, `SKILL.md` is required - everything else is optional.

```text
my-skill/
├── SKILL.md          # required: frontmatter + instructions
├── scripts/          # optional: executable code Claude can run
├── references/       # optional: long-form docs loaded on demand
└── assets/           # optional: templates, schemas, sample files
```

`SKILL.md` itself has two parts: **YAML frontmatter** (configuration) and a **Markdown body** (the instructions Claude follows).

### Frontmatter Reference

The Agent Skills standard defines a small, portable set of fields. Claude Code adds several extensions on top. The minimum legal SKILL.md is just two fields:

```yaml
---
name: my-skill
description: What this skill does and when to use it
---
```

The full set, including Claude Code's extensions, looks like:

```yaml
---
# Agent Skills standard fields
name: my-skill
description: Scaffold an ASP.NET Core endpoint with DTOs, validation, and an integration test. Use when the user asks to add an endpoint or expose a feature over HTTP.
license: MIT
compatibility: Requires .NET 10 SDK and FluentValidation
metadata:
  author: codewithmukesh
  version: "1.0"
# Claude Code extensions
when_to_use: Use when user asks "add an endpoint", "create a route", or "new API"
argument-hint: [HTTP-method] [route] [entity]
arguments: [method, route, entity]
disable-model-invocation: false
user-invocable: true
allowed-tools: Read Write Edit Grep Bash(dotnet build *)
model: sonnet
effort: high
context: fork
agent: Explore
paths: ["src/**/*.cs", "tests/**/*.cs"]
shell: bash
hooks:
  PreToolUse:
    - matcher: "Bash(git commit)"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
---
```

**Agent Skills standard fields** (portable across Claude Code, Gemini CLI, Cursor, OpenAI Codex, Copilot, etc.):

| Field | Required | What It Does |
| --- | --- | --- |
| `name` | Yes | Skill identifier. Must match the directory name. 1-64 chars, lowercase letters/numbers/hyphens only, no leading or trailing hyphen, no consecutive hyphens. |
| `description` | Yes | What the skill does and when to use it. Max 1,024 chars per the standard. Critical for auto-invocation - include the actual phrases users would type. |
| `license` | No | License name or pointer to a bundled `LICENSE.txt`. |
| `compatibility` | No | Environment requirements (target product, system packages, network access). Max 500 chars. |
| `metadata` | No | Arbitrary string-to-string map for custom keys (author, version, etc.). |
| `allowed-tools` | No | Space-separated string of pre-approved tools. Marked experimental in the standard - Claude Code implements it fully. |

**Claude Code extensions** (Claude Code only - other tools may ignore these):

| Field | Default | What It Does |
| --- | --- | --- |
| `when_to_use` | - | Extra trigger phrases appended to description in the skill listing. Combined cap with description is 1,536 chars in Claude Code's listing (configurable via `maxSkillDescriptionChars`). |
| `argument-hint` | - | Shown in autocomplete: `/my-skill [issue-number]` |
| `arguments` | - | Named positional arguments for `$name` substitution. With `arguments: [issue, branch]`, `$issue` expands to the first arg and `$branch` to the second. |
| `disable-model-invocation` | `false` | Set `true` to block automatic invocation - manual `/name` only. Also stops the skill from being preloaded into subagents. |
| `user-invocable` | `true` | Set `false` to hide from the `/` menu. Claude-only background knowledge. |
| `model` | Inherit | Override the model for the current turn only. Not saved to settings; session model resumes next prompt. |
| `effort` | Inherit | Effort level override: `low`, `medium`, `high`, `xhigh`, or `max`. |
| `context` | - | Set to `fork` to run in an isolated subagent with a fresh context window. |
| `agent` | `general-purpose` | Subagent type when `context: fork` is set: `Explore`, `Plan`, `general-purpose`, or any custom subagent from `.claude/agents/`. |
| `paths` | - | Glob patterns that gate auto-loading. Skill only auto-loads when working with files matching these patterns. |
| `shell` | `bash` | Shell for `` !`command` `` blocks. Use `powershell` on Windows (requires `CLAUDE_CODE_USE_POWERSHELL_TOOL=1`). |
| `hooks` | - | Lifecycle hooks scoped to this skill only. |

You can validate a skill against the standard using the [`skills-ref` CLI](https://github.com/agentskills/agentskills/tree/main/skills-ref) - useful if you plan to publish skills that should work across multiple AI tools.

### The `allowed-tools` Field

By default, Claude Code asks permission before running tools like Write, Edit, or Bash. The `allowed-tools` field lets you pre-authorize specific tools while a skill is active, so the work doesn't pause on every permission prompt mid-scaffold.

You can be as broad or granular as you need:

```yaml
# Broad: allow all Bash and Read operations (space-separated string)
allowed-tools: Bash Read

# Granular: only allow specific command patterns
allowed-tools: Bash(dotnet build *) Bash(dotnet test *) Read Edit

# Very granular: YAML list with domain-scoped web fetches
allowed-tools:
  - Read
  - Grep
  - WebFetch(domain:learn.microsoft.com)
```

The pattern syntax for `Bash()` uses glob matching - `Bash(dotnet *)` allows any command starting with `dotnet`, while `Bash(npm install)` only allows that exact command.

My take: **be specific with `allowed-tools`, especially for `Bash`.** A skill with `allowed-tools: Bash` can run any shell command without asking. That's fine for a trusted read-only research skill, but dangerous for a deployment skill. I always scope Bash permissions to the exact commands the skill needs.

### The Invocation Control Matrix

These two boolean fields - `disable-model-invocation` and `user-invocable` - give you fine control over who can trigger a skill:

| Configuration | You Type `/name` | Claude Auto-Invokes | Use Case |
| --- | --- | --- | --- |
| Both default | Yes | Yes | Most skills - available everywhere |
| `disable-model-invocation: true` | Yes | No | Dangerous operations: deploy, database migrations |
| `user-invocable: false` | No | Yes | Background knowledge Claude should know but you don't invoke |
| Both set | No | No | Effectively disabled - don't do this |

I set `disable-model-invocation: true` on any skill that writes to external systems - deployments, EF Core migrations against shared environments, infrastructure changes via Terraform. I don't want Claude deciding on its own that it's time to deploy to production.

### Arguments and Substitution Variables

Skills accept arguments through string substitution:

| Variable | What It Contains | Example |
| --- | --- | --- |
| `$ARGUMENTS` | All arguments as a single string | `/fix 123 urgent` → `"123 urgent"` |
| `$ARGUMENTS[0]` or `$0` | First argument | `"123"` |
| `$ARGUMENTS[1]` or `$1` | Second argument | `"urgent"` |
| `${CLAUDE_SESSION_ID}` | Current session ID | Useful for logging and correlation |

If your skill doesn't use `$ARGUMENTS` anywhere in the body, Claude Code automatically appends `ARGUMENTS: <value>` to the end of the content. But I recommend being explicit - place `$ARGUMENTS` exactly where it makes sense in your instructions.

```markdown
---
name: migrate-component
argument-hint: [component-name] [source-framework] [target-framework]
---

Migrate the `$0` component from $1 to $2.

1. Read the existing $1 component
2. Analyze its props, state, and lifecycle methods
3. Rewrite in $2 following the project's conventions
4. Preserve all existing behavior and tests
```

Invoked as: `/migrate-component SearchBar React Vue`

## Building a Real-World Skill: .NET Endpoint Generator

Let's build something more substantial - a skill that generates a complete ASP.NET Core Minimal API endpoint with request/response DTOs, validation, service layer, and integration test. This mirrors a skill I actually use in my .NET projects.

Create `.claude/skills/gen-endpoint/SKILL.md`:

````markdown
---
name: gen-endpoint
description: Generate a complete ASP.NET Core Minimal API endpoint with DTOs, validation, service interface, and integration test. Use when asked to create a new endpoint or API route.
argument-hint: [HTTP-method] [route] [entity-name]
allowed-tools: Read Write Edit Grep Glob Bash(dotnet build *)
---

# Generate Minimal API Endpoint

Create a complete endpoint for **$2** using **$0 $1**.

## Step 1: Analyze the Project Structure

Before generating anything:

- Read the existing project structure using Glob
- Find existing endpoint registrations to match the pattern
- Check for existing DTOs, services, and validation patterns
- Read CLAUDE.md for project-specific conventions

## Step 2: Generate Request and Response DTOs

Location: `src/Api/Contracts/{EntityName}/`

- `{Method}{EntityName}Request.cs` - request DTO with data annotations
- `{EntityName}Response.cs` - response DTO (reuse if it already exists)

Use records for DTOs. Include XML documentation.

## Step 3: Add FluentValidation Validator

Location: `src/Api/Validators/`

- `{Method}{EntityName}RequestValidator.cs`
- Validate all required fields, string lengths, and business rules
- Use `.WithMessage()` for every rule - no default messages

## Step 4: Create or Update Service Interface and Implementation

- Interface: `src/Api/Services/I{EntityName}Service.cs`
- Implementation: `src/Api/Services/{EntityName}Service.cs`
- Add only the method needed for this endpoint
- Use CancellationToken on all async methods
- Return a Result type if the project uses one, otherwise throw on not-found

## Step 5: Register the Endpoint

Location: Follow the project's existing endpoint registration pattern.

```csharp
app.Map{Method}("{route}", async (
    [{FromBody/FromRoute/FromQuery}] {RequestType} request,
    I{EntityName}Service service,
    CancellationToken ct) =>
{
    // implementation
})
.WithName("{Method}{EntityName}")
.WithOpenApi()
.Produces<{ResponseType}>(StatusCodes.Status{XXX})
.ProducesValidationProblem();
```

## Step 6: Register in DI Container

Add the service registration in the appropriate DI extension method.

## Step 7: Generate Integration Test

Location: `tests/Api.IntegrationTests/{EntityName}/`

- Test the happy path
- Test validation failures (400)
- Test not-found scenarios (404) where applicable
- Use WebApplicationFactory

## Step 8: Build Verification

Run `dotnet build` on the solution. Fix any compilation errors before reporting done.
````

Now, generating a complete endpoint with DTOs, validation, service layer, and tests is a single command:

```text
/gen-endpoint POST /api/products Product
```

Claude reads the skill, substitutes `$0` = POST, `$1` = /api/products, `$2` = Product, analyzes your existing project structure to match patterns, and generates everything. The `allowed-tools` field ensures it can read files, write files, search the codebase, and run `dotnet build` - all without interrupting you for permission on each step.

## Don't Want to Hand-Write SKILL.md? Use the skill-creator Skill

Everything above assumed you'd write `SKILL.md` by hand from a template - which is how every skill in [dotnet-claude-kit](https://codewithmukesh.com/resources/dotnet-claude-kit/) got built. But there's now an official, Anthropic-published skill that **builds skills for you**: the `skill-creator` from the [claude-plugins-official marketplace](https://github.com/anthropics/claude-plugins-official).

It's a conversational workflow, not a generator. The `claude-plugins-official` marketplace is available automatically in every Claude Code installation, so all you need to do is install the plugin:

```text
# Inside a Claude Code session
/plugin install skill-creator
```

Then start the skill by describing what you want:

```text
/skill-creator I want a skill that scaffolds an EF Core entity with a configuration class and a migration
```

The skill walks you through five phases:

1. **Capture intent** - what should the skill do, when should it trigger, what's the expected output.
2. **Interview and research** - asks about edge cases, example inputs and outputs, dependencies, similar skills in your project.
3. **Draft the SKILL.md** - writes the frontmatter and the body following the same patterns I covered in the "Anatomy" section above.
4. **Generate test prompts and evals (optional)** - drafts a few quantitative test cases so you can benchmark variance and triggering accuracy.
5. **Optimize the description** - runs a separate pass to rewrite the `description:` field for better auto-invocation. This is the part I've gotten the most value from.

### When to Reach for `skill-creator` vs. Hand-Roll

| Situation | Hand-roll SKILL.md | Use skill-creator |
| --- | --- | --- |
| You already have a working prompt to paste in | Yes - faster | - |
| First skill of your life | - | Yes - lower learning curve |
| You want eval-driven iteration | - | Yes |
| You want auto-optimized description for auto-invocation | - | Yes |
| Trivial 20-line skill | Yes | Overkill |
| You're replicating a known pattern across 10 skills | Yes - copy-paste | - |

My take: I still hand-roll most skills because I'm fast at it and I know exactly how I want the body to read. But I reach for `skill-creator` whenever the trigger phrases are non-obvious. Description optimization alone has saved me 2-3 iteration cycles on skills where I couldn't figure out why auto-invocation kept missing or firing on the wrong prompts.

## Where Should You Store Your Skills?

Skills can be stored at different scopes, and the priority order matters:

| Scope | Location | Visible To | Best For |
| --- | --- | --- | --- |
| Enterprise | Managed settings | All users in your org | Org-wide deploy, security, compliance skills |
| Personal | `~/.claude/skills/my-skill/` | Only you, across all projects | Your personal productivity tools |
| Project | `.claude/skills/my-skill/` | Anyone who clones the repo | Team workflows, project-specific generators |
| Plugin | `<plugin>/skills/my-skill/` | Where plugin is enabled | Distributed tooling, shared across orgs |

**Priority when names collide:** Enterprise > Personal > Project. If you have a `/deploy` skill at both personal and project level, the personal version wins. Plugin skills use a `plugin-name:skill-name` namespace, so they never collide with the other scopes - your project's `/deploy` and a plugin's `/my-kit:deploy` coexist.

### Sharing Skills Through Version Control

Project-level skills live in `.claude/skills/`, which means they're **automatically version-controlled** when you commit them. Your entire team gets the same skills when they clone the repo.

Worth thinking about: instead of documenting "here's the prompt template for generating a new endpoint" in a wiki that nobody reads, you commit the skill to the repo. New team members get it on `git pull`. Updates propagate through normal code review. The skill and the code it generates live in the same repository.

I version-control all my project skills. My .NET API repos and React frontend repos each carry their own `.claude/skills/` folder - so every collaborator (human or AI) follows the same scaffolding, migration, and review workflows the moment they clone.

### Monorepo Support

Claude Code automatically discovers skills in nested `.claude/skills/` directories. In a monorepo, each package can define its own skills:

```text
my-monorepo/
├── .claude/skills/shared-lint/SKILL.md
├── packages/
│   ├── api/
│   │   └── .claude/skills/gen-endpoint/SKILL.md
│   └── web/
│       └── .claude/skills/gen-component/SKILL.md
```

When you're working in `packages/api/`, Claude sees both the shared `shared-lint` skill and the package-specific `gen-endpoint` skill. Package-specific skills take priority if names conflict.

> **Read next:** [Plan Mode in Claude Code](https://codewithmukesh.com/blog/plan-mode-claude-code/) - Use Plan Mode to think before you build - the 4-phase workflow, decision matrix, and CLAUDE.md synergy.

## What Advanced Features Do Skills Support?

Once basic skills feel routine, the next four features are where skills start to do work you couldn't easily do with a copy-pasted prompt.

### Dynamic Context Injection with Shell Commands

The `` !`command` `` syntax executes shell commands **before Claude sees the skill content**, injecting live data into the prompt. This is preprocessing - the command runs immediately, and its output replaces the placeholder.

```markdown
---
name: pr-review
description: Review a pull request with full context
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

# Pull Request Review

## Context (live data)

- **Changed files:** !`gh pr diff --name-only`
- **PR description:** !`gh pr view --json body --jq .body`
- **Test status:** !`gh pr checks`

## Your Task

Review this PR for:

1. Code quality and .NET best practices
2. Missing null checks or validation
3. Performance concerns
4. Test coverage gaps

Provide feedback as a numbered list with file:line references.
```

When you invoke `/pr-review`, those three `` !`gh ...` `` commands execute immediately. Claude receives the skill with actual PR data already embedded - it never runs the `gh` commands itself. This is faster and more reliable than having Claude execute the commands as tool calls.

I use this pattern extensively for skills that need fresh context - Git history, build status, current branch, environment variables.

### Subagent Delegation with `context: fork`

Set `context: fork` to run a skill in an **isolated subagent** with its own context window. As described in the [Claude Code sub-agents documentation](https://code.claude.com/docs/en/sub-agents), the subagent gets a fresh conversation - it doesn't see your prior chat history. When it finishes, its results are summarized and returned to your main conversation.

```markdown
---
name: deep-research
description: Research a .NET topic thoroughly across the codebase
context: fork
agent: Explore
allowed-tools: Read Grep Glob
---

Research $ARGUMENTS thoroughly in this codebase:

1. Find all relevant files using Glob and Grep
2. Read and analyze the implementations
3. Identify patterns, inconsistencies, and potential improvements
4. Summarize findings with specific file:line references
```

Why use `context: fork`?

1. **Context protection:** The research might read 50 files - all that content stays in the subagent's context, not yours.
2. **Tool restriction:** The `Explore` agent only gets read-only tools. It can't accidentally modify anything.
3. **Parallel execution:** Subagents can run in the background while you continue working.

The available agent types for the `agent` field:

| Agent | Model | Tools | Use Case |
| --- | --- | --- | --- |
| `Explore` | Haiku (fast) | Read-only | File search, codebase analysis |
| `Plan` | Inherit | Read-only | Architecture research, approach design |
| `general-purpose` | Inherit | All tools | Complex multi-step tasks with file modifications |

My take: **use `context: fork` for any skill that reads more than 5-10 files.** The context window cost of loading dozens of files into your main conversation isn't worth it. Let a subagent handle the heavy lifting and return a summary.

### Model Override

The `model` field lets you run a skill on a specific model regardless of your session's default:

```yaml
---
name: quick-lint
description: Quick code style check
model: haiku
---
```

This is useful for cost optimization. A simple linting or formatting skill doesn't need Opus - Haiku handles it fine at a fraction of the cost. I use `model: haiku` for read-only analysis skills and `model: sonnet` for code generation skills where quality matters but I don't need Opus-level reasoning.

### Extended Thinking in Skills

Include the word `ultrathink` anywhere in your skill content to enable extended thinking mode. This gives Claude more reasoning time for complex analysis:

```markdown
---
name: architecture-review
description: Deep architecture review with extended reasoning
context: fork
agent: general-purpose
---

# Architecture Review (ultrathink)

Analyze the architecture of this .NET solution:

1. Map the dependency graph between projects
2. Identify circular dependencies
3. Evaluate adherence to Clean Architecture principles
4. Flag any violations of SOLID principles
5. Recommend specific refactoring steps
```

I reserve `ultrathink` for skills that involve genuine architectural reasoning - not simple code generation. It increases response time and token usage.

### Skill-Scoped Hooks

Skills can define their own [lifecycle hooks](https://code.claude.com/docs/en/hooks) that only trigger while the skill is active:

```yaml
---
name: safe-deploy
description: Deploy with safety checks
disable-model-invocation: true
hooks:
  PreToolUse:
    - matcher: "Bash(git push *)"
      hooks:
        - type: command
          command: "./scripts/pre-push-check.sh"
---
```

This hook runs `pre-push-check.sh` before any `git push` command - but only when the `/safe-deploy` skill is active. It doesn't affect your normal Claude Code sessions.

## Skip the Boilerplate: dotnet-claude-kit for .NET Devs

If you're a .NET developer, you don't actually have to write 47 skills from scratch. I already did - and I open-sourced them as **dotnet-claude-kit**, a Claude Code plugin that ships a complete .NET 10 / C# 14 setup the moment you install it.

As of v0.7.0, the Kit ships:

- **47 skills** covering architectures (`clean-architecture`, `vertical-slice`, `ddd`), runtime patterns (`ef-core`, `minimal-api`, `authentication`, `caching`, `resilience`, `messaging`, `httpclient-factory`), observability (`opentelemetry`, `serilog`, `logging`), infrastructure (`docker`, `aspire`, `ci-cd`, `container-publish`), plus 7 meta-skills like `context-discipline`, `convention-learner`, `de-sloppify`, and `code-review-workflow`.
- **16 slash commands** including `/scaffold` (generates a complete feature with Result pattern, FluentValidation, OpenAPI metadata, pagination, and tests in one shot), `/health-check` (graded codebase report card), `/code-review` (multi-dimensional PR review), `/security-scan`, `/migrate` (safe EF Core migrations with rollback), `/tdd`, `/verify`, `/build-fix`, and `/de-sloppify`.
- **10 specialist subagents** - `dotnet-architect`, `api-designer`, `ef-core-specialist`, `code-reviewer`, `security-auditor`, `performance-analyst`, `test-engineer`, `refactor-cleaner`, `devops-engineer`, and `build-error-resolver` - each scoped to their domain and ready to delegate work to.
- **15 Roslyn-powered MCP tools** that let Claude query your solution semantically: `find_references`, `find_dead_code`, `detect_antipatterns`, `detect_circular_dependencies`, `get_dependency_graph`, `get_test_coverage_map`, and more. These cost roughly 30-150 tokens per query versus 500-2000 tokens for a full file read.
- **10 always-loaded rules**, **7 hooks** (format on edit, anti-pattern check on commit, test result analysis), and **5 project templates** for the four supported architectures.

### How This Actually Helps .NET Devs

Three concrete wins:

1. **You skip 47 skills of writing work.** Install the plugin, get the playbooks instantly. The Kit's `/scaffold` command alone replaces what would take you a week to write as project-specific skills - feature generation with FluentValidation, Result pattern, OpenAPI, pagination, and integration tests, across all four supported architectures.
2. **Claude stops generating legacy .NET patterns.** Out of the box, Claude Code will write `DateTime.Now`, wrap EF Core in repository abstractions, and instantiate `new HttpClient()` because those patterns dominate older training data. The Kit's rules and skills steer it to `TimeProvider`, direct `DbContext`, and `IHttpClientFactory` automatically. No "fix this pattern" revision cycles.
3. **Roslyn MCP makes codebase navigation roughly 10x cheaper.** Instead of reading entire `.cs` files to find callers or detect circular dependencies, Claude runs semantic Roslyn queries. On a medium-sized solution, this is the difference between burning through your context window in 20 minutes and lasting a full afternoon.

The Kit is also a **reference implementation** of everything this article covered - the skills follow the same `SKILL.md` patterns, scoped `allowed-tools`, supporting-files structure, and description-optimized auto-invocation I documented above. If you want to learn skill design by reading well-built skills, clone the repo and read through `skills/clean-architecture/SKILL.md` or `skills/scaffolding/SKILL.md`.

> **Free resource:** [.NET Claude Kit](https://codewithmukesh.com/resources/dotnet-claude-kit/) - Open-source Claude Code companion with 47 skills and 10 specialist agents.

## When Should You Use Skills vs Rules vs Hooks?

Claude Code has three customization mechanisms - skills, rules (CLAUDE.md), and hooks. They solve different problems, and mixing them up leads to either wasted context or missed automation.

The decision usually comes down to a single question per task:

| Question | If Yes → Use | Example |
| --- | --- | --- |
| Should Claude always know this? | Rules (CLAUDE.md) | "Use 2-space indentation", "This project uses Minimal APIs, not controllers" |
| Is this a repeatable multi-step workflow? | Skills | "Generate a CRUD endpoint", "Scaffold a React feature module" |
| Should something happen automatically before/after a tool runs? | Hooks | "Run dotnet format after every file edit", "Lint before commit" |
| Does it need arguments or parameters? | Skills | `/gen-endpoint POST /api/products Product` |
| Is it a one-liner convention? | Rules | "Always use `ILogger<T>`, never `ILoggerFactory`" |
| Should it run without Claude's involvement? | Hooks | Shell scripts triggered by file changes or tool use |
| Does it need its own context/subagent? | Skills (`context: fork`) | Deep research, large-scale refactoring |

**The practical rule:** If you're describing _what to do_, use a skill. If you're describing _how things are_, use a rule. If you're describing _what should happen automatically_, use a hook.

> **Read next:** [Claude Code Prompts for .NET Developers](https://codewithmukesh.com/blog/claude-code-prompts-dotnet/) - Not ready to encode a workflow as a skill? Start with these 11 copy-paste prompts - the ones you reuse enough will graduate into skills.

Here's a concrete example. Say you want Claude to always run tests after modifying C# files:

- **As a rule** (CLAUDE.md): "After modifying any .cs file, run `dotnet test`." → Works, but Claude might forget. It's a suggestion, not enforcement.
- **As a hook** (settings.json): `PostToolUse` hook on `Edit` that runs `dotnet test` → Automatic, guaranteed, no Claude involvement needed. This is the right choice.
- **As a skill**: Overkill - this doesn't need a multi-step playbook.

> **Read next:** [Global Exception Handling in ASP.NET Core](https://codewithmukesh.com/blog/global-exception-handling-in-aspnet-core/) - See how middleware patterns like exception handling fit naturally into hook-based automation.

And another example. You want a standard process for creating new EF Core migrations:

- **As a rule**: Too complex for CLAUDE.md - migration creation involves checking the DbContext, naming conventions, running the command, and verifying the output.
- **As a hook**: Too complex for a hook - hooks are for simple pre/post actions, not multi-step workflows.
- **As a skill**: Perfect fit - `/gen-migration AddProductTable` triggers a step-by-step process.

## What Does a Bad Skill Look Like vs a Good One?

Two skills, same goal. One produces inconsistent output every time, the other generates code that matches the project's patterns on the first run. The difference is structure, not length.

**Bad - everything inline, vague description, no structure:**

```markdown
---
name: gen-code
description: Generate code
---

Generate some code for the user. Make sure it follows best practices
and is well-tested. Use the existing patterns in the project.
```

This skill is barely usable. The description matches every coding request, so auto-invocation either fires constantly or never (depending on how Claude weighs the other skills in the listing). The body is too generic to produce consistent output - the same `/gen-code` call on Monday and Friday returns different file layouts, different naming, different test coverage.

**Better - specific description, structured steps, scoped permissions:**

```markdown
---
name: gen-service
description: Generate a .NET service class with interface, DI registration, and unit test. Use when the user asks to create a new service or business logic layer.
argument-hint: [service-name]
allowed-tools: Read Write Edit Grep Glob
---

# Generate Service for $ARGUMENTS

## Step 1: Analyze existing services

Find existing service patterns using Grep: interface naming, DI registration location, test structure.

## Step 2: Generate interface

Location: `src/Application/Interfaces/I{ServiceName}Service.cs`

- One method per operation, async with CancellationToken
- XML documentation on every method

## Step 3: Generate implementation

Location: `src/Infrastructure/Services/{ServiceName}Service.cs`

- Constructor inject dependencies (ILogger, DbContext)
- Implement all interface methods

## Step 4: Register in DI

Add scoped registration in the appropriate extension method.

## Step 5: Generate unit test

Location: `tests/Application.UnitTests/{ServiceName}ServiceTests.cs`

- Use NSubstitute for mocking
- Test happy path + error cases
```

The good version is four times longer, but it pays for itself the first time you invoke it. It tells Claude exactly where files go, what conventions to follow, and what to test - so the output lands matching the rest of the codebase instead of needing two or three rounds of follow-up prompts to correct. **A well-structured 200-line skill saves more context than a vague 20-line one**: the vague version leaks tokens through correction prompts that cost more than the extra structure ever would.

## Skill Design Patterns That Took Me Multiple Rewrites

Most of these lessons came out of building the 47 skills shipped in [dotnet-claude-kit](https://codewithmukesh.com/resources/dotnet-claude-kit/) - the ones I rewrote two or three times before they triggered reliably and produced consistent output.

### 1. Write Descriptions Like Search Queries

Your skill's `description` is what Claude uses for automatic invocation. I originally wrote descriptions like a documentation author:

```yaml
# Bad - too formal, doesn't match natural language
description: A comprehensive tool for generating ASP.NET Core endpoints with full pipeline integration
```

Claude never auto-invoked it because nobody says "comprehensive tool for generating." What developers actually type is "add an endpoint for..." or "create a route..." - so match that:

```yaml
# Good - matches how people actually talk
description: Scaffold a full ASP.NET Core endpoint with DTOs, validation, handler, and integration test. Use when the user says "add an endpoint", "create a route", "new API", or asks to expose a feature over HTTP.
```

Include the actual phrases you'd type. Claude matches against the description text. Rewriting descriptions to match natural trigger phrases was the single change that made auto-invocation actually usable for me - before that, I was reaching for `/skill-name` manually every time.

### 2. Keep SKILL.md Under 500 Lines

My endpoint-scaffolding skill started at 200 lines and grew to 800. At 800 lines, the skill alone consumed roughly 12% of the context window - before Claude even read a single `.cs` file. Output quality dropped because Claude had less room to hold the existing handlers, validators, and EF entities it needed to match patterns against.

The fix: **move reference material to separate files** and reference them from SKILL.md:

```markdown
<!-- In SKILL.md -->
For Result-pattern + FluentValidation conventions, read `.claude/docs/endpoint-conventions.md`.
For EF Core configuration rules, read `.claude/docs/ef-core-standards.md`.
```

After refactoring, the skill dropped to ~200 lines (~3% of context), and the reference docs only load when Claude actually needs them. That freed up roughly 9% of the context window - enough to hold 2-3 more `.cs` files while scaffolding, which is usually what matters most for matching project patterns.

The [Claude Code documentation](https://code.claude.com/docs/en/skills) explicitly recommends keeping `SKILL.md` under 500 lines and moving detailed reference material into separate files.

### 3. Put Guard Rails on Destructive Skills

If a skill writes to anything external - a database, a remote API, your hosting provider - assume Claude can decide on its own that it's time to run it. Auto-invocation matches on the description, and a casual sentence in chat is enough to trigger a match. Anything irreversible needs:

```yaml
disable-model-invocation: true
```

No exceptions. Deploy, EF Core migrations against a shared DB, Terraform apply, force-push - if it's not reversible, Claude doesn't get to decide when to run it.

### 4. Use Supporting Files for Templates and Examples

Instead of embedding a 50-line code template directly in SKILL.md, put it in a supporting file:

```text
.claude/skills/gen-endpoint/
├── SKILL.md
├── templates/
│   ├── endpoint.cs.tmpl
│   ├── dto.cs.tmpl
│   └── test.cs.tmpl
└── examples/
    └── product-endpoint.md
```

In SKILL.md, reference them:

```markdown
Read the endpoint template from `templates/endpoint.cs.tmpl` and adapt it.
See `examples/product-endpoint.md` for a complete example of the expected output.
```

This keeps SKILL.md clean and makes templates independently maintainable.

### 5. Test Both Invocation Paths

A skill can be invoked manually (`/skill-name`) or automatically (Claude matches the description). Test both:

1. **Manual test:** Type `/skill-name` with arguments. Does it produce the right output?
2. **Auto-invocation test:** Describe the task in natural language without using the slash command. Does Claude pick up the skill?
3. **Negative test:** Describe an unrelated task. Does Claude avoid loading the skill?

I've had skills that worked perfectly when manually invoked but never auto-invoked because the description was too vague. And skills that auto-invoked on every third prompt because the description was too broad.

## Bundled Skills That Ship With Claude Code

Claude Code now ships with a handful of bundled prompt-based skills you can use immediately. Unlike built-in commands (`/help`, `/compact`) which run fixed logic, bundled skills give Claude detailed instructions and let it orchestrate the work using tools - so they behave like skills you wrote yourself.

> **Who invokes them changed.** Claude auto-invokes some bundled skills when they look relevant, but **`/verify` and `/code-review` now run only when you invoke them explicitly** (v2.1.215 and later). Both are long-running and token-hungry, so the change puts you in control of when that spend happens. If you built a workflow on Claude firing `/code-review` on its own, it won't any more - invoke it yourself or wrap it in a hook.
>
> To turn bundled skills off entirely, use the `disableBundledSkills` setting. It disables all of them except `/doctor`, which stays typable by design.

### `/code-review`

Multi-dimensional review of recent changes for quality, security, reuse opportunities, and efficiency. Spawns parallel review passes internally.

```text
/code-review
/code-review focus on memory efficiency
```

I run this after every significant coding session. It catches duplicated logic across files, overly complex LINQ chains, and unnecessary allocations.

### `/doctor`

A full setup checkup. It validates your install, checks your settings files for errors, reports the last update attempt, and fixes a good share of what it finds. It will also propose trims for a checked-in `CLAUDE.md`, cutting content Claude can derive from the codebase and keeping the pitfalls and conventions it can't.

Reach for it before debugging config problems by hand. There's also `claude doctor` from your shell for when a session won't start at all.

### `/batch`

Executes large-scale changes across the codebase in parallel. Each change unit gets its own isolated Git worktree and agent.

```text
/batch update all repository classes to use the new IUnitOfWork interface
/batch add cancellation token support to all service methods
```

It spawns 5-30 parallel agents per run, so save it for genuine codebase-wide refactors - not work that a single Edit pass would cover.

### `/debug`

Troubleshoots your current Claude Code session by reading debug logs.

```text
/debug tools not responding
/debug session keeps compacting
```

I reach for this when Claude seems to be behaving oddly - tools timing out, context unexpectedly shrinking, or permissions not working as expected.

### `/loop`, `/claude-api`, `/run`, `/verify`, `/run-skill-generator`

The other bundled skills round out specific workflows:

- `/loop` runs a prompt or another skill on a recurring interval. Handy for polling a long-running test suite or watching CI.
- `/claude-api` helps you build and debug apps that use the Anthropic SDK directly - prompt caching, model migrations, batch API, all of it.
- `/run` and `/verify` launch your app and confirm a change works against the running app, not just tests or type checks.
- `/run-skill-generator` captures the exact recipe to launch your project (install commands, env vars, launch script) and writes it as a per-project skill, so `/run` and `/verify` stop guessing.

`/run`, `/verify`, and `/run-skill-generator` require Claude Code v2.1.145 or later.

> **Read next:** [RESTful API Best Practices for .NET](https://codewithmukesh.com/blog/restful-api-best-practices-for-dotnet-developers/) - Design clean, consistent APIs following REST conventions - the foundation for any endpoint generator skill.

> **Read next:** [CRUD API with EF Core - Full Course](https://codewithmukesh.com/blog/aspnet-core-webapi-crud-with-entity-framework-core-full-course/) - The endpoint patterns that my gen-endpoint skill automates - learn the manual way first.

> **Read next:** [Git Workflows Explained](https://codewithmukesh.com/blog/git-workflows-gitflow-vs-github-flow-vs-trunk-based-development/) - Understand branching strategies - skills + Git worktrees unlock parallel development workflows.

## How Do You Control Skill Permissions?

Beyond `allowed-tools` in frontmatter, you can control skill access globally through your `settings.json`:

```json
{
  "permissions": {
    "allow": [
      "Skill(scaffold-controller *)",
      "Skill(gen-endpoint *)"
    ],
    "deny": [
      "Skill(deploy *)"
    ]
  }
}
```

This lets you pre-approve certain skills (no confirmation prompt) and block others entirely. Useful in team settings where you want to prevent accidental invocation of dangerous skills.

To disable all skills entirely:

```json
{
  "permissions": {
    "deny": ["Skill"]
  }
}
```

## Troubleshooting Common Skill Issues

### Skill Not Appearing in `/` Autocomplete

- Verify the directory structure: `.claude/skills/my-skill/SKILL.md` (the `SKILL.md` filename is required)
- Check `name` in frontmatter - must be lowercase with hyphens only, max 64 characters
- Check `user-invocable` - if set to `false`, it won't appear in the menu
- Run `/context` to see if the skill is discovered and loaded

### Skill Not Auto-Invoking

- Check that `disable-model-invocation` is NOT set to `true`
- Rewrite the `description` to include phrases users actually say
- The description may be too vague - be specific about trigger scenarios
- Run `/context` to check for skill budget warnings (too many skills may exclude some)

### Skill Loads But Produces Poor Results

- The SKILL.md may be too long - move reference material to separate files
- Instructions may be ambiguous - use numbered steps with clear acceptance criteria
- Missing context - add `` !`command` `` blocks to inject live project data
- Try `context: fork` if the main conversation context is already large

### Arguments Not Substituting

- Verify you're using `$ARGUMENTS`, `$0`, `$1` (not `{0}` or `%1`)
- Arguments are space-separated - if an argument contains spaces, Claude receives it as multiple args
- If no `$ARGUMENTS` placeholder exists, check the end of the rendered prompt for `ARGUMENTS: <value>`

### "Skill Budget Exceeded" Warning

- You have too many skills and their descriptions exceed the context budget (default: 1% of context window)
- Run `/doctor` to see whether the budget is overflowing and which skills are being trimmed
- Shorten descriptions to essential trigger phrases - each description is capped at 1,536 chars regardless of budget
- Raise the budget via the `skillListingBudgetFraction` setting (e.g. `0.02` for 2%) or `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable
- Set low-priority skills to `"name-only"` in the `skillOverrides` setting so they list without a description
- Consider merging related skills or moving less-used ones to `disable-model-invocation: true`

### Supporting Files Not Loading

- Reference them explicitly in SKILL.md: "Read `templates/endpoint.cs.tmpl`"
- Use relative paths from the skill directory
- Claude reads them as tool calls - they need to be accessible files, not embedded content

## Key Takeaways

- **Skills are reusable Markdown playbooks** invoked with `/skill-name` or auto-detected by Claude from their description - they don't consume context until actually needed.
- **SKILL.md frontmatter** controls invocation (manual vs automatic), permissions (`allowed-tools`), model override, and subagent delegation (`context: fork`).
- **Use `$ARGUMENTS` and indexed `$0`, `$1`** for parameterized skills, and `` !`command` `` for injecting live data before Claude sees the prompt.
- **Project-level skills** (`.claude/skills/`) are version-controlled and shared with your team - treat them like code, not documentation.
- **Skills vs Rules vs Hooks:** Skills for _what to do_ (workflows), Rules for _how things are_ (conventions), Hooks for _what happens automatically_ (triggers).

## FAQ

### What are skills in Claude Code?

Skills are reusable Markdown files (`SKILL.md`) that act as on-demand playbooks for Claude Code. They contain step-by-step instructions for specific tasks like generating code, running workflows, or performing analyses. You invoke them with slash commands like `/skill-name` or Claude auto-invokes them when your request matches the skill description.

### Where should I store my skills - project or user level?

Store project-specific skills in `.claude/skills/` inside your repository so they are version-controlled and shared with your team. Store personal productivity skills in `~/.claude/skills/` so they are available across all projects. When both locations have a skill with the same name, the personal version wins over the project version. Plugin skills use a `plugin-name:skill-name` namespace so they never collide with either.

### Can Claude invoke skills automatically without typing the slash command?

Yes. Claude reads all skill descriptions at session start and automatically loads the full skill content when your request matches a description. You can prevent this by setting `disable-model-invocation: true` in the skill frontmatter, which restricts invocation to manual slash commands only.

### How do I pass arguments to a skill?

Type the arguments after the slash command, for example `/gen-endpoint POST /api/products Product`. In your `SKILL.md`, use `$ARGUMENTS` for the full argument string, `$ARGUMENTS[0]` or `$0` for the first argument, `$ARGUMENTS[1]` or `$1` for the second, and so on. Arguments are space-separated.

### What is the difference between skills and CLAUDE.md rules?

CLAUDE.md rules load into every session automatically and define persistent context like coding conventions, architecture decisions, and project preferences. Skills load on demand when invoked and define task-specific workflows like code generation, deployment procedures, or analysis playbooks. Use rules for how things are, use skills for what to do.

### Can I run a skill in a subagent with its own context?

Yes. Set `context: fork` in the skill frontmatter to run the skill in an isolated subagent with a fresh context window. Combine it with the `agent` field to specify the subagent type (`Explore` for read-only analysis, `Plan` for architecture research, `general-purpose` for full capabilities). Results are summarized and returned to your main conversation.

### How do I prevent a skill from being triggered accidentally?

Set `disable-model-invocation: true` in the skill frontmatter. This ensures the skill only runs when you explicitly type the slash command. Use this for any skill that has side effects like deployment, publishing, database migrations, or any operation that is not easily reversible.

### Can I share skills with my team through version control?

Yes. Project-level skills live in `.claude/skills/` inside your repository, which means they are committed to Git and shared with anyone who clones the repo. Team members get the same skills on `git pull`, and updates propagate through normal code review. This is the recommended approach for team workflows.

---

If you found this helpful, share it with your colleagues - and if you've built a skill that you're particularly proud of, drop a comment and let me know. I'm always looking for skill design patterns I haven't thought of.

Happy Coding :)

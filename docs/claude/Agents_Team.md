# Claude Code Multi-Session Workflow: Named Sessions and Cross-Session Messaging

This guide describes a multi-terminal development workflow in Claude Code using manually launched, named sessions (Planner, Implementer, Reviewer, and Testwriter) and cross-session messaging as an alternative to background subagents.

## 1. Architecture Comparison: Named Sessions and Subagents

| Dimension | Named sessions (cross-session messaging) | Subagents |
| --- | --- | --- |
| Execution model | Independent, persistent Claude Code terminal instances running concurrently. | Background workers spawned inside a parent session. |
| Communication flow | Sessions can message other active sessions directly. | The parent delegates work and receives results. |
| Mid-task steering | Switch to any terminal to inspect progress, redirect, or intervene. | Managed through the parent session. |
| Model and effort control | Set `--model` and `--effort` at launch, or use `/model` and `/effort` within a session. | Configured through `.claude/agents/*.md` frontmatter or inherited from the parent. |
| Context window | Each session maintains its own context window and conversation history. | Each subagent has context separate from the parent. |
| Visibility | Each session's activity appears in its own terminal. | Activity is viewed through the parent session. |
| Setup and overhead | Open multiple terminals or panes and name each session with `claude -n`. | The parent launches subagents on demand. |

## 2. Pros and Cons of Named Sessions

### Pros

- **Direct feedback loops.** Reviewer and Testwriter can send Implementer bug reports or failing test logs directly.
- **Persistent context.** Implementer can retain architectural decisions across multiple features in the same session.
- **Separate model and effort settings.** Assign each role the model and reasoning effort appropriate to its work.
- **Human intervention at any point.** Inspect, redirect, or approve work in each role's terminal.

### Cons

- **Manual terminal management.** Open and arrange terminal windows or tmux panes yourself.
- **Growing context costs.** Long-lived sessions accumulate history, increasing the context carried by later turns.
- **Manual coordination.** Without Agent Teams, use explicit messages to coordinate when each role starts work.
- **File conflicts.** Sessions sharing a working directory can overwrite each other's edits. Assign file ownership or sequence edits when roles need to change the same file.

## 3. Prerequisites and Requirements

1. **Claude Code version**
   - Cross-session messaging (`ListAgents` / `SendMessage`): v2.1.224+ on macOS/Linux, or v2.1.234+ on native Windows.
   - Session-name `@mention` autocomplete: v2.1.232+.
   - Check the installed version and update:

     ```bash
     claude --version
     claude update
     ```

2. **Account or provider**
   - Use a direct Claude.ai subscription or Anthropic API account.
   - Cross-session messaging is not supported on AWS Bedrock, Google Vertex AI, or Azure Foundry.

3. **Effort environment variable**
   - Ensure `CLAUDE_CODE_EFFORT_LEVEL` is not globally exported in `~/.zshrc` or `~/.bashrc`; it overrides the `--effort` CLI flag.
   - Clear it in the current shell if needed:

     ```bash
     unset CLAUDE_CODE_EFFORT_LEVEL
     ```

## 4. Shell Configuration & Launch Setup

### Launch Directly

Open four terminals or tmux panes in your project root. Run one command in each terminal; no alias or shell configuration is required.

```bash
# Terminal 1: Planner
claude -n "Planner" --model claude-opus-5-5 --effort medium

# Terminal 2: Implementer
claude -n "Implementer" --model claude-sonnet-5-5 --effort low

# Terminal 3: Reviewer
claude -n "Reviewer" --model claude-sonnet-5-5 --effort high

# Terminal 4: Testwriter
claude -n "Testwriter" --model claude-sonnet-5-5 --effort medium
```

Use `--model opus` or `--model sonnet` if you prefer the model aliases instead of explicit model IDs.

### Optional: Add Role Instructions at Launch

Use `--append-system-prompt` to give each session its role instructions. These commands replace the corresponding launch commands above.

```bash
# Terminal 1: Planner
claude -n "Planner" --model claude-opus-5-5 --effort medium \
  --append-system-prompt "You are the Planner. Write specs to markdown files and coordinate with Implementer, Reviewer, and Testwriter. Never modify application source code."

# Terminal 2: Implementer
claude -n "Implementer" --model claude-sonnet-5-5 --effort low \
  --append-system-prompt "You are the Implementer. Write clean production code strictly following approved markdown plans. Notify Reviewer and Testwriter when implementation is complete."

# Terminal 3: Reviewer
claude -n "Reviewer" --model claude-sonnet-5-5 --effort high \
  --append-system-prompt "You are the Reviewer. Audit git diffs against the specification for bugs, edge cases, and security issues. Send actionable feedback directly to Implementer."

# Terminal 4: Testwriter
claude -n "Testwriter" --model claude-sonnet-5-5 --effort medium \
  --append-system-prompt "You are the Testwriter. Write and run unit and integration tests for implemented features. Report any test failures directly to Implementer."
```

### Optional: Create Shell Aliases

For shorter launch commands, add these aliases to `~/.zshrc` (zsh) or `~/.bashrc` (bash). You can also include the corresponding `--append-system-prompt` argument from above in each alias.

```bash
alias c-plan='claude -n "Planner" --model claude-opus-5-5 --effort medium'
alias c-impl='claude -n "Implementer" --model claude-sonnet-5-5 --effort low'
alias c-rev='claude -n "Reviewer" --model claude-sonnet-5-5 --effort high'
alias c-test='claude -n "Testwriter" --model claude-sonnet-5-5 --effort medium'
```

Reload the configuration for your shell:

```bash
# zsh
source ~/.zshrc

# bash
source ~/.bashrc
```

Then use `c-plan`, `c-impl`, `c-rev`, or `c-test` instead of the full launch command. Aliases are optional throughout this guide.

## 5. Step-by-Step End-to-End Workflow

### Step 1: Launch All Four Named Sessions

Use the direct commands in [Section 4](#4-shell-configuration--launch-setup), one per terminal. If you configured the optional aliases, you can use these shortcuts:

| Terminal | Session | Optional alias | Model | Effort |
| --- | --- | --- | --- | --- |
| 1 | Planner | `c-plan` | Opus 5.5 | Medium |
| 2 | Implementer | `c-impl` | Sonnet 5.5 | Low |
| 3 | Reviewer | `c-rev` | Sonnet 5.5 | High |
| 4 | Testwriter | `c-test` | Sonnet 5.5 | Medium |

Inside the sessions, use `/color blue`, `/color green`, `/color yellow`, and `/color purple` to distinguish them. If you omitted `-n` at launch, use `/rename Planner` or the appropriate role name within that session.

### Step 2: Verify Session Discovery

In the Planner session, run:

```text
/list-agents
```

Confirm that Implementer, Reviewer, and Testwriter appear among the active local sessions. If two sessions have the same name, Claude Code appends a suffix such as `Planner-swift-falcon` to avoid routing collisions.

### Step 3: Draft and Approve the Plan

Ask Planner to explore the codebase and write a specification to a shared Markdown file:

```text
Analyze the codebase and design the implementation plan for the abc project. Write the full technical specification to abc.md. Do not write code yet.
```

Review `abc.md` and ask Planner for any adjustments before proceeding.

### Step 4: Hand Off Implementation

Once `abc.md` is approved, instruct Planner in plain English, or use `@Implementer` on v2.1.232+:

```text
Tell the Implementer session that abc.md has the plan for the abc project and to implement it. Ask Implementer to notify Reviewer and Testwriter once the code is written.
```

Planner uses `ListAgents` and `SendMessage` to send the instruction to Implementer. The message arrives in Implementer's session queue.

### Step 5: Review and Test in Parallel

When Implementer finishes, it messages Reviewer and Testwriter. You can also trigger them from another session.

- **Reviewer:** Inspect `git diff` against `abc.md` for logic flaws, edge cases, and regressions.
- **Testwriter:** Write tests in the test directory and run the test runner.

Coordinate edits if both roles need to change the same files.

### Step 6: Repeat the Fix and Verification Loop

1. Reviewer or Testwriter sends Implementer the exact file, line number, and failure reason for each issue.
2. Implementer applies the fixes and asks Reviewer and Testwriter to verify again.
3. Once review is approved and tests pass, Implementer or Reviewer reports completion to Planner and you.

## 6. Quick Troubleshooting Reference

| Issue | Cause | Fix |
| --- | --- | --- |
| `@Implementer` does not appear in autocomplete | `@` triggers file search by default; session-name autocomplete requires v2.1.232+. | Write in plain English: "Tell the Implementer session to..." |
| `/list-agents` shows no other sessions | Unsupported provider or an older Claude Code version. | Run `claude update` and use a Claude.ai or direct Anthropic API account. Check the platform-specific version requirements in Section 3. |
| A message arrives while Implementer is busy | Implementer is executing its current turn. | Let the message wait in the session queue. |
| Model effort does not match `--effort` | `CLAUDE_CODE_EFFORT_LEVEL` is set in the environment. | Run `unset CLAUDE_CODE_EFFORT_LEVEL` and check the active setting with `/effort`. |

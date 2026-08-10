# Repository Guidelines
This repository records the user's Agent Driven Development workflow. `AGENTS_STANDALONE.md` holds reusable instructions; `skills/` contains original skills. Keep shared rules aligned.

## Structure

This repository distributes reusable coding-agent guidance. `AGENTS.md` guides contributors; `AGENTS_STANDALONE.md` is embedded in `README.md`; `CLAUDE.md` and `GEMINI.md` redirect tools. `skills/` is the canonical catalog. `.agents/skills/` installs only the ADD-wide subset from `skills/agent-driven-development/`; keep that subset synchronized. Store durable guidance in `agents/MEMORY.md` and `agents/knowledge/`, human docs in `docs/`, drafts in `WIP/`, and obsolete content in `deprecated/`.

## Commands

No build system or package manager exists. Before committing, run:

- `git diff --check`: find whitespace errors.
- `diff -ru skills/agent-driven-development .agents/skills`: verify installed ADD skills.
- `rg 'term' skills agents docs`: find stale or duplicate guidance.
- `git status --short`: review changed files.

Changes to `AGENTS_STANDALONE.md` on `main` trigger `.github/workflows/embed-agents.yml`, which updates `README.md`. Never edit its marked generated block manually.

## Style & Naming

Use concise Markdown, descriptive headings, short paragraphs, and actionable language. Keep each durable rule in one authoritative location; link elsewhere. Name skill directories with lowercase kebab-case, for example `create-component`. Keep filenames `SKILL.md` and `agents/openai.yaml`. Skill frontmatter requires `name` and a precise, trigger-oriented `description`. Use two-space YAML indentation.

# Repository Guidelines
This repository records the user's Agent Driven Development workflow. `AGENTS_STANDALONE.md` holds reusable instructions; `skills/` contains original skills. Keep shared rules aligned.

## Structure

This repository distributes reusable coding-agent guidance. `AGENTS.md` guides contributors; `AGENTS_STANDALONE.md` is embedded in `README.md`; `CLAUDE.md` and `GEMINI.md` redirect tools. `skills/` is the canonical catalog, grouped into `agent-driven-development/` (coding and programming workflow), `agent-driven-review/` (diagnosis and review), `web-design/`, and `misc/` (everything else, including `writing-agent-guidance`). `AGENTS_STANDALONE.md` bundles the `agent-driven-development/` skill bodies verbatim; keep them byte-aligned. `.agents/skills/` and `.claude/skills/` install the ADD-wide subset from `skills/agent-driven-development/` and `skills/agent-driven-review/`, plus `misc/writing-agent-guidance/` because this repository authors guidance; keep those synchronized. Store durable guidance in `agents/MEMORY.md` and `agents/knowledge/`, human docs in `docs/`, drafts in `WIP/`, and obsolete content in `deprecated/`.

## Commands

No build system or package manager exists. Before committing, run:

- `git diff --check`: find whitespace errors.
- `for d in skills/agent-driven-development/* skills/agent-driven-review/* skills/misc/writing-agent-guidance; do diff -ru "$d" ".agents/skills/$(basename "$d")"; done`: verify installed ADD skills (repeat for `.claude/skills`).
- `rg 'term' skills agents docs`: find stale or duplicate guidance.
- `git status --short`: review changed files.

Changes to `AGENTS_STANDALONE.md` on `main` trigger `.github/workflows/embed-agents.yml`, which updates `README.md`. Never edit its marked generated block manually.

## Style & Naming

Use concise Markdown, descriptive headings, short paragraphs, and actionable language. Keep each durable rule in one authoritative location; link elsewhere. Name skill directories with lowercase kebab-case, for example `create-component`. Keep filenames `SKILL.md` and `agents/openai.yaml`. Skill frontmatter requires `name` and a precise, trigger-oriented `description`. Use two-space YAML indentation.

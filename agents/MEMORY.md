# Repository Memory

- `AGENTS.md` is the contributor guide; `AGENTS_STANDALONE.md` is the canonical source for distributed agent guidance.
- Only `AGENTS_STANDALONE.md` guidance belongs in target projects; this repository's `agents/` content exists to curate it and is not distributed.
- The agent-guidance block in `README.md` is generated from `AGENTS_STANDALONE.md` by `.github/workflows/embed-agents.yml`; do not update it manually.
- Preserve the repository's lightweight, judgment-driven, vendor-neutral SDD model. Add mandatory workflow machinery only after an explicit repository-wide decision.
- Keep the skill catalog limited to the user's original work; use external skill collections as inspiration, not copied content.
- Treat `skills/` as the canonical catalog. Agents edit only `skills/`; do not edit `.agents/skills/`. The user runs the sync command to update the installed ADD-wide subset from `skills/agent-driven-development/`.
- Keep `AGENTS_STANDALONE.md` aligned only with `skills/agent-driven-development/`; leave other skill folders unchanged unless explicitly requested.

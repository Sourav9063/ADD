# Repository Memory

- `AGENTS.md` is the contributor guide; `AGENTS_STANDALONE.md` is the canonical source for distributed agent guidance.
- Only `AGENTS_STANDALONE.md` guidance belongs in target projects; this repository's `agents/` content exists to curate it and is not distributed.
- The agent-guidance block in `README.md` is generated from `AGENTS_STANDALONE.md` by `.github/workflows/embed-agents.yml`; do not update it manually.
- Preserve the repository's lightweight, judgment-driven, vendor-neutral SDD model. Add mandatory workflow machinery only after an explicit repository-wide decision.
- Keep the skill catalog limited to the user's original work; use external skill collections as inspiration, not copied content.
- Treat `skills/` as the canonical catalog. Agents edit only `skills/`; do not edit `.agents/skills/`. The user runs the sync command to update the installed ADD-wide subset from `skills/agent-driven-development/`.
- `AGENTS_STANDALONE.md` is the self-contained bundle of every implicitly invocable skill under `skills/agent-driven-development/`. Its repetition of those skill bodies is intentional; keep all content aligned and do not compress it by moving required behavior exclusively into separately installed skills. Leave other skill folders unchanged unless explicitly requested.
- Explicitly invoked skills stay out of the standalone bundle: always-loaded prose contradicts an explicit-invocation-only trigger. They ship as installed skills. Mark them in both consumers: `disable-model-invocation: true` in SKILL.md frontmatter and `allow_implicit_invocation: false` in `agents/openai.yaml`. `reviewing-changes` is the current case.

# Skill correctness refinements

Scope: apply the highest-impact corrections from `docs/skills-audit-2026-09-06.md` with short replacements. Preserve core ADD except request-intent and commit-authority clarifications. Keep reusable guidance framework-neutral; retain existing project profiles with narrower applicability. No catalog restructure or new workflow machinery.

1. Correct authentication, accessibility, replay safety, and contradictory UI rules.
2. Align the two core changes with the standalone bundle; leave generated README workflow-owned and installed skill sync user-owned.
3. Check changed prose, metadata, references, bundle equality, and word-count impact; exercise representative prompts with a fresh agent.

Acceptance: no new stack prescriptions, no expanded core workflow, shorter combined changed skill bodies, no whitespace errors, and no unsupported claims of runtime verification.

Status: complete. The audit records pre-change findings; its opening now links here to distinguish proposed work from implemented corrections.

Validation:

- All 65 active skill frontmatters and companion metadata parse as YAML. Three descriptions now use plain single-line YAML with internal colons rewritten, per user preference.
- All five core bodies match the standalone bundle. Whitespace checks pass. Changed skill files remain shorter overall; no new named-stack prescriptions.
- Fresh-agent tabletop evaluation passed six scenarios: action versus advice, MFA-preserving recovery, existing modal/tooltip primitives, accessible reordering and quiet streaming, absent backend-profile helpers, and timeout/repeated-toggle handling. It caught unconditional rollback; qualifying unknown and stale outcomes resolved it, confirmed by follow-up review.
- No browser/runtime or installed-harness tests ran. Installed copies still require the user-owned sync: four changed core skills plus the pre-existing writing-agent-guidance drift. README remains workflow-generated.

Deferred: broad taste edits, catalog restructuring, extra lifecycle machinery, and other audit proposals outside this focused pass.

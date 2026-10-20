# External skill refinements

Status: complete, with the question-authorization proposal withdrawn at the user's correction. Durable rationale is recorded in `agents/knowledge/external-guidance-synthesis.md`; this plan retains the acceptance and verification record.

## Goal

Apply the six retained refinements from the pstack, Matt Pocock, and Superpowers comparison and preserve the user's strict questions-read-only rule. Extend existing core skills without new skills, dependencies, or mandatory workflow machinery.

## Acceptance criteria

- Verification covers the resulting change and reruns only affected checks when later edits invalidate evidence.
- Tests derive expected results independently and fail for the intended behavioral reason before a fix.
- Plans prefer observable behavioral slices, name dependencies and acceptance checks, and allow staged migrations.
- Risky changes identify and test consequential safety assumptions or report them unproven.
- Performance claims verify equivalent successful work and report repeated measurements, variation, and end-to-end relevance.
- Recurring mechanically preventable failures prompt enforcement proposals while preserving immediate memory recording and scope authority.
- Questions get answers only, including rhetorical or suggestive ones; edits require the user's approval. Honor existing authorization without asking again.
- All five canonical skill bodies remain byte-aligned with the standalone bundle. Installed skill copies and generated README content remain maintainer/workflow-owned.

## Tasks

1. Done: applied the six retained refinements and aligned every full core body with the standalone bundle. Restored the user's strict questions-read-only rule after they rejected inferred authorization from questions.
2. Done: reconciled question-approval guidance in memory, affected drafts, audit proposals, and evaluation scenarios. Corrected two stale expectations found during review: code renames invoke coding, and cache implementation facts belong in knowledge rather than memory.
3. Done: exercised scenarios with a fresh agent as required by `writing-agent-guidance`, resolved both findings, and validated metadata, links, distribution boundaries, and the final diff.

## Constraints

- Preserve the unrelated edits already present in `skills/web-design/data-table-design/SKILL.md` and `agents/knowledge/shaping-web-ui-design.md`.
- No commits, installed-skill sync, or manual generated README changes.

## Verification

- All five canonical skill bodies occur byte-for-byte in the standalone bundle, with exactly five owning sections.
- All five frontmatters and companion metadata parse as YAML using Ruby's standard YAML library. Descriptions and invocation policies remain unchanged.
- Relative Markdown links in the updated knowledge files resolve; added prose contains no em dashes.
- Before the user's correction, fresh-agent tabletop evaluation passed 11 supplied scenarios, 13 trigger rows, and seven documented core behavior rows. Its question-authorization conclusions are superseded; the corrected question scenarios require approval before edits.
- After the correction, a fresh-agent tabletop review passed all five question-and-approval scenarios and found the skills, bundle, memory, evaluations, draft, audit, rationale, and plans consistent. The six retained refinements remain intact.
- `git diff --check` passes. The generated README, installed skill trees, and unrelated web-design edits were left untouched.
- Maintainer sync remains needed for all five core skills in both `.agents/skills/` and `.claude/skills/`. README embedding remains workflow-owned.
- No runtime or installed-harness skill-selection tests ran; the agent evaluation assesses supplied scenarios and canonical descriptions.

## Wording maintenance

- Compacted only the external-source additions at the user's request. Net added core text fell from 161 to 98 words, a 39% reduction; total core text fell from 3,767 to 3,704 words. Token counts were not measured.
- A fresh-agent comparison and seven tabletop cases found no material semantic loss. Exact communication wording and all five byte-aligned bundle bodies were preserved.
- Frontmatter, metadata, installed skills, generated README, and unrelated web-design edits match their pre-compression snapshots. Knowledge links resolve and whitespace checks pass.

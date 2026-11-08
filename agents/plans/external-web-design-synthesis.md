# External Web Design Synthesis

Status: complete.

## Goal and acceptance criteria

Review `alexisltt/ux-engine` and `klimofey/design-motion` for useful gaps in ADD's web-design
guidance. Write original, concise additions in existing owners; add a skill only for a
distinct uncovered task. Preserve project primitives, contextual judgment, source authority,
and existing work. Do not import external catalogs, hooks, gates, or mandatory artifacts.

## Work

- [x] Inspect both repositories' skill guidance, supporting references, audit modes, and local owners.
- [x] Extend composition reviews, table column choice, form defaults, visual baselines, and motion lifecycle handling.
- [x] Record adopted and rejected ideas in the existing design knowledge file.
- [x] Validate skills and metadata, check the diff, and exercise realistic requests with a fresh agent.

## Decisions

- Existing skills own every useful addition; a new UX-auditor skill would overlap composition review and accessibility auditing.
- Keep descriptions stable because the work sharpens behavior within existing triggers.
- External self-reported evaluation results are leads, not evidence of ADD improvement.

## Verification

Five changed skills passed frontmatter and companion YAML validation; descriptions stayed
unchanged. Local Markdown links and `git diff --check` passed. Fresh-agent scenarios covered
limited-evidence audits, eight-column reconciliation, stale prefills, restyle scope, and
cancelled/zero-duration motion. Evaluation exposed conflicting row-click instructions;
the clarified model passed a follow-up check. These checks validate guidance decisions,
not a running UI. Provenance and adoption rationale live in
[`shaping-web-ui-design.md`](../knowledge/shaping-web-ui-design.md).

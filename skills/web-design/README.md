# Web Design Skills

UI section skills. Each one covers a single surface: how it should look, how it should
move, how it behaves for keyboard and screen-reader users, and what usually ships broken.

| Skill | Covers |
| --- | --- |
| `design-foundations` | Tokens, spacing, hierarchy, surfaces, icons, gradients, motion timings, contrast, focus. Shared baseline for every other skill here. |
| `visual-direction` | Choosing a direction and holding it: grounding in references, declaring the system, structural variation, content realism, critique. |
| `typography-design` | Type roles, faces and weights, measure, wrapping, truncation, tabular numbers, underlines, optical trim. |
| `color-systems` | Ramp construction, step roles, notation and gamut, gradient interpolation, theme variants, palette audits. |
| `responsive-design` | Content-driven breakpoints, container queries, safe areas, full-bleed, overflow affordances, input capability. |
| `internationalization-design` | Text expansion, RTL mirroring, non-Latin scripts, locale formats, meaning that does not travel. |
| `form-design` | Field anatomy, validation, inline editing, settings, multi-step forms, submit and autosave. |
| `tab-design` | Tab bars, segmented controls, indicator motion, overflow, panel transitions. |
| `filter-design` | Filter chips, facet panels, applied-filter summaries, result counts, empty results. |
| `data-table-design` | Column layout, sorting, selection, sticky headers, density, pagination. |
| `navigation-design` | Sidebars, bottom bars, breadcrumbs, IA depth, search entry points, pagination. |
| `search-design` | Search input, scopes, suggestions, query understanding, ranking, result snippets, zero results. |
| `button-and-action-design` | Hierarchy, labels, disabled and busy states, destructive and bulk actions, toolbars. |
| `card-and-list-design` | Card anatomy, hover, click targets, grids, feeds, badges, reordering. |
| `collaboration-design` | Presence, live cursors, selection ownership, follow mode, conflict handling. |
| `overlay-design` | Choosing between modal, sheet, drawer, popover, and inline; focus trapping and dismissal. |
| `feedback-design` | Loading, empty, error, success, toast, optimistic updates, and undo. |
| `motion-design` | Whether to animate, easing curves, page and shared-element transitions, scroll-driven motion, reduced motion. |
| `chart-design` | Chart type choice, axis honesty, series color, tooltips, dashboards, accessible data tables. |
| `landing-page-design` | Marketing page structure, hero, social proof, pricing, section order, conversion CTAs. |
| `microcopy` | Buttons, labels, errors, empty states, confirmations, tone, and translatable strings. |
| `accessibility-audit` | Verification pass on shipped UI: keyboard, structure, contrast, screen reader, WCAG 2.2 AA reporting. |
| `frontend-performance` | Core Web Vitals, bundle size, images and fonts, hydration, re-renders, CI budgets. |

## Using them

Load `design-foundations` alongside any section skill; the section skills assume its
tokens and motion scale rather than repeating them. `design-foundations` covers
accessibility at design time; `accessibility-audit` verifies what already shipped.
For load and interaction speed, use `frontend-performance`.

The five skills after `design-foundations` are cross-cutting rather than per-surface.
`visual-direction` runs before the others on new work, when the question is still what
this should look like. `typography-design`, `color-systems`, `responsive-design`, and
`internationalization-design` each own one dimension that every surface passes through:
`design-foundations` defines the tokens, and they cover what happens to text, color,
space, and language after the tokens exist.

## Adding a skill

New UI-surface skills belong here. Keep the directory name lowercase kebab-case, keep
the file named `SKILL.md`, and give the frontmatter `description` concrete triggers
("Use when building a stepper, wizard, ..."), not a topic label. Do not restate
foundations rules; link to `design-foundations` instead.

Sources, authority order between them, and the coverage checklist this group is audited
against: [`agents/knowledge/shaping-web-ui-design.md`](../../agents/knowledge/shaping-web-ui-design.md).

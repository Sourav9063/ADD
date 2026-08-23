# Web Design Skills

UI section skills. Each one covers a single surface: how it should look, how it should
move, how it behaves for keyboard and screen-reader users, and what usually ships broken.

| Skill | Covers |
| --- | --- |
| `design-foundations` | Tokens, spacing, hierarchy, icons, gradients, motion timings, contrast, focus. Shared baseline for every other skill here. |
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

## Adding a skill

New UI-surface skills belong here. Keep the directory name lowercase kebab-case, keep
the file named `SKILL.md`, and give the frontmatter `description` concrete triggers
("Use when building a stepper, wizard, ..."), not a topic label. Do not restate
foundations rules; link to `design-foundations` instead.

Sources, authority order between them, and the coverage checklist this group is audited
against: [`agents/knowledge/shaping-web-ui-design.md`](../../agents/knowledge/shaping-web-ui-design.md).

# Web Design Skills

UI skills. Each one covers a single surface or dimension: how it should look, how it moves,
how it behaves for keyboard and screen-reader users, and what usually ships broken.

## Baseline and cross-cutting

| Skill | Covers |
| --- | --- |
| `design-foundations` | Tokens, spacing, hierarchy, surfaces, icons, gradients, motion timings, contrast, focus, dark mode. Shared baseline for every other skill here. |
| `visual-direction` | Choosing a direction and holding it: grounding in references, declaring the system, structural variation, asset sourcing, critique. |
| `typography-design` | Type roles, faces and weights, measure, wrapping, truncation, tabular numbers, underlines, optical trim. |
| `color-systems` | Ramp construction, step roles, notation and gamut, gradient interpolation, theme variants, palette audits. |
| `responsive-design` | Content-driven breakpoints, container queries, safe areas, full-bleed, overflow affordances, input capability. |
| `internationalization-design` | Text expansion, RTL mirroring, non-Latin scripts, locale formats, meaning that does not travel. |
| `motion-design` | Whether to animate, curves, physicality, gestures, page and shared-element transitions, scroll-driven motion, reduced motion. |
| `microcopy` | Buttons, labels, errors, empty states, confirmations, tone, draft content, translatable strings. |

## Surfaces

| Skill | Covers |
| --- | --- |
| `form-design` | Field anatomy, validation, inline editing, settings, multi-step forms, submit and autosave. |
| `button-and-action-design` | Hierarchy, labels, disabled and busy states, destructive and bulk actions, toolbars. |
| `navigation-design` | Sidebars, bottom bars, breadcrumbs, IA depth, search entry points, pagination, URL state. |
| `tab-design` | Tab bars, segmented controls, indicator motion, overflow, panel transitions. |
| `search-and-filter-design` | Search input, scopes, suggestions, ranking, snippets, filter chips, facets, applied filters, zero and empty results. |
| `data-table-design` | Column layout, sorting, selection, sticky headers, density, pagination. |
| `card-and-list-design` | Card anatomy, hover, click targets, grids, feeds, badges, reordering. |
| `chart-design` | Chart type choice, axis honesty, series color, tooltips, dashboards, accessible data tables. |
| `overlay-design` | Choosing between modal, sheet, drawer, popover, and inline; focus trapping and dismissal. |
| `feedback-design` | Loading, empty, error, success, toast, optimistic updates, and undo. |
| `collaboration-design` | Presence, live cursors, selection ownership, follow mode, conflict handling. |
| `landing-page-design` | Marketing page structure, hero, social proof, pricing, section order, conversion CTAs. |

## Verification

| Skill | Covers |
| --- | --- |
| `accessibility-audit` | Verification pass on shipped UI: keyboard, structure, contrast, screen reader, WCAG 2.2 AA reporting. |
| `frontend-performance` | Core Web Vitals, bundle size, images and fonts, hydration, re-renders, CI budgets. |

## Using them

Load `design-foundations` alongside any other skill; the rest assume its tokens and motion
scale rather than repeating them. The cross-cutting skills each own one dimension every
surface passes through: `design-foundations` defines the tokens, and they cover what happens
to text, color, space, language, and motion after the tokens exist. `visual-direction` runs
before the others on new work, when the question is still what this should look like.

`design-foundations` covers accessibility at design time; `accessibility-audit` verifies
what already shipped. For load and interaction speed, use `frontend-performance`.

## Adding a skill

Add one only when a rule has no owner and an agent would otherwise invent it from scratch.
Prefer extending an existing skill; prefer merging two that keep pointing at each other.
Keep the directory name lowercase kebab-case and the file named `SKILL.md`, and give the
frontmatter `description` concrete triggers ("Use when building a stepper, wizard, ..."),
not a topic label. Do not restate foundations rules; link instead.

Skills here carry no trailing checklist. State a verification action once, in the prose that
owns it, rather than restating rules as a list at the end.

Sources, authority order, the catalog this group is audited against, and what was reviewed
and declined: [`agents/knowledge/shaping-web-ui-design.md`](../../agents/knowledge/shaping-web-ui-design.md).

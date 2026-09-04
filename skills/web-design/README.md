# Web Design Skills

UI skills. Each one covers a single component, surface, or dimension: how it should look,
how it moves, how it behaves for keyboard and screen-reader users, and what usually ships
broken.

## Baseline and cross-cutting

| Skill | Covers |
| --- | --- |
| `ui-composition` | Intent, existing-system discovery, hierarchy, component mapping, overlay surface choice, state completeness, whole-screen verification. |
| `design-foundations` | Token layers and scales, z-index, layout and hierarchy, motion timings, contrast, focus, hit targets. Deliberately small: it loads with everything. |
| `visual-direction` | Choosing a direction and holding it: references, declaring the system, surface and optical craft, structural variation, assets, critique. |
| `typography-design` | Type roles, faces and weights, measure, wrapping, truncation, tabular numbers, underlines, optical trim. |
| `color-systems` | Ramp construction, step roles, notation and gamut, gradients, dark mode, theme variants, palette audits. |
| `responsive-design` | Content-driven breakpoints, container queries, safe areas, full-bleed, overflow affordances, input capability. |
| `internationalization-design` | Text expansion, RTL mirroring, non-Latin scripts, locale formats, meaning that does not travel. |
| `motion-design` | Whether to animate, curves, physicality, gestures, page and shared-element transitions, scroll-driven motion, reduced motion. |
| `microcopy` | Buttons, labels, errors, empty states, confirmations, tone, draft content, translatable strings. |

## Components

One component, one skill: its anatomy, states, keyboard contract, and failure modes.

| Skill | Covers |
| --- | --- |
| `button` | Element choice, variants, size and target, labels, loading and disabled, icons, split buttons. |
| `link` | Underlines and visited states, link text, new tabs and external links, anchors and skip links. |
| `text-input` | Label and helper order, width, keyboard type and autofill, eight states, counters, textareas. |
| `select-and-combobox` | Control choice by option count, menu behavior, search and async, multi-select chips, APG keyboard. |
| `checkbox-and-radio` | Which control, native inputs, groups and fieldsets, indeterminate select-all, card options, consent. |
| `toggle-switch` | Immediate-effect rule, anatomy and travel, optimistic network flips, dependencies, `role="switch"`. |
| `slider` | Numeric pairing, hit areas, filled track, steps and commit timing, dual handles, `aria-valuetext`. |
| `date-picker` | Typing first, presets, calendar marking, ranges, time zones, calendar keyboard contract. |
| `file-upload` | Click and drop, limits stated up front, per-file queue and progress, images and cropping, drag alternatives. |
| `password-input` | Paste and autocomplete tokens, reveal toggle, requirements and strength, confirmation fields, lockout. |
| `otp-input` | One logical value, paste and autofill, auto-advance and backspace, resend countdown, segment labeling. |
| `modal-dialog` | Native `<dialog>`, structure, confirmation content, dismissal and unsaved work, scrim, focus return. |
| `drawer-and-sheet` | Placement, snap points and gesture physics, scroll seam, non-modal drawers, URL state. |
| `popover-and-menu` | Menu vs popover, anchor positioning and collision, hover intent, submenus, APG menu keyboard. |
| `tooltip` | What must never be in one, hover delay and focus, placement, touch, WCAG hoverable content. |
| `icon-design` | One set and one grid, optical sizing, stroke matching, when an icon needs a label, mirroring. |
| `command-palette` | Fuzzy matching and ranking, rows and shortcut hints, nested modes, async commands, combobox semantics. |
| `toast` | What belongs in one, the five rules, placement, undo countdown, live-region announcement. |
| `alert-banner` | Placement by scope, severity without color alone, dismissal and persistence, writing. |
| `loading-indicators` | Spinner vs skeleton vs progress bar, honest progress, staged status, step indicators. |
| `empty-state` | The four kinds, first run as onboarding, in-table and in-widget cases, writing. |
| `card` | Anatomy order, padding and elevation, stretched links, hover without layout shift, selection. |
| `badge-and-tag` | Badge vs tag vs count, status without color alone, overflow caps, deterministic tag colors. |
| `avatar` | Fallbacks as the default case, shape and size scale, stacks, presence, alt text. |
| `accordion` | Whether to collapse at all, multi-open default, deep links, height animation, `<details>`. |
| `drag-and-drop` | Pickup and landing feedback, undo, keyboard and menu alternatives, canvases and dropzones. |
| `destructive-actions` | Protection by reversibility, confirmation copy, typed confirmation, danger zones, bulk scope. |

## Surfaces and flows

| Skill | Covers |
| --- | --- |
| `form-design` | Control choice, field order and layout, validation timing, error copy, multi-step, autosave, submit. |
| `navigation-design` | Sidebars, bottom bars, IA depth, active state, breadcrumbs, search entry points, pagination, URL state. |
| `tab-design` | Tab bars, segmented controls, indicator motion, overflow, panel transitions. |
| `search-and-filter-design` | Search input, scopes, suggestions, ranking, snippets, filter chips, facets, zero results. |
| `data-table-design` | Column layout, sorting, selection, sticky headers, density, pagination. |
| `card-and-list-design` | Grid vs list vs table, row density, virtualization, scroll restoration, row and swipe actions. |
| `chart-design` | Chart type choice, axis honesty, series color, tooltips, accessible data tables. |
| `dashboard-design` | Operational vs analytical, widget layout, KPI tiles, time range, refresh, drill-down. |
| `feedback-design` | Matching the pattern to the wait, notification surface choice, optimistic updates and undo, state completeness. |
| `collaboration-design` | Presence, live cursors, selection ownership, follow mode, conflict handling. |
| `ai-interface-design` | Chat and assistant surfaces, composer, streaming, citations, agent approvals, cost and limits. |
| `auth-flow-design` | Sign-in and sign-up, passkeys, one-time codes, reset and recovery, sessions and step-up. |
| `onboarding-design` | First run, activation path, checklists, coach marks, permission priming, feature announcements. |
| `media-design` | Players and controls, captions and transcripts, autoplay, galleries, lightboxes. |
| `landing-page-design` | Marketing page structure, hero, social proof, pricing, section order, conversion CTAs. |

## Verification

| Skill | Covers |
| --- | --- |
| `accessibility-audit` | Verification pass on shipped UI: keyboard, structure, contrast, screen reader, WCAG 2.2 AA reporting. |
| `frontend-performance` | Core Web Vitals, bundle size, images and fonts, hydration, re-renders, CI budgets. |

## Using them

Use `ui-composition` first for a page, screen, flow, or other multi-component task. It loads
`design-foundations`, inspects the existing system, and selects only the surface and
component skills the composition needs. For focused work on one established component, use
that component skill directly with `design-foundations`. Component skills own the control;
surface skills own the composition around it. `visual-direction` runs before implementation
when the visual system is new, unclear, or supplied through a reference.

`design-foundations` covers accessibility at design time; `accessibility-audit` verifies
what already shipped. For load and interaction speed, use `frontend-performance`.

## Adding a skill

Every essential component gets its own skill; that granularity is deliberate, so a request
for one control loads one file instead of a whole surface. Add a skill when a component or
surface has no owner, and extend rather than duplicate when it does. The counterweight is
load cost: `design-foundations` rides along with every task, so anything that only matters
while styling belongs in `visual-direction` or `color-systems`, not in the baseline. Keep the directory
name lowercase kebab-case and the file named `SKILL.md`, and give the frontmatter
`description` concrete triggers ("Use when building a stepper, wizard, ..."), not a topic
label. Do not restate foundations rules, and do not restate a component's rules in the
surface that uses it - link instead.

Skills here carry no trailing checklist. State a verification action once, in the prose that
owns it, rather than restating rules as a list at the end.

Sources, authority order, the catalog this group is audited against, and what was reviewed
and declined: [`agents/knowledge/shaping-web-ui-design.md`](../../agents/knowledge/shaping-web-ui-design.md).
After changing any `description` here, check the routing seams against
[`agents/knowledge/web-design-trigger-evaluations.md`](../../agents/knowledge/web-design-trigger-evaluations.md).

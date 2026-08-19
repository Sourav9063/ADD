---
name: filter-design
description: Build or review filtering and faceted search. Use when creating filter chips, a filter panel or sidebar, facets, sort controls, search refinement, applied-filter summaries, result counts, or range and date filters, and when filtered results come back empty.
---

# Filter Design

Assumes `design-foundations` for tokens, motion, and contrast.

Filtering is a loop: **choose → see the result change → understand why → undo cheaply.**
Break any link and users abandon the list or tap the same chip twice.

## Choose the surface

| Situation | Surface |
| --- | --- |
| 2–6 high-traffic facets, mobile-first | Chip row above results |
| Many facets, desktop | Left sidebar, always visible, results reflow |
| Many facets, mobile | Full-height sheet with sticky "Show 42 results" footer |
| One dominant facet | Dropdown or segmented control |
| Power users | Query bar / command palette with structured tokens |

Sort is not a filter. Keep it as its own control, on the right of the results header.

## Chips

Three visually distinct states, or the control reads as broken:

- **Idle** — surface fill + border, clearly tappable, not chosen.
- **Active** — filled with the accent, plus a check or a removable `×`. Must survive grayscale.
- **Disabled** — dimmed, with a tooltip or count of `0` explaining that nothing matches behind it.

Keep chips in one horizontally scrollable row with an edge fade. Wrapping to multiple
rows pushes results below the fold, which is the thing the user came for. Chip width must
not change on selection — reserve the space for the check so the row does not reflow.

## Make the logic visible

- **OR within a group** (Red *or* Blue → more results). **AND across groups** (Red shoes *and* under $50 → fewer). Say so in the UI when it is not obvious; users assume the opposite of whatever you chose.
- Show a **count next to every option** and update all counts the instant a selection changes. Stale counts are read as a failure and cause duplicate taps.
- Hide or disable zero-result options rather than letting people build an empty query — but never silently drop a facet the user already selected.

## Apply and feedback

- **Apply instantly** when results are cheap and visible. Use an explicit Apply button only in a mobile sheet or when each query is expensive — and then show the pending count on the button itself.
- Keep the result count live and prominent: `42 results`. Announce changes with `aria-live="polite"`.
- While refetching, dim or skeleton the list but keep the previous results in place and the controls interactive. Never blank the page.
- Debounce text-search input ~300ms; range sliders commit on release, not on drag.

## Applied filters must be visible and reversible

- A sticky summary row above the results shows every active filter as a removable chip, so users always know why the list looks like this.
- One **Clear all** with the live count next to it. Stacked filters trap people; one tap back to baseline is essential.
- Removing a filter is one tap on the chip's `×` — not "reopen the panel, find it, untick it".
- Treat query parameters as filter state: use stable names and repeated keys (`?status=open&status=pending`), omit defaults and empty values, and never hide the state in encoded JSON.
- Preserve search, sort, view, and unrelated parameters; reset page or cursor when a filter changes. Replace transient slider/text updates, but push committed changes that Back should undo.

## Range, date, and search facets

- Ranges: two labeled inputs plus the slider; touch cannot hit a 4px handle, so the numeric inputs are the accessible path, and handles need ≥44px hit areas. Show the distribution histogram when you have it.
- Dates: presets first (`Last 7 days`, `This month`), custom range second.
- Facet lists longer than ~8: show the top options, add an inline search, then "Show all (23)".

## Empty results

A filtered empty state is not a first-run empty state. Say which filters caused it, show
the applied chips, and offer the fix: remove the most restrictive filter, clear all, or
broaden the search. Never a bare "No results".

## Accessibility

- Chip groups are checkboxes (multi) or radios (single) — either real inputs styled as chips, or buttons with `aria-pressed`. A `<div onClick>` is not a filter.
- Group each facet in a `<fieldset>` with a `<legend>`, or a labelled `role="group"`.
- Result region: `aria-live="polite"` with a text summary ("42 results, filtered by Red, under $50").
- Mobile filter sheet follows `overlay-design`: focus trapped, Escape closes, focus returns to the trigger.
- Removable chips expose `aria-label="Remove filter: Red"`, and focus moves to the next chip (or the summary) after removal.

## Checklist

- [ ] Idle / active / disabled chips are unmistakably different.
- [ ] Counts and results update immediately; previous results stay visible while loading.
- [ ] Applied filters pinned and individually removable; one Clear all.
- [ ] Filters use stable query parameters; other state survives, pagination resets, and Back works.
- [ ] Single scrollable chip row, no wrapping, no reflow on selection.
- [ ] Filtered-empty state names the cause and offers a way out.

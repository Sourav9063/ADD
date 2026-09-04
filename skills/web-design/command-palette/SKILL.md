---
name: command-palette
description: Build or review a command palette. Use when adding ⌘K search-and-command UI, fuzzy matching over actions and records, grouped or ranked results, nested command modes, keyboard shortcut hints, or a quick switcher, and when deciding whether a product needs one at all.
---

# Command Palette

Assumes `overlay-design` for the surface and `search-and-filter-design` for ranking and
result presentation. ⌘K is a **system, not a search box**: it is the keyboard user's index
of everything the product can do, and it earns its place only in a product with enough
surfaces and actions that navigating them by pointer is slow.

## Matching and ranking

- **Fuzzy subsequence matching**, not substring: `stg` finds Settings, Storage, and Staging. Highlight the matched characters in each result so the match is legible.
- Rank by a stable combination of match quality, recency, and frequency - the thing the user picked last time for this query goes first.
- Group results by type with headers (Actions, Projects, People, Navigation) and keep the group order fixed so muscle memory works.
- Show recents, or the most useful default actions, when the input is empty. An empty palette wastes the moment the user opened it.
- Cap results per group with a "show more" rather than flooding one group.

## Rows

- One action per row: an icon, the label as a verb where it acts ("Create issue"), and secondary context on the right (the project it belongs to, the type).
- **Show the keyboard shortcut** on rows that have one. The palette is where power users learn shortcuts and stop needing the palette.
- Never put two actions in a row, and never make a row's secondary text the only thing distinguishing two identical labels.
- Disabled commands explain the condition inline or are filtered out entirely.

## Modes and nesting

- Commands that need an argument drill into a sub-mode: "Move to project…" opens a project list inside the palette, with a **breadcrumb** showing the mode.
- **Escape walks back one level** before it closes the palette. Closing straight out of a three-step command loses the user's work.
- Prefix modes (`>` for commands, `@` for people, `#` for issues) are a shortcut, not the only path; every mode must be reachable by typing its name.
- Keep nesting to one level deep. A palette is not a wizard.

## Async and long work

- Debounce remote search ~150-250ms and **keep the previous results visible while fetching**; blanking the list on every keystroke makes the palette feel broken.
- Show a loading row inside the list rather than replacing it, and a distinct no-results state that echoes the query and offers the nearest action ("Create «query»").
- An async command runs with a spinner inline in the palette, which **stays open** and reports the result; never freeze the screen behind it.
- Failures report in place with a retry, not as a toast behind a closed palette.

## Entry and behavior

- ⌘K on macOS, Ctrl+K elsewhere, plus a visible trigger in the UI - most users will never discover a shortcut-only feature.
- The shortcut works from anywhere except inside a text field where it would conflict, and it closes the palette when pressed again.
- Opening focuses the input with any previous query selected, so typing replaces it.
- Enter runs the active row, ⌘Enter opens it in a new tab where that makes sense, arrows move, Home and End jump, and the active row always scrolls into view.
- Preserve nothing between sessions except recents; a stale query on reopen is worse than an empty one.

## Accessibility

- The input is `role="combobox"` with `aria-expanded` and `aria-controls`; the list is a `listbox` of `option`s, with `aria-activedescendant` marking the active row while focus stays in the input.
- Announce the result count on update, politely, and announce mode changes ("Move to project, 12 results").
- The palette is a modal dialog: labelled, focus-trapped, Escape-dismissible, with focus returned to where it came from (`modal-dialog`).
- Rows meet the target minimum and are usable with the pointer too - it is not a keyboard-only feature.
- Never make the palette the only route to an action. Everything in it must exist somewhere in the visible UI.

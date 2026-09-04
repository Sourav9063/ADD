---
name: search-and-filter-design
description: Build or review search and filtering. Use when creating a search input, autosuggest, scopes, query syntax, relevance ranking, result snippets, filter chips, facet panels, sort controls, applied-filter summaries, or result counts, and when search returns nothing, returns the wrong thing, feels slow, or filtered results come back empty.
---

# Search and Filter Design

Assumes `design-foundations`. `navigation-design` owns where the entry point sits and the
URL-state rules; `command-palette` owns the palette and `drawer-and-sheet` the mobile filter sheet.

One task in two halves: **search** produces a result set, **filters** narrow it. Both run
the same loop, and breaking any link makes users abandon the list or repeat the action:

**act → see the result change → understand why → undo cheaply.**

Products ship the input and the chip row, then treat suggestion, ranking, recovery, and
applied-state as later work. That is why search is usually the worst screen in the app.

## Input

- One search box per surface: magnifier icon, real label or `aria-label`, and a clear (`×`) that returns focus to the field.
- `<input type="search">` in a real `<form>` with `role="search"`. Enter submits, Escape clears, `/` or ⌘K may focus it as a shortcut but never as the only path.
- Placeholder names what is searchable ("Search invoices, clients, notes"), not the word "Search".
- ~27 visible characters is where users stop truncating what they type.
- Debounce ~200–300ms, discard stale responses, and keep previous results on screen while the next set loads. Never search the server on every keystroke.
- Persist the query after submit. Clearing it forces retyping to refine.

## Scope

Scope decides which index answers; filters narrow what it returned. Show scope before
results, filters after. State the current scope beside the input and make it changeable
without retyping ("in Invoices ▾"), defaulting to the surface the user searched from, with
"Search everything" as one-tap escalation from a thin result set.

## Suggestions

On focus, before typing: recent searches (most useful, most skipped), then saved, then
popular. Cap ~5 per group with a label.

- After typing, mix **query completions** with **direct results**, visually distinct; a direct hit skips the results page.
- Bold the completion, not the typed part, so the eye reads what is new.
- Group by type with a header and an icon, one line per row, never wrapping.
- **Rank by clicks and popularity, never alphabetically.** Alphabetical order is the tell of an unranked index. Three well-chosen suggestions beat ten noisy ones.
- Arrows move, Enter opens, Escape closes and keeps the query. Never reorder while the user is arrowing, and never let a late response replace a highlighted row.
- The panel never blocks submitting the raw query.

## Query understanding

- **Tolerate typos** before showing zero results: edit distance 1–2, more on longer terms. "Recieve" must find "receive".
- Handle synonyms and product vocabulary (`login` / `sign in`), plurals, case and accent folding.
- Prefix-match identifiers and codes; users type the first characters of an order number, not the middle.
- Multiple words are AND by default; say so when a result matches only some terms.
- Support quoted phrases, and operators (`from:`, `is:open`, `-excluded`) only if you document them inline, echo how you parsed them, and degrade to plain text on failure. Silent operator behavior turns an email address into a broken query.
- Ignore leading and trailing whitespace, and never fail on a query containing a symbol.

## Results

- Every row answers "why is this here?": title, snippet with the match highlighted (`<mark>`), type, and location. Center the snippet on the match rather than the document start, and skip highlighting inside the title where it wrecks the title's legibility.
- State the count and the interpreted query above the list: `42 results for "overdue invoice"`. If you corrected, expanded, or dropped a term, say so and offer the literal search.
- Rank by relevance; expose sort as a separate control; label promoted rows.
- Best result above the fold, not below a row of facets.
- **Model five states, never one shared blank:** no query yet, loading, results, no matches, and search failed. Collapsing them is why an outage looks identical to an empty index.
- Paginate or infinitely load per `navigation-design`, keeping query, scope, filters, and page in the URL so a result set is linkable and survives Back.
- Sub-100ms for suggestions or users out-type the panel. Under 300ms show nothing, then a skeleton in the result-row shape. Cache recent queries client-side and serve the focus panel locally.
- Do not block the page shell on the search response; stream results in.

## Choosing a filter surface

| Situation | Surface |
| --- | --- |
| 2–6 high-traffic facets, mobile-first | Chip row above results |
| Many facets, desktop | Left sidebar, always visible, results reflow |
| Many facets, mobile | Full-height sheet with sticky "Show 42 results" footer |
| One dominant facet | Dropdown or segmented control |
| Power users | Query bar with structured tokens |

Sort is not a filter. Keep it its own control, right of the results header.

## Chips and facets

Three unmistakable states, or the control reads as broken: **idle** (surface fill + border),
**active** (accent fill plus a check or removable `×`, surviving grayscale), **disabled**
(dimmed, with a count of `0` explaining why).

- One horizontally scrollable row with an edge fade. Wrapping pushes results below the fold, which is the thing the user came for. Reserve the check's width so selection does not reflow the row.
- **OR within a group, AND across groups.** Say so in the UI; users assume the opposite of whatever you chose.
- Show a count next to every option and update all counts the instant a selection changes. Stale counts read as failure and cause duplicate taps.
- Hide or disable zero-result options rather than letting people build an empty query, but never silently drop a facet the user already selected.
- Ranges: two labeled inputs plus the slider, per `form-design`, with a distribution histogram above the track when you have one. Sliders commit on release, not on drag. Dates: presets first, custom range second. Facet lists past ~8: top options, inline search, then "Show all (23)".
- Apply instantly when results are cheap. Use an explicit Apply only in a mobile sheet or when queries are expensive, with the pending count on the button.
- While refetching, dim or skeleton the list but keep previous results and interactive controls. Never blank the page.

## Applied state must be visible and reversible

- A sticky summary above the results shows every active filter as a removable chip, so users always know why the list looks like this.
- One **Clear all** with the live count beside it. Stacked filters trap people; one tap back to baseline is essential.
- Removing a filter is one tap on its `×`, never "reopen the panel, find it, untick it".
- Query, scope, filters, sort, and page live in stable query parameters (`?status=open&status=pending`), not encoded JSON. Omit defaults, preserve unrelated parameters, reset pagination when a result-defining parameter changes.
- **Treat the URL as the initial source of truth.** Replace intermediate typing so Back does not replay every keystroke; push committed searches worth returning to. Getting this backwards makes Back useless for the rest of the session.
- Restore scroll position and the query when the user returns from a result.

## Empty and zero results

The most common failure and the least designed screen. Never a bare "No results".

Echo the query and the applied chips, then give a way forward in this order: spelling
correction, broader scope, remove the most restrictive filter, clear all, related content.
Distinguish **no matches** from **no data yet**, **too many filters**, **query too short**,
and **search failed**; each needs different copy and a different action (see
`feedback-design`). A filtered-empty state is not a first-run empty state.

Log zero-result queries. They are the highest-signal backlog in the product: they name what
users expect to exist.

## Accessibility

- Combobox: input has `role="combobox"`, `aria-expanded`, `aria-controls`, and `aria-activedescendant` on the highlighted option. Focus stays in the input; the highlight moves. Options are `role="option"` with `aria-selected`, in a `role="listbox"`.
- The panel closes on Escape and on blur, and focus is never stranded in a suggestion list that has been detached.
- Chip groups are checkboxes (multi) or radios (single), or buttons with `aria-pressed`. A `<div onClick>` is not a filter. Group each facet in a `<fieldset>` with a `<legend>`.
- Result region is `aria-live="polite"` with a text summary ("42 results, filtered by Red, under $50"), announced on each settled query, not each keystroke.
- Removable chips expose `aria-label="Remove filter: Red"`, and focus moves to the next chip after removal.
- The mobile filter sheet follows `drawer-and-sheet`: focus trapped, Escape closes, focus returns to the trigger.
- `<mark>` needs sufficient contrast; matching by background color alone fails.

Before handing off, run the whole loop keyboard-only with a typo'd query: it should
correct, show why each row matched, filter, clear, and reproduce the view on refresh.

---
name: search-design
description: Build or review a search experience. Use when creating a search input or search page, autosuggest and typeahead, scopes, recent or saved searches, query syntax and operators, relevance ranking, result snippets and highlighting, or when search returns nothing, returns the wrong thing, or feels slow.
---

# Search Design

Assumes `design-foundations` for tokens and focus. `filter-design` owns refining a result
set once it exists, `navigation-design` owns where the entry point lives, `overlay-design`
owns the command palette. This skill owns the query itself: typing it, understanding it,
ranking it, and showing what came back.

Search is a system with four parts: **input → suggestion → results → recovery.** Products
ship the input and treat the other three as later work, which is why search is usually the
worst screen in the app.

## Input

- One search box per surface, with a magnifier icon, a visible label (or `aria-label`), and a clear (`×`) button that also returns focus to the field.
- `<input type="search">` inside a real `<form>` with `role="search"` on the landmark. Enter submits, Escape clears the current query, `/` or ⌘K may focus it as a shortcut, never as the only path.
- Placeholder shows the *kind* of thing that is searchable ("Search invoices, clients, notes"), not the word "Search". It is a hint, not the label.
- Keep the box wide enough for a real query: ~27 characters visible is the point where users stop truncating what they type.
- Never search on every keystroke against the server. Debounce ~200–300ms, cancel or discard stale responses, and keep the previous results on screen while the next set loads.
- Persist the query in the box after submit. Clearing it forces retyping to refine.

## Scope

- If the product searches more than one type of thing, state the current scope beside the input and make it changeable without retyping ("in Invoices ▾").
- Scoping is not filtering: scope decides which index answers, filters narrow what it returned. Show the scope before results, filters after.
- Default to the scope of the surface the user searched from, and offer "Search everything" as a one-tap escalation from a thin result set.

## Suggestions

Show a panel on focus, before typing:

- Recent searches (most useful, most skipped), then saved searches, then popular or suggested entries. Cap at ~5 each with a clear label per group.
- After typing, mix **query completions** ("invoice template") with **direct results** ("Invoice #4417"), visually distinguished; a direct hit skips the results page entirely.
- Bold the *completion*, not the typed part, so the eye reads what is new.
- Group by type with a header and an icon; one line per row, no wrapping.
- Arrow keys move, Enter opens, Escape closes the panel and keeps the query, Tab completes inline if you offer inline completion at all.
- Never reorder the list while the user is arrowing through it, and never let a late response replace a highlighted row.
- Suggestions must be optional: the panel never blocks submitting the raw query.

## Query understanding

- **Tolerate typos.** Fuzzy match (edit distance 1–2, more on longer terms) before showing zero results. "Recieve" must find "receive".
- Handle synonyms and product vocabulary (`login` / `sign in`, `SKU` / `item code`), plurals, and case and accent folding.
- Match on prefixes for identifiers and codes; users type the first characters of an order number, not the middle.
- Treat multiple words as AND by default, and say so when a result matches only some terms.
- Support quoted phrases and a small operator set (`from:`, `is:open`, `-excluded`) only if you document it inline, echo how you parsed it, and degrade to plain text when parsing fails. Silent operator behavior turns an email address into a broken query.
- Ignore leading and trailing whitespace, and never fail on a query that contains a symbol.

## Results

- Answer the question "why is this here?" in every row: title, a snippet with the matched term highlighted (`<mark>`), the type, and the location or path.
- Highlight matches in the snippet, not in the title if it wrecks the title's legibility; center the snippet on the match rather than starting at the beginning of the document.
- State the count and the interpreted query above the list: `42 results for "overdue invoice"`. If you corrected, expanded, or dropped a term, say it and offer the literal search: *Showing results for **receive**. Search instead for "recieve".*
- Rank by relevance by default, expose sort as a separate control, and never mix ads or promoted rows in without a visible label.
- Keep the first screen useful: the best result belongs above the fold, not below a row of facets.
- Paginate or infinitely load, but keep the query, scope, filters, and page in the URL (`?q=…`) so a result set is linkable and survives Back, under the URL-state rules in `navigation-design`.
- **Treat the URL as the initial source of truth**, and be careful which updates enter history: replace intermediate typing updates so Back does not replay every keystroke, and push only a committed search the user should be able to return to. Getting this backwards makes the Back button useless for the rest of the session.
- Restore scroll position and the query when the user returns from a result.

## Zero results

The most common failure and the least designed screen. Never a bare "No results".

- Echo the query, then give at least one way forward, in this order: spelling correction, a broader scope, removal of the most restrictive filter (see `filter-design`), and related or popular content.
- Distinguish **no matches** from **no data yet**, **too many filters**, **query too short**, and **search failed**; each needs different copy and a different action (see `feedback-design`).
- Log zero-result queries. They are the highest-signal backlog in the product: they name what users expect to exist.

## Performance

- Sub-100ms for suggestions; anything slower and users out-type the panel. Cache recent queries client-side and serve the empty-state panel locally.
- Show nothing for waits under 300ms, then a skeleton in the result-row shape, keeping the previous results dimmed rather than blanking the page.
- **Model five distinct states, never one shared blank:** no query yet, loading, results, no matches, and search failed. Collapsing them is why an outage looks identical to an empty index.
- Do not block the page shell on the search response; stream results in.

## Accessibility

- Combobox pattern: input has `role="combobox"`, `aria-expanded`, `aria-controls` pointing at the listbox, and `aria-activedescendant` on the highlighted option. Focus stays in the input; the highlight moves.
- Options are `role="option"` with `aria-selected`; the container is `role="listbox"`.
- Announce the result count in a polite live region on each settled query, not on each keystroke.
- Highlighted match text must not be the only cue: `<mark>` needs sufficient contrast, and matching by background color alone fails.
- The panel closes on Escape and on blur, and focus never gets stranded in a detached suggestion list.

## Checklist

- [ ] Query persists after submit; clear button returns focus; Enter submits a real form.
- [ ] Focus panel shows recent and suggested entries before any typing.
- [ ] Typos, synonyms, and prefixes match; parsing failures degrade to plain text.
- [ ] Every row shows why it matched; count and interpreted query stated above the list.
- [ ] Corrections are disclosed with a way back to the literal query.
- [ ] Zero results names the cause and offers a correction, a broader scope, or related content.
- [ ] All five states distinguished: no query, loading, results, no matches, failure.
- [ ] Query, scope, filters, and page live in the URL; typing replaces history, committed searches push it; Back and refresh reproduce the view.
- [ ] Combobox ARIA wired; result counts announced politely; keyboard-only search works end to end.

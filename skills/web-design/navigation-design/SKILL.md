---
name: navigation-design
description: Build or review app navigation and information architecture. Use when creating a sidebar, top bar, bottom tab bar, hamburger or mobile menu, breadcrumbs, nested or sectioned navigation, search entry points, pagination, or when deciding where a new page or feature belongs.
---

# Navigation Design

Assumes `design-foundations` for tokens and focus rules; `tab-design` owns in-page tabs,
`overlay-design` owns drawers and command palettes.

Choose by **platform and depth, not taste**. Navigation is one system across breakpoints,
not a desktop layout with a smaller variant.

## Pick the pattern

| Context | Pattern |
| --- | --- |
| Mobile, 3–5 primary destinations | **Bottom tab bar**: always visible, thumb-reachable, icon + label |
| Mobile, 6+ destinations | Bottom bar of the top 4 + a "More" sheet |
| Desktop, 5+ sections or nesting | **Persistent sidebar**, collapsible to icons with labels on hover/focus |
| Desktop, ≤5 flat sections, marketing | Top bar |
| Hierarchy deeper than two levels | Breadcrumbs above the page title |
| Power users | Command palette (⌘K) **in addition to** visible navigation |

**Never hide primary navigation behind a hamburger.** Measured engagement drops around 40%
on mobile and over 50% on desktop when the primary destinations are one tap away instead
of zero. The hamburger is for secondary items: settings, help, account.

A command palette is never the only path to a feature; new users cannot discover what they
cannot see. Breadcrumbs in a flat structure are clutter, not orientation.

## Structure

- 5–7 top-level items. More than that means the IA is wrong, not that you need scrolling.
- Two levels of nesting max. A third level belongs to in-page tabs or a section sidebar.
- Group with labeled sections and spacing once you pass ~7 items.
- Labels are the user's nouns, 1–2 words, consistent with the page title they lead to. If you cannot name it in two words, the grouping is wrong.
- Icons need labels. Icon-only navigation is a memory test that regular users fail on anything but the top 4 items.
- Put destructive or rarely used items (Sign out, Billing) away from frequent ones.

## Active and current state

- The current item is unmistakable: accent bar/pill fill + weight change + color, not color alone. It must survive grayscale.
- Set `aria-current="page"` on the active link; the visual state is not exposed otherwise.
- Highlight the parent section when a child route is active, and expand that group by default.
- Never let hover styling look like the active state.

## Behavior

- Navigation is `<a href>`: real links, real middle-click, real Back. `onClick` handlers that push routes break every user habit at once.
- Preserve sidebar scroll position and expanded groups across navigations.
- Collapsed/expanded sidebar state persists per user.
- Prefetch on hover/focus for instant transitions; show a top progress bar only past ~300ms.
- Mobile menus follow `overlay-design`: focus trapped, Escape closes, focus returns to the toggle, background scroll locked.
- Respect safe areas (`env(safe-area-inset-bottom)`) on bottom bars, and keep them out of the way of the keyboard.
- Do not auto-hide navigation on scroll unless the screen is content-first; if you do, reveal it instantly on upward scroll.

## Search

Once content exceeds what a menu can list, search becomes navigation. Put it in the header
at every breakpoint, never behind the hamburger, and keep it reachable by keyboard from
anywhere. `search-design` owns the input, suggestions, ranking, results, and zero-result
recovery; this skill only decides that the entry point exists and where it sits.

Use a GET form and keep the term in a readable query parameter (`?q=invoice`) so search is
linkable, refresh-safe, and progressively enhanced, under the URL-state rules below. Never
put secrets or sensitive personal data in a URL.

## Pagination

- Use **cursor pagination on frequently changing data**: offset drifts, so inserting a row at the top makes the same item appear on two pages.
- Numbered pagination when people jump around or cite positions; Load more for on-demand lists; infinite scroll only for feeds, never above a footer and never for records users must audit.
- Collapse long ranges to first, last, current, and neighbors with an ellipsis. Never render hundreds of links.
- Put page or opaque cursor in the query string and make pagination controls real links with complete `href`s. Preserve search, filters, sort, and unrelated parameters; reset pagination when any result-defining parameter changes.
- Validate invalid or out-of-range URL values into a safe canonical state. Restore scroll position when returning from a detail view, but move focus to the result heading after an explicit page change.

## URL state

Search, filters, sort, view/tab, page or cursor, and page size belong in stable query
parameters when they change what the result view means. Omit defaults and empty values,
use repeated keys for multi-select values instead of encoded JSON, preserve unrelated
parameters, and derive initial controls from the URL so refresh, sharing, and Back agree.
Use `replaceState` for transient changes and `pushState` for committed states worth
returning to.

## Accessibility

- `<nav>` landmarks with distinct `aria-label`s ("Main", "Breadcrumb", "Footer") when there is more than one.
- Skip link as the first focusable element.
- Expandable groups are `<button aria-expanded>` controlling the list; arrow keys are optional, Enter/Space are not.
- Breadcrumbs: ordered list, last item is the current page and not a link, with `aria-current="page"`.
- Announce route changes: move focus to the new page's `<h1>` so screen reader users learn the view changed.

## Checklist

- [ ] Primary destinations visible at every breakpoint; hamburger holds secondary only.
- [ ] Bottom bar on mobile, sidebar on desktop, chosen by depth not by reuse.
- [ ] Active state distinct from hover, plus `aria-current`; parent highlights for child routes.
- [ ] Real anchors; scroll, expansion, and collapse states persist.
- [ ] Breadcrumbs only past two levels; command palette supplements, never replaces.
- [ ] Search and result state use stable query parameters; Back, refresh, and shared links reproduce the view.
- [ ] Pagination uses real links, retains the query, resets when criteria change, and restores scroll on return.

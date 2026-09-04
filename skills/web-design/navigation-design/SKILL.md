---
name: navigation-design
description: Build or review app navigation and information architecture. Use when creating a sidebar, top bar, bottom tab bar, hamburger or mobile menu, breadcrumbs, nested or sectioned navigation, search entry points, pagination, or when deciding where a new page or feature belongs.
---

# Navigation Design

Assumes `design-foundations` for tokens and focus rules. `tab-design` owns in-page tabs,
`drawer-and-sheet` the mobile menu surface, `command-palette` the ⌘K index, and `link` the
items themselves. Breadcrumbs live here, since nobody builds one without the surrounding
information architecture.

Choose by **platform and depth, not taste**. Navigation is one system across breakpoints,
not a desktop layout with a smaller variant.

## Pick the pattern

| Context | Pattern |
| --- | --- |
| Mobile, 3-5 primary destinations | **Bottom tab bar**: always visible, thumb-reachable, icon + label |
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

- 5-7 top-level items. More than that means the IA is wrong, not that you need scrolling.
- Two levels of nesting max. A third level belongs to in-page tabs or a section sidebar.
- Group with labeled sections and spacing once you pass ~7 items.
- Labels are the user's nouns, 1-2 words, consistent with the page title they lead to. If you cannot name it in two words, the grouping is wrong.
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
- Mobile menus follow `drawer-and-sheet`: focus trapped, Escape closes, focus returns to the toggle, background scroll locked.
- Respect safe areas (`env(safe-area-inset-bottom)`) on bottom bars, and keep them out of the way of the keyboard.
- Do not auto-hide navigation on scroll unless the screen is content-first; if you do, reveal it instantly on upward scroll.

## Breadcrumbs

Breadcrumbs answer two questions: where am I, and how do I go up. They are not a history
trail and not a substitute for primary navigation.

- Earn their place with a real hierarchy at least three levels deep, where users arrive mid-tree from search, links, or notifications. On a flat or two-level product they are clutter, and a trail reading `Home / Settings` should be deleted in favour of the page title.
- Show the **hierarchy, not the path taken**. A trail that reflects click history changes under the same URL and teaches nothing about the structure. Where two paths reach one page, pick the canonical one and hold it.
- One per page, directly above the page title, on one line. The current page is the last item, plain text rather than a link, marked `aria-current="page"`.
- Separators are decorative: a `/` or `›` in a muted color, generated in CSS or marked `aria-hidden`, so a screen reader never reads "Projects slash Acme slash Invoice".
- **Truncate the middle, not the ends.** The root and the immediate parent carry the navigational value; collapse what is between them into a `…` that opens the hidden ancestors in a menu (`popover-and-menu`). Truncate long individual names with a max width, keeping the full name available on focus.
- On narrow screens collapse to a single "← Parent name" back link; a wrapped three-line breadcrumb is worse than one clear way up.
- Each ancestor is a real link to that ancestor's own view, not to a filtered version of the current one. Never animate the trail, and never leave an empty gap while it loads - use a placeholder pill (`loading-indicators`).
- Wrap in `<nav aria-label="Breadcrumb">` around an ordered list, and pad the items vertically to reach the 24px target minimum.

## Search

Once content exceeds what a menu can list, search becomes navigation. Put it in the header
at every breakpoint, never behind the hamburger, and keep it reachable by keyboard from
anywhere. `search-and-filter-design` owns the input, suggestions, ranking, results, and zero-result
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
- Announce route changes: move focus to the new page's `<h1>` so screen reader users learn the view changed.

---
name: breadcrumb
description: Build or review breadcrumbs. Use when showing hierarchy and location in a nested product, deciding whether a page needs breadcrumbs at all, handling truncation and overflow on narrow screens, deep or dynamic paths, or a back link on mobile.
---

# Breadcrumb

Assumes `navigation-design` for the surrounding information architecture and `link` for the
items themselves. Breadcrumbs answer two questions: **where am I, and how do I go up?**
They are not a history trail and not a substitute for primary navigation.

## When they earn their place

- The product has a real hierarchy at least three levels deep (Workspace → Project → Document), and users arrive mid-tree from search, links, or notifications.
- Skip them on a flat product, on a two-level app, and on a page whose parent is already the only visible nav.
- One breadcrumb per page, directly above the page title, never duplicated at the bottom.
- If the trail would be `Home / Settings`, delete it and keep the page title.

## Structure

- Show the **hierarchy**, not the path the user took. A trail that reflects click history changes under the same URL and teaches nothing about the structure.
- The current page is the last item, styled as text, not a link, and marked `aria-current="page"`.
- Include the ancestor chain up to a meaningful root - the workspace or section, not necessarily "Home" if the product has no home.
- Separators are decorative and hidden from assistive tech: a `/` or `›` in a muted color, generated with CSS or marked `aria-hidden`, never a comma that reads as prose.
- Keep the whole trail on one line. It is a location indicator, not content.

## Long and dynamic paths

- Truncate the **middle**, not the ends: the root and the immediate parent are the two items with actual navigational value. Collapse the middle into a `…` that opens the hidden ancestors in a menu (`popover-and-menu`).
- Truncate individual long names with an ellipsis and a max width, keeping the full name available on hover and focus, and always showing the last few characters when the tail distinguishes items.
- On narrow screens, collapse to a single **"← Parent name"** back link. A wrapped three-line breadcrumb is worse than one clear way up.
- Never let a breadcrumb item render as an empty gap while data loads; use a skeleton pill of plausible width (`skeleton`).
- Dynamic segments that the user renames must update everywhere the trail is cached.

## Behavior

- Each ancestor is a real link - middle-click, Back, and copy-link all work.
- Clicking an ancestor goes to that ancestor's own view, not to a filtered version of the current one.
- The trail reflects the URL. If the page can be reached by two paths, pick the canonical hierarchy and use it consistently rather than switching per referrer.
- Do not animate the trail on navigation; it is chrome, and movement there is distracting.

## Accessibility

- Wrap in `<nav aria-label="Breadcrumb">` containing an ordered list. The label matters because a page usually has several navigation landmarks.
- The current page is present in the list as plain text with `aria-current="page"` - do not omit it, and do not link it to itself.
- Separators must not be announced; a screen reader reading "Projects slash Acme slash Invoice" is the classic symptom of markup separators.
- The trail meets contrast as real text; muted gray at 3:1 is a common failure here.
- Keep hit targets at the 24px minimum, which usually means padding the items vertically rather than relying on the text's own line box.

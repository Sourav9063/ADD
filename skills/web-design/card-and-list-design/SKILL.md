---
name: card-and-list-design
description: Build or review collections. Use when choosing between a grid, list, feed, and table, laying out a card grid or a long list, setting row density and separators, virtualizing, preserving scroll position, or handling list reordering and drag and drop.
---

# Card and List Design

Assumes `design-foundations` for tokens and motion, and `card`, `avatar`, and
`badge-and-tag` for the pieces inside an item. `data-table-design` owns comparable record
sets; use a table when users scan one attribute down a column, a list when they scan whole
items, and a grid when the visual is the content.

## Lists

- Row height from the density tokens (compact 36 / default 48 / comfortable 60). Separators are hairlines or spacing, not both.
- Leading element (avatar, icon, checkbox) at a fixed width so the text column aligns down the whole list.
- Metadata is right-aligned and secondary; keep it from competing with the primary label.
- Sticky section headers on long grouped lists.
- Virtualize past ~100 rows, but keep item heights stable so the scrollbar does not jump.
- Preserve scroll position when returning from a detail view.

## Grids

- Responsive by content width, not by device: `repeat(auto-fill, minmax(280px, 1fr))`.
- Consistent gaps from the space scale; the same gap horizontally and vertically unless the design deliberately says otherwise.
- Reserve aspect ratios on media (`aspect-ratio`) so images do not shift the layout as they load.
- Avoid a lone orphan card on the last row where an adjusted `minmax` would prevent it.

## Row actions

- Reordering, kanban columns, and any pointer-dragged move follow `drag-and-drop`, including its keyboard and menu alternatives.
- **Swipe actions** on a list row: at most two per direction, with consistent colors and directions across the whole app, and a peek affordance so they are discoverable at all.
- A partial swipe reveals the action; it never fires it. Full-swipe-to-delete with no confirmation and no undo is how people lose data on a phone in their pocket (`destructive-actions`).
- Every swipe action has a visible non-gesture path in the row's overflow menu, since a gesture is not accessible on its own.
- Hover-revealed row actions are permanently visible on touch and for keyboard users, anchored in a reserved column so the row does not reflow.

## Loading and empty

Skeleton items in the real grid or row shape, 3-6 of them, matching the final aspect ratio
(`loading-indicators`). The four kinds of empty state, and which one this collection needs, are
`empty-state`.

## Accessibility

- A collection is a real `<ul>` or `<ol>` of `<li>`s, so its length is announced and its items are navigable as a list.
- Every item in a grid must be reachable in a sane tab order: one stop per item, plus its actions.
- Selectable items use a real checkbox or `role="option"` inside `role="listbox"` with `aria-selected`, not a colored border alone.
- Announce list length and filtered counts in a polite live region.
- Sticky headers must not obscure the focused item as the user tabs through a long list.

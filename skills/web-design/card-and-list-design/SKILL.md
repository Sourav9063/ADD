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

## Reordering and drag and drop

- The board must reflect the drag: on pickup the item scales up, deepens its shadow, and tilts slightly - all three together, or it reads as a sticky click rather than a lift. The source leaves a placeholder gap, and neighbors animate aside to show exactly where the drop lands.
- Show the landing position **before release**, not after: an insertion line between items, a filled highlight for dropping into a container. On a structured surface snap to the nearest valid slot and outline the valid targets during the drag; reserve free positioning for canvases.
- Pair every drop with a brief undo, the same way a delete gets one. A drag that lands in the wrong column is as costly as a mis-click and just as easy to make.
- Grab targets need a visible handle; the whole card being draggable makes text unselectable and scrolling unreliable on touch.
- Auto-scroll near container edges; animate the drop into place rather than snapping.
- **Always provide a non-drag path**: "Move up/down" in the overflow menu, or keyboard reordering with Space to pick up, arrows to move, Space to drop, Escape to cancel. Announce each move in a live region.
- Persist optimistically and revert visibly on failure.

## Loading and empty

Skeleton items in the real grid or row shape, 3-6 of them, matching the final aspect ratio
(`skeleton`). The four kinds of empty state, and which one this collection needs, are
`empty-state`.

## Accessibility

- A collection is a real `<ul>` or `<ol>` of `<li>`s, so its length is announced and its items are navigable as a list.
- Every item in a grid must be reachable in a sane tab order: one stop per item, plus its actions.
- Selectable items use a real checkbox or `role="option"` inside `role="listbox"` with `aria-selected`, not a colored border alone.
- Announce list length and filtered counts in a polite live region.
- Sticky headers must not obscure the focused item as the user tabs through a long list.

---
name: card-and-list-design
description: Build or review cards, lists, and collection layouts. Use when creating a card, card grid, feed, list or list item, tile, media object, avatar, badge or tag, when handling card hover and click targets, list reordering or drag and drop, or choosing between a grid, list, and table.
---

# Card and List Design

Assumes `design-foundations` for tokens and motion. `data-table-design` owns comparable
record sets; use a table when users scan one attribute down a column, a list when they
scan whole items, and a grid when the visual is the content.

## Card anatomy

Fixed order: media → eyebrow/meta → title → description → metadata → actions. Repeat it
across every card in the product; scanning depends on the position being predictable.

- **Generous padding** — 20–24px in dense UI, up to 40px for marketing cards. Cramped padding is the single strongest "cheap" signal.
- **Radius** from the token scale; nested media radius = outer radius − padding.
- **Two shadows, not one**: a tight dark one for contrast plus a wide soft one for ambience. Add a hairline border at ~10–12% opacity so the edge exists on any background.
- **Hierarchy through weight and opacity**: title at 600, body at ~60–70% of the title's emphasis. Equal weight everywhere means nothing is read first.
- Truncate titles at 2 lines and descriptions at 3 (`line-clamp`), with the full text available on the detail view — never in a tooltip only.
- Equal-height cards in a row; align the action row to the bottom with `margin-top: auto` so ragged content does not stagger the buttons.

## Hover and interaction

- Lift ~8px and expand the shadow over ~200ms `ease-out`. Faster reads as twitchy, slower feels stuck.
- **Never scale the whole card** — it shifts neighbors and breaks the grid. Scale the *image* to ~1.05 inside an `overflow: hidden` frame so the content presses against the glass while the outer box stays fixed.
- Reveal secondary actions staggered ~60ms apart, anchored to a reserved row so nothing reflows. On touch and for keyboard users those actions must be permanently present — hover-only actions do not exist on a phone.
- An interactive card needs a real focus style, not just a hover style, and a cursor/border cue that it is clickable at all.

## Click targets

Nested links inside a clickable card produce ambiguous targets and unusable markup. Use
the **stretched-link** pattern: one real `<a>` on the title, made to cover the card with a
pseudo-element, and any secondary action positioned above it with its own stacking context
and `stopPropagation`. One primary destination per card. Never wrap a card containing
buttons in an `<a>`.

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

## Badges, tags, avatars

- Badges carry status, not decoration: icon + text, never color alone, one per card unless they are a category set.
- Cap visible tags at 3 with a `+4` overflow chip.
- Avatars fall back to initials on a deterministic color derived from the ID, never a broken image icon. Stacked avatars cap at 3–5 with a `+n`.
- Notification counts cap at `99+` and never resize their container.

## Reordering and drag and drop

- The board must reflect the drag: the dragged item lifts with a shadow and slight tilt, the source leaves a placeholder gap, and neighbors animate aside to show exactly where the drop lands.
- Grab targets need a visible handle; the whole card being draggable makes text unselectable and scrolling unreliable on touch.
- Auto-scroll near container edges; animate the drop into place rather than snapping.
- **Always provide a non-drag path** — "Move up/down" in the overflow menu, or keyboard reordering with Space to pick up, arrows to move, Space to drop, Escape to cancel — and announce each move in a live region.
- Persist optimistically and revert visibly on failure.

## Loading and empty

Skeleton cards in the real grid shape, 3–6 of them, matching the final aspect ratio — see
`feedback-design` for thresholds and for the four empty-state types.

## Accessibility

- The card is not a landmark. Use `<article>`/`<li>` in a real `<ul>`, with the title as the heading at the correct level.
- Every card in a grid must be reachable in a sane tab order — one stop per card, plus its actions.
- Images that carry meaning get real `alt`; decorative card art gets `alt=""`.
- Selectable cards use a real checkbox or `role="option"` inside `role="listbox"` with `aria-selected` — not a colored border alone.
- Announce list length and filtered counts in a polite live region.

## Checklist

- [ ] One repeated anatomy; generous padding, dual shadow, hairline border, clear title/body hierarchy.
- [ ] Hover lifts the card and scales only the inner media; 200ms ease-out.
- [ ] No hover-only actions; one primary target via stretched link; nested actions still clickable.
- [ ] Equal heights, bottom-aligned actions, reserved media aspect ratios.
- [ ] Drag has a handle, a placeholder gap, a keyboard path, and announcements.
- [ ] Real list semantics and headings; skeletons match the grid.

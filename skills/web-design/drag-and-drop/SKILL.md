---
name: drag-and-drop
description: Build or review dragging interactions. Use when adding list or card reordering, a kanban board, drag-to-move on a canvas, a drop target or dropzone, drag handles, or when a drag has no keyboard equivalent, no visible landing position, or no undo.
---

# Drag and Drop

Assumes `design-foundations` for tokens and `motion-design` for gesture physics. Dragging is
the least accessible interaction in common use and the easiest to ship half-built: it needs
a pickup that reads as a pickup, a landing position visible before release, an undo, and a
path for everyone who is not dragging.

## Pickup

- The item must **lift**: scale up slightly, deepen its shadow, and tilt a degree or two, all three together. One alone reads as a sticky click rather than a grab.
- The source position leaves a placeholder gap so the list length never changes mid-drag, and neighbours animate aside rather than jumping.
- **Give grab targets a visible handle** in lists and dense UI. Making the whole card draggable makes text unselectable and scrolling unreliable on touch; reserve whole-item dragging for canvases and boards where there is nothing else to do with the item.
- Require a small movement threshold (~5px) or a short hold before a drag begins, so a click on the item is still a click.
- Cursor is `grab` at rest and `grabbing` during, and the dragged item follows the pointer without lag or offset drift.

## Landing

- **Show where it lands before release**, not after: an insertion line between items, a filled highlight for dropping into a container, a snapped ghost on a grid.
- Outline the valid targets for the duration of the drag and dim or ignore the invalid ones. A drop that silently does nothing is indistinguishable from a bug.
- Snap to the nearest valid slot on structured surfaces; reserve free positioning for canvases, and even there offer alignment guides.
- Auto-scroll when the pointer nears a container edge, accelerating with proximity, and stop at the bounds rather than scrolling past the end.
- Animate the drop into place over ~150-200ms rather than snapping, so the eye follows the item to its new home.
- Escape during a drag cancels it and returns the item to its origin.

## After the drop

- **Pair every drop with a brief undo**, the same way a delete gets one. A drag that lands in the wrong column is as costly as a mis-click and just as easy to make (`feedback-design`).
- Persist optimistically and revert visibly on failure, keeping the item in view so the user sees what happened.
- Reordering writes a stable order value; do not renumber every row on every move, or two concurrent reorders fight.
- In a multi-user surface, reconcile against the server's order and explain a rejected move rather than silently snapping back (`collaboration-design`).

## Keyboard and assistive paths

WCAG 2.2 requires a single-pointer alternative for every dragging movement, and a keyboard
path is the practical way to satisfy it.

- **Space picks up, arrows move, Space drops, Escape cancels.** Announce each step in a live region: "Picked up Invoice 42, position 3 of 12", "Moved to position 2", "Dropped".
- Offer the same operations without any gesture: "Move up", "Move down", and "Move to…" in the item's overflow menu (`popover-and-menu`). This is also the fastest path for anyone moving an item across a long list.
- The drag handle is a real focusable control with an accessible name that includes the item ("Reorder Invoice 42").
- Touch alternatives matter too: a long-press-then-drag with no visible affordance is undiscoverable, so pair it with the menu path.
- Under `prefers-reduced-motion`, keep the reordering feedback but drop the tilt, the springy settle, and the neighbour animations.

## Files and canvases

- A file dropzone changes state on drag-over and reverts on leave, and always ships a click-to-browse path beside it (`file-upload`).
- On a canvas, dragging competes with panning and selection: assign each to a distinct input (drag on the object, space-drag or middle-drag to pan, marquee on empty space) and say so in a shortcuts panel.
- Multi-select drags move the whole selection, show the count on the drag preview, and keep relative positions on drop.

---
name: popover-and-menu
description: Build or review anchored overlays. Use when adding a dropdown menu, action or overflow menu, context menu, submenu, or an arbitrary-content popover, handling anchor positioning, flipping and collision, outside-click dismissal, hover intent, or menu keyboard navigation.
---

# Popover and Menu

Assumes `overlay-design` for surface choice and `design-foundations` for tokens. Two
different things share one visual language, and confusing them is the usual bug:

- A **menu** is a list of commands. Arrow keys move, Enter activates, typeahead jumps, and it closes on selection. `role="menu"` with `menuitem` children.
- A **popover** holds arbitrary content - a form, a preview, a color picker. It is not a menu, must not claim `role="menu"`, and Tab moves through its content normally.
- A picker that produces a value is neither: it is `select-and-combobox`.

## Trigger

- A real `<button>` with `aria-expanded`, `aria-haspopup`, and `aria-controls`, a visible caret for a menu, and a full-size target (a 30px trigger fails on touch).
- The trigger keeps its focus ring while the surface is open, and shows an active state so the connection is visible.
- Click to open, click to close. **Hover-opened menus need intent**: a ~100-150ms open delay, a longer close delay, and a safe pointer corridor so a diagonal move into the panel does not close it. Hover-only menus are unusable on touch and need a click path anyway.

## Positioning

- Anchor to the trigger and measure before painting: **flip** to the opposite side when there is no room, then **shift** along the axis to stay inside the viewport, keeping the arrow pointed at the trigger.
- Constrain to the viewport with a max height and internal scroll; never let the panel clip inside an `overflow: hidden` ancestor. Portal to the body or use the popover API when the layout demands it.
- Match the menu width to the trigger for select-like menus; size to content for action menus, with a sensible min and max.
- Reposition on scroll and resize, and close on the scroll of a container the trigger is inside - a menu floating away from its anchor is worse than a closed one.

## Content and structure

- One action per row, with the verb first. Group by intent with dividers and optional group labels.
- Destructive items go last, separated, in danger color (`button-and-action-design`).
- Show keyboard shortcuts right-aligned in the row where they exist; it is the cheapest discoverability in the product.
- Icons are optional but must be all-or-nothing per group, aligned in a fixed leading column.
- Disabled items state why in a description or are omitted. A dead row with no explanation is a dead end.
- Past ~10 items, add a search field pinned above the list; scrolling is not filtering.

## Submenus and context menus

- Submenus open on hover with intent and on Right arrow, close on Left arrow, and the parent item keeps a highlighted state while the child is open.
- One level of nesting. A third level is a sign the menu should be a panel or a page.
- Context menus open at the pointer, then flip and shift to stay on screen. On touch, a long press may open the same actions as a bottom sheet, but every action still needs a visible non-gesture path.
- Native context menu suppression must be deliberate; keep a way to reach the browser's own menu on links and images.

## Motion and dismissal

- Open in ~150ms, scaling from the trigger's corner (`transform-origin` at the anchor) so the connection is obvious; close faster. Instant reads as a repaint, past ~300ms it drags (`motion-design`).
- Escape closes and returns focus to the trigger, one submenu level at a time.
- Outside click and blur close; selection closes a menu but not necessarily a multi-select popover.
- No scrim, no scroll lock, no focus trap for a menu - those belong to modal surfaces.

## Keyboard

- Down or Enter on the trigger opens the menu with the first item active; Up opens with the last.
- Arrows move and wrap, Home and End jump, and printable characters typeahead to the matching item.
- Tab closes a menu and moves on. Inside a popover, Tab moves through its content and does not close it.
- Focus is managed: either roving `tabindex` or `aria-activedescendant`, never both.
- All of this is the APG menu-button pattern. Users have it memorized; deviating costs more than it saves.

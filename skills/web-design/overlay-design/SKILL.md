---
name: overlay-design
description: Build or review layered UI. Use when creating a modal, dialog, confirmation, bottom sheet, drawer, side panel, popover, dropdown menu, tooltip, or command palette, when deciding which of them fits, or when handling scrims, focus trapping, Escape dismissal, scroll locking, or z-index stacking.
---

# Overlay Design

Assumes `design-foundations` for tokens and motion.

## Pick the lightest surface that works

Start with one question: **does this need to block the user?** Almost always, no.

| Surface | Use for | Weight |
| --- | --- | --- |
| **Inline / expand in place** | Editing, disclosure, anything with surrounding context | None: the default, and the one people skip |
| **Popover / menu** (~200–320px, anchored to its trigger) | Quick choices, overflow actions, pickers | Dismiss on outside click; no scrim |
| **Drawer / side panel** | Details, secondary navigation, filters on desktop | Dims only what it covers; app stays alive behind |
| **Bottom sheet** (mobile) | Contextual actions and pickers within thumb reach | Drag handle, snap points, background partly visible |
| **Modal dialog** | Blocking, destructive, or irreversible decisions only | Full scrim, full attention |

Rules of thumb: a modal for a routine action is a punishment. Navigation never goes inside
a blocking overlay. **Never stack a modal on a modal**: replace the content or use a
drawer. Tooltips carry hints, never information the user needs to complete the task, and
never interactive content.

## Anatomy

- Title that names the decision ("Delete 3 projects?"), body that states consequences, actions bottom-right on desktop, full-width stacked on mobile with the primary on top.
- Buttons say the verb: **Delete / Cancel**, not OK/Cancel.
- Destructive primary is `danger`-colored; for irreversible bulk actions, require typed confirmation or an explicit count.
- Max width ~480px for confirmations, ~640px for forms. Long content scrolls in the body while the header and footer stay pinned.
- Scrim: black at 40–60% with a short fade. Do not blur the background if it costs frames on low-end devices.

## Motion

Entrance 200–300ms `ease-out`, exit ~150ms. Modals fade + scale from `0.96`; sheets slide
from the edge; popovers scale from the trigger's corner (`transform-origin` at the anchor)
so the connection is obvious. Under `prefers-reduced-motion`, fade only.

## Dismissal

- Escape closes every overlay. Outside click closes popovers, drawers, and sheets; for a modal with unsaved input, ask before discarding.
- Sheets close on swipe-down past a threshold, with velocity-aware snapping.
- Close button top-right on anything larger than a popover, plus a visible Cancel for decisions.
- Never auto-dismiss an overlay on a timer, and never close on scroll.

## Focus and scroll

- On open, move focus into the overlay: to the first field, or the container when there is none. Never onto the destructive button.
- Trap focus while open; Tab cycles and wraps inside.
- On close: return focus to the element that opened it. Skipping this is the single most common overlay defect.
- Lock background scroll without a layout shift (compensate for scrollbar width). The overlay's own body scrolls.

## Stacking

Use a token scale: `dropdown 1000 / sticky 1100 / drawer 1200 / modal 1300 / popover 1400 / toast 1500`. Never write an ad-hoc `z-index: 9999`. Remember `z-index` only applies to positioned elements, and a parent's `transform`, `filter`, or `opacity` creates a stacking context that traps children no matter how high their value. When that bites, portal the overlay to the body instead of escalating numbers.

## Command palette

⌘K is a system, not a search box: fuzzy matching, grouped and ranked results, recent
commands when empty, inline keyboard shortcut hints, arrow + Enter navigation, Escape to
close, and one action per row. Debounce remote search and keep the previous results while
fetching.

## Context menus

- Measure before opening and flip or shift the menu to remain inside the viewport while staying anchored to its trigger or pointer.
- Group actions by intent, separate destructive items at the bottom, and use a safe pointer corridor so diagonal movement into a submenu does not close it.
- Arrow keys move, typeahead jumps, and Escape closes one submenu level at a time. On touch, long press may open the same actions in a bottom sheet, but every action still needs a visible, non-gesture path.

## Accessibility

- `role="dialog"` (or `alertdialog` for a blocking confirm) with `aria-modal="true"` and `aria-labelledby` pointing at the title; add `aria-describedby` for the body.
- Content behind should be inert (`inert` attribute or `aria-hidden="true"`) while a modal is open.
- Menus use `role="menu"`/`menuitem` with arrow-key navigation and typeahead; a popover of arbitrary content should not.
- Triggers expose `aria-expanded` and `aria-haspopup`; tooltips use `aria-describedby` and must appear on focus, not only hover.
- Native `<dialog>` with `showModal()` gives you the trap, Escape, and inertness for free; prefer it.

## Checklist

- [ ] The lightest surface that fits; modal only for blocking or destructive decisions.
- [ ] Focus enters on open, is trapped, and returns to the trigger on close.
- [ ] Escape closes; unsaved input is confirmed before discard.
- [ ] Background scroll locked with no layout shift; z-index from the token scale.
- [ ] Buttons named with verbs; destructive action clearly marked and countable.
- [ ] Menus stay in the viewport; submenus tolerate diagonal pointer travel and work by keyboard and touch.
- [ ] Exit faster than entrance; reduced-motion path fades only.

---
name: drawer-and-sheet
description: Build or review a drawer, side panel, or bottom sheet. Use when adding a slide-in panel for details, filters, or secondary navigation, a mobile bottom sheet with snap points or a drag handle, a full-screen mobile sheet, or when handling swipe-to-dismiss, scroll inside a sheet, and keyboard behavior.
---

# Drawer and Sheet

Assumes `ui-composition` for surface choice and `motion-design` for gesture physics. A
drawer keeps the app alive behind it; a modal does not. Use one when the user needs the
context they came from - filters against a visible list, details beside a table, a picker
above the page that produced it.

## Placement

| Surface | Where | Use |
| --- | --- | --- |
| Side drawer | Right on desktop for details and filters; left for navigation | Secondary content that pairs with the main view |
| Bottom sheet | Bottom on mobile | Anything reachable by thumb: pickers, actions, short forms |
| Full-screen sheet | Covers the viewport on mobile | A task too large for a sheet but too minor for a route change |

Right-side for content, left-side for navigation, and mirrored under RTL
(`internationalization-design`). Keep the width within 320-480px on desktop, or a percentage
that never exceeds ~40% of a wide screen, so the context behind stays legible.

## Anatomy

- Header with the title and a close button, footer with the actions, and only the middle scrolls. A drawer whose footer scrolls away hides its Apply button.
- A filter drawer needs its applied count, Apply, and Clear all visible at all times (`search-and-filter-design`).
- Bottom sheets get a **drag handle** at the top center - the affordance that tells people it can be dragged at all - plus a close control for anyone not using gestures.
- Leave a visible strip of the page behind a bottom sheet so it reads as layered rather than as a new screen.
- Respect the safe area: pad the bottom past the home indicator, and keep the primary action above the keyboard when one is open (`responsive-design`).

## Snap points and gestures

- Two or three snap points at most: peek, half, full. More than that and users cannot predict where a drag will land.
- Snap by **velocity as well as distance**: a fast flick past a small threshold dismisses, a slow drag past halfway settles to the next point. Distance-only thresholds feel unresponsive.
- Rubber-band past the top bound instead of hard-stopping, and never let the sheet detach from the finger during a drag.
- Content scrolls only once the sheet is at its top snap point; below that, the drag moves the sheet. Getting this seam wrong makes the sheet fight the list inside it.
- Swipe-down dismisses, with the scrim opacity tracking the drag so the gesture is reversible and legible.

## Motion

- Slide from the edge over 200-300ms `ease-out`; exit ~150-200ms. The sheet moves along one axis only - no fade-and-slide-and-scale at once.
- Interruptible: a drag during the entrance animation takes over from the current position rather than snapping to the end.
- Under `prefers-reduced-motion`, cross-fade in place and keep the gesture working.

## Dismissal and state

- Escape closes, outside click and scrim tap close, swipe-down closes on touch. A drawer with unsaved edits asks first, the same as a modal.
- Non-modal drawers may leave the page interactive behind them; then they must not trap focus, and they must not lock scroll. Decide which one it is and be consistent - a half-blocking drawer is the worst of both.
- Preserve the drawer's own scroll and form state while it is open, and restore the page's scroll position on close.
- Put the drawer's open state in the URL when it holds a filter set or a record, so it survives refresh and can be linked (`navigation-design`).

## Accessibility

- Modal drawers use `role="dialog"` with `aria-modal="true"`, a labelled title, a focus trap, and inert background - identical to `modal-dialog`.
- Focus moves into the drawer on open and returns to the trigger on close.
- **Every gesture needs a non-gesture path**: the close button, and keyboard access to whatever the drag adjusts. WCAG 2.2 requires a single-pointer alternative for dragging.
- Announce the drawer's purpose on open ("Filters, dialog") rather than leaving a screen-reader user in unlabeled content.
- Do not stack a sheet on a sheet. Replace the content and offer a back affordance within one surface.

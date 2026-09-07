---
name: tooltip
description: Build or review a tooltip. Use when adding a hover or focus hint, an icon-button label, a truncated-text reveal, a keyboard-shortcut hint, or a help bubble, and when deciding between a tooltip, inline helper text, and a popover.
---

# Tooltip

Assumes `ui-composition` for surface choice. A tooltip is a **hint attached to a control**,
shown on hover or focus, holding one short line. Everything else people put in tooltips
belongs somewhere else.

## What must not be in one

- **Nothing required to complete the task.** A tooltip disappears, cannot be re-read while typing, does not exist on touch, and is invisible to anyone who never hovers. Field requirements, format rules, and prices go in helper text (`text-input`).
- **No interactive content.** Links, buttons, and form controls inside a hover bubble are unreachable for keyboard and unstable for the pointer. That is a popover (`popover-and-menu`).
- **No documentation.** Cap it at one sentence, ~300px wide. If it needs two paragraphs, the interface needs a better label or a help panel.
- **Not a substitute for a visible label.** An icon-only button needs an accessible name *and* the tooltip; the tooltip is not the name (`button`).

## Behavior

- **Delay ~300ms before showing on hover** so a cursor crossing the control does not fire it. Show **instantly on focus** - a keyboard user asked for it deliberately.
- Once one tooltip in a group has opened, open neighbors instantly until the pointer rests elsewhere; re-delaying inside a toolbar feels sticky.
- Keep open while the trigger has focus or the pointer is over the trigger or tooltip. Escape dismisses without moving pointer or focus; outside tap also dismisses. Otherwise hide when neither region remains hovered or focused.
- Never auto-hide on a timer while the pointer is still on the trigger, and never animate longer than ~150ms in either direction.
- Put disabled reasons in visible text; do not depend on a native disabled control receiving hover or focus (`button`).

## Placement

- Point at the trigger with an arrow, default above, and flip near the viewport edge; shift along the axis to stay on screen without leaving the arrow orphaned.
- Never cover the trigger or the content the user is reading - WCAG 2.2 requires that a hover- or focus-triggered overlay not obscure the element that triggered it.
- Follow the trigger on scroll or close with it; a tooltip stranded mid-page is a rendering bug users notice immediately.
- Keep it above menus and below modals in the z-index scale (`modal-dialog`).

## Touch

Touch devices have no hover. Decide explicitly:

- Icon-only actions get a visible text label or a long-press sheet at small sizes rather than an unreachable hint.
- Truncated text opens the full value in a sheet or expands in place on tap; never rely on a tooltip to make content readable.
- A tap-to-show tooltip must dismiss on the next outside tap and never block the control it describes.

## Accessibility

- Use `role="tooltip"` and `aria-describedby` for supplementary hints; use `aria-labelledby` only when it genuinely supplies the control's name.
- The tooltip element itself is not focusable and is not in the tab order.
- Contrast applies: the bubble's text against its own fill, and the bubble against the page.
- Content that must be announced on demand rather than on hover belongs in visible text, not here.

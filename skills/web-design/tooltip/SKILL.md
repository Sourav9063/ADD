---
name: tooltip
description: Build or review a tooltip. Use when adding a hover or focus hint, an icon-button label, a truncated-text reveal, a keyboard-shortcut hint, or a help bubble, and when deciding between a tooltip, inline helper text, and a popover.
---

# Tooltip

Assumes `overlay-design` for surface choice. A tooltip is a **hint attached to a control**,
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
- Hide immediately on mouse leave, blur, Escape, and outside tap. **A tooltip that survives Escape is a trap.**
- Never auto-hide on a timer while the pointer is still on the trigger, and never animate longer than ~150ms in either direction.
- No tooltip on a disabled control: disabled elements do not fire pointer events, so the explanation is unreachable. Keep the control enabled with `aria-disabled` or put the reason in visible text (`button-and-action-design`).

## Placement

- Point at the trigger with an arrow, default above, and flip near the viewport edge; shift along the axis to stay on screen without leaving the arrow orphaned.
- Never cover the trigger or the content the user is reading - WCAG 2.2 requires that a hover- or focus-triggered overlay not obscure the element that triggered it.
- Follow the trigger on scroll or close with it; a tooltip stranded mid-page is a rendering bug users notice immediately.
- Keep it above menus and below modals in the z-index scale (`overlay-design`).

## Touch

Touch devices have no hover. Decide explicitly:

- Icon-only actions get a visible text label or a long-press sheet at small sizes rather than an unreachable hint.
- Truncated text opens the full value in a sheet or expands in place on tap; never rely on a tooltip to make content readable.
- A tap-to-show tooltip must dismiss on the next outside tap and never block the control it describes.

## Accessibility

- WCAG 2.2 requires hoverable content: the tooltip stays open while the pointer moves onto it, is dismissible with Escape without moving focus, and persists until dismissed or the trigger loses hover or focus.
- Wire it with `aria-describedby` for supplementary hints, and `aria-labelledby` only when the tooltip genuinely is the control's name.
- The tooltip element itself is not focusable and is not in the tab order.
- Contrast applies: the bubble's text against its own fill, and the bubble against the page.
- Content that must be announced on demand rather than on hover belongs in visible text, not here.

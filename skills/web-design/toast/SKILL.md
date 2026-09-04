---
name: toast
description: Build or review toast notifications and snackbars. Use when adding a transient confirmation, an undo affordance after an action, a stacked or queued notification, or when choosing between a toast, an inline message, and a banner, and when toasts are being missed, stacking up, or covering controls.
---

# Toast

Assumes `feedback-design` for choosing this surface and `design-foundations` for tokens.
A toast is a **transient confirmation of something the user just did**. It is the weakest
notification surface in the product: it appears away from the user's focus, vanishes on a
timer, and is invisible to anyone reading elsewhere on the page.

## What belongs in one

- Confirmations of completed actions, especially with an undo ("Deleted. Undo").
- Background results the user is waiting for but not watching ("Export ready").
- Nothing else. Validation goes inline, persistent conditions go in a banner (`alert-banner`), blocking decisions go in a dialog (`modal-dialog`), and **errors the user must act on do not belong in a disappearing box**.

## The five rules

1. **One at a time.** Queue the rest and cap the stack at ~3; a tower of toasts hides the app.
2. **Never cover the primary action** or the element just acted on. Anchor away from it and shift the layout if needed.
3. **Timing by type**: ~4s informational, ~7s warnings, and **errors do not auto-dismiss**. Pause the timer on hover and on focus, and restart it when the pointer leaves.
4. **At most one action**, and never bury a critical one there. If the action matters more than the message, this is the wrong surface.
5. **Enter with a slide plus fade, exit faster.** Under `prefers-reduced-motion`, fade only.

## Placement and anatomy

- Consistent anchor across the product: a bottom corner on desktop, the top edge on mobile where the bottom is thumb territory and the safe area matters.
- **Never center-screen** - that is a modal's position and it reads as one.
- Type color plus an icon plus a left accent border; never color alone. Keep the message to one line where possible, with the object named ("Invite sent to sam@acme.com").
- Close button on desktop, swipe-to-dismiss on touch, and both keyboard-reachable.
- Stacked toasts newest-nearest-the-edge, with the older ones scaled slightly back; collapse to a count past the cap rather than growing the tower.

## Undo

The undo toast is the reason this component exists (`feedback-design` owns the pattern):

- Show a visible countdown - a ring or bar - so the window is legible rather than a guess.
- Pause the countdown on hover and focus; a user reaching for Undo must not lose the race.
- Back it with a soft delete so the button is not a lie when the request loses the race.
- Keep a permanent path (trash, history) as well; the toast is a convenience, not the only route.

## Accessibility

- Container is a live region: `aria-live="polite"` with `role="status"` for confirmations, `role="alert"` for the rare toast that must interrupt. Do not make every toast assertive.
- The live region exists in the DOM **before** the toast is inserted, or nothing is announced.
- WCAG requires a way to extend, pause, or dismiss timed content: hover and focus pause, and the close button is reachable.
- Toasts must not steal focus. Provide a keyboard shortcut or a reachable stop in the tab order for the action inside them, since a screen-reader user cannot chase a disappearing button.
- Anything announced must also be recoverable: put the same information in a notification centre or a persistent surface when it matters after the toast is gone.

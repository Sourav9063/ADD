---
name: modal-dialog
description: Build or review a modal dialog. Use when adding a blocking dialog, confirmation, alert dialog, or modal form, sizing and structuring its header, body, and footer, handling the scrim, Escape and outside-click dismissal, unsaved-changes warnings, focus trapping, or nested dialogs.
---

# Modal Dialog

Assumes `ui-composition` for choosing this surface at all, and `design-foundations` for
tokens and motion. A modal takes the whole screen hostage, so the bar is high: **blocking,
destructive, or irreversible decisions, and short focused tasks that would lose their
context elsewhere.** A modal for a routine action is a punishment.

## Build on `<dialog>`

Native `<dialog>` with `showModal()` gives you the focus trap, Escape, inertness of the
background, and the top-layer stacking for free - all four of which hand-rolled modals get
wrong. Reach for a library only when you need shared-element motion or nested behavior the
native element cannot express.

## Structure

- **Title names the decision**, not the feature: "Delete 3 projects?" beats "Confirm". It is the accessible name via `aria-labelledby`.
- Body states the consequence in the user's terms, including what cannot be undone and what else is affected ("Their 42 files will also be deleted").
- Actions in the footer, bottom-right on desktop, full-width stacked on mobile with the primary on top. Labels are verbs matching the title: **Delete / Cancel**, never OK/Cancel (`button`).
- Max width ~480px for confirmations, ~640px for forms. Long content scrolls in the body with the header and footer pinned, and the scroll region shows a shadow or hairline so it is discoverable.
- Close button top-right *and* a visible Cancel for any decision. The X alone is ambiguous about whether it cancels or saves.

## Confirmation content

- Prefer undo to confirmation for anything reversible; a dialog on every delete trains people to dismiss dialogs (`feedback-design`).
- State the count and the object, and repeat them on the button.
- For catastrophic actions, require typed confirmation of the resource name, and keep the destructive button off the default focus target.
- **Never put the destructive action where the confirm button normally sits.** Muscle memory clicks position, not label.

## Dismissal and unsaved work

- Escape always closes, outside click closes a simple dialog, and both are blocked - with an "You have unsaved changes" prompt - when the body holds edited input. That second dialog is the one legitimate case for stacking, and it should be an `alertdialog`.
- Never auto-dismiss on a timer, never close on scroll, and never close on route change without handling the in-flight work.
- **Never stack modals otherwise.** Replace the content in place, or step down to a drawer (`drawer-and-sheet`).
- Closing returns the user to exactly where they were, with scroll position and selection intact.

## Motion and scrim

- Entrance 200-300ms `ease-out` with a fade plus scale from `0.96`; exit ~150ms. Under `prefers-reduced-motion`, fade only.
- Scrim black at 40-60% with a short fade. Skip a background blur if it costs frames on low-end devices.
- The scrim animates with the dialog, not before it, or the screen dims into an empty void.

## Focus and background

- On open, move focus into the dialog: the first field, or the container when there is none. Never onto the destructive button.
- Trap focus while open; Tab wraps inside. On close, **return focus to the element that opened it** - the single most common overlay defect.
- Make the background truly inert (`inert` or `aria-hidden="true"`), and lock background scroll without a layout shift by compensating for the scrollbar width.
- On mobile, a modal that would fill the viewport should be a full-screen sheet with its own back affordance instead (`drawer-and-sheet`).

## Accessibility

- `role="dialog"` with `aria-modal="true"`, or `role="alertdialog"` for a blocking confirmation, with `aria-labelledby` on the title and `aria-describedby` on the body.
- The dialog is not a landmark container for the page's navigation; never put primary navigation inside one.
- Announce asynchronous results inside the dialog rather than behind it - a toast under the scrim is invisible (`toast`).
- Keep the dialog's height under the viewport at 200% zoom and at 320px width; a fixed-height dialog with a cropped footer hides the actions.

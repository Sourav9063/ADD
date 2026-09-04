---
name: button-and-action-design
description: Build or review the actions on a screen. Use when ranking actions and choosing which is primary, ordering buttons in dialogs and forms, building toolbars, overflow and action menus, bulk action bars, floating action buttons, or swipe actions, and when handling destructive actions, confirmation, and the disabled-submit problem.
---

# Button and Action Design

Assumes `design-foundations` for tokens and motion, `button` for the control itself, and
`feedback-design` for result states. This skill is about which actions a screen offers,
how they rank, and what happens when one is dangerous.

## Hierarchy and placement

One **primary** per view. Everything else is secondary, tertiary, or destructive; two
primaries side by side means neither is primary. Variants, sizes, labels, and states are
`button`'s job - the decisions here are which action wins and where it sits.

- Size scale: `sm 32 / md 40 / lg 48`px height; pad the hit area rather than inflating the visual.
- Order on desktop: primary rightmost in dialogs, leftmost in forms and toolbars. Pick one per product and never mix. On mobile, stack full width with the primary on top.
- Cancel is never the same weight as Confirm.
- The label must match the destination or result: a button reading "Continue" that charges a card is a dark pattern.

## Stop disabling submit buttons

A disabled button is removed from the tab order, stays silent to screen readers, fails
contrast (greyed text lands near 1.9:1), and **cannot fire the pointer events a tooltip
needs**, so the explanation you attached to it is unreachable. The result is a user
stuck with no way to learn why.

Instead:

- **Keep the button enabled and validate on click**: mark the blocking fields, move focus to the first one, and announce the summary.
- If you must disable, put the reason in always-visible text next to the button, and keep the control focusable (`aria-disabled="true"` rather than the `disabled` attribute).
- **Loading is not disabled.** Use a busy state: keep focus, show the spinner, set `aria-busy="true"`, keep the accessible name ("Saving…"), and block re-submission in the handler rather than by removing the control.

## Destructive actions

- Prefer **undo over confirm** for anything reversible (see `feedback-design`). Reserve dialogs for the irreversible.
- Name the consequence and the count: "Delete 12 files?" Never use "Are you sure?".
- Reserve destructive button styling for destructive actions; do not spend the same red treatment on routine actions such as Sign out.
- For catastrophic actions, require typed confirmation of the resource name, keep the danger button as the non-default focus target, and delay permanent deletion behind a cancelable grace period when possible.
- **Never put the destructive button where the confirm button normally sits.** Muscle memory clicks the position, not the label, and the one dialog where those differ is the one that deletes the account.
- Put destructive controls in a separated, labelled danger zone. A hold-to-confirm gesture may add friction, but it needs a visible fill over ~300ms, release-to-cancel, and an accessible non-hold path.
- Keep red for destructive actions only. Spent on sign-out, badges, and routine alerts, it stops meaning danger by the time it matters.

## Action lifecycle

Client validation provides fast feedback; it does not establish success. Revalidate on the
server, show success only after related writes commit atomically, and repaint IDs, totals,
permissions, and other trusted values from the response. Optimistic UI is for cheap,
reversible actions; payments and irreversible work keep a truthful busy state.

## Groups, menus, and toolbars

- Beyond ~3 actions in a row, move the rest into an overflow menu (`⋯`) with the destructive item separated at the bottom.
- Toolbars: group by function with dividers, keep icon sizes consistent, and expose one roving tabindex across the group so Tab does not walk through twelve controls.
- **Bulk action bars** appear on first selection and state the count. Selection lives in application state, not the DOM, so it survives pagination and supports shift-click ranges. "Select all" means this page; offer the explicit escalation "Select all 247 matching", and update that number when filters change.
- **FAB** (mobile): one per screen, bottom-right, above the safe area, never covering content or the bottom bar.
- Swipe actions on list rows: max two per direction, consistent colors and directions across the app, a peek affordance so they are discoverable, a partial-swipe reveal (never instant delete on a full swipe) plus undo, and always a visible alternative path, since a gesture is not accessible on its own.

## Accessibility

- Menu triggers expose `aria-expanded` and `aria-haspopup`; the menu itself follows `popover-and-menu`.
- A bulk action bar announces the selection count when it appears, and its actions name what they apply to ("Delete 12 selected files").
- Gesture-only actions (swipe, drag, long-press) always have a visible equivalent; WCAG 2.2 requires a single-pointer alternative.
- Per-control focus, naming, and state rules live in `button`.

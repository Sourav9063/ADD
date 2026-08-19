---
name: button-and-action-design
description: Build or review buttons and action controls. Use when creating a button, link, icon button, split or dropdown button, floating action button, toolbar, or action menu, when choosing button hierarchy or labels, when handling destructive or bulk actions, or when a button is disabled, loading, or double-submitting.
---

# Button and Action Design

Assumes `design-foundations` for tokens and motion, `feedback-design` for result states.

## Link or button

- Navigates to a URL → `<a href>`. Performs an action → `<button>`. This decides middle-click, Back, Enter vs Space, and how screen readers announce it.
- Never a `<div onClick>`. You lose focus, Enter/Space, and role, and you will rebuild all three badly.
- A button styled as a link is fine; a link that mutates data is not.

## Hierarchy

One **primary** per view (filled, accent). Everything else is **secondary** (outline or
tinted), **tertiary/ghost** (text only), or **destructive** (danger fill, or danger text
when it is not the main path). Two primaries side by side means neither is primary.

- Size scale: `sm 32 / md 40 / lg 48`px height, with 44px minimum touch targets — pad the hit area rather than inflating the visual.
- Order on desktop: primary rightmost in dialogs, leftmost in forms and toolbars — pick one per product and never mix. On mobile, stack full width with the primary on top.
- Cancel is never the same weight as Confirm.

## Labels

- Verb + object: **Save changes**, **Delete project**, **Send invite**. Not "OK", not "Submit", not "Yes".
- The label must match the destination or result — a button reading "Continue" that charges a card is a dark pattern.
- Sentence case, no truncation, no width jump between states — reserve the widest label's width so loading does not resize the button.
- Icon-only buttons need `aria-label` and a tooltip on **focus as well as hover**.

## States

Style all seven: default, hover, focus-visible, active/pressed, loading, disabled, and
(where relevant) selected. Press feedback under 100ms — a scale to `0.98` or a fill shift.
Hover effects must never be the only signal that something is interactive.

## Stop disabling submit buttons

A disabled button is removed from the tab order, stays silent to screen readers, fails
contrast (greyed text lands near 1.9:1), and **cannot fire the pointer events a tooltip
needs** — so the explanation you attached to it is unreachable. The result is a user
stuck with no way to learn why.

Instead:

- **Keep the button enabled and validate on click**: mark the blocking fields, move focus to the first one, and announce the summary.
- If you must disable, put the reason in always-visible text next to the button, and keep the control focusable (`aria-disabled="true"` rather than the `disabled` attribute).
- **Loading is not disabled.** Use a busy state: keep focus, show the spinner, set `aria-busy="true"`, keep the accessible name ("Saving…"), and block re-submission in the handler rather than by removing the control.

## Destructive actions

- Prefer **undo over confirm** for anything reversible (see `feedback-design`). Reserve dialogs for the irreversible.
- Name the consequence and the count: "Delete 12 files?" — never "Are you sure?".
- Reserve destructive button styling for destructive actions; do not spend the same red treatment on routine actions such as Sign out.
- For catastrophic actions, require typed confirmation of the resource name, keep the danger button as the non-default focus target, and delay permanent deletion behind a cancelable grace period when possible.
- Put destructive controls in a separated, labelled danger zone. A hold-to-confirm gesture may add friction, but it needs visible progress, release-to-cancel, and an accessible non-hold path.

## Action lifecycle

Client validation provides fast feedback; it does not establish success. Revalidate on the
server, show success only after related writes commit atomically, and repaint IDs, totals,
permissions, and other trusted values from the response. Optimistic UI is for cheap,
reversible actions; payments and irreversible work keep a truthful busy state.

## Groups, menus, and toolbars

- **Split button**: default action on the left, arrow for alternates on the right, each separately labeled.
- Beyond ~3 actions in a row, move the rest into an overflow menu (`⋯`) with the destructive item separated at the bottom.
- Toolbars: group by function with dividers, keep icon sizes consistent, and expose one roving tabindex across the group so Tab does not walk through twelve controls.
- **Bulk action bars** appear on first selection and state the count. Selection lives in application state, not the DOM, so it survives pagination and supports shift-click ranges. "Select all" means this page; offer the explicit escalation "Select all 247 matching", and update that number when filters change.
- **FAB** (mobile): one per screen, bottom-right, above the safe area, never covering content or the bottom bar.
- Swipe actions on list rows: max two per direction, consistent colors and directions across the app, a peek affordance so they are discoverable, a partial-swipe reveal (never instant delete on a full swipe) plus undo — and always a visible alternative path, since a gesture is not accessible on its own.

## Accessibility

- Focus ring visible on every variant, including the filled danger one — check contrast against the button's own fill, not the page.
- Enter and Space both activate; type is explicit (`type="button"` inside forms, or you get accidental submits).
- Toggle buttons expose `aria-pressed`; menu triggers expose `aria-expanded` and `aria-haspopup`.
- Never convey state by color alone — pair with icon, label, or shape.

## Checklist

- [ ] Anchors navigate, buttons act; no clickable divs.
- [ ] One primary per view; destructive styling distinct and spaced away.
- [ ] Verb + object labels; width reserved so states do not resize.
- [ ] No disabled submits without a visible reason; loading uses a busy state with focus kept.
- [ ] Double-submission blocked in the handler.
- [ ] Icon-only buttons named; tooltips reachable on focus.
- [ ] Overflow past 3 actions; bulk bar names the exact count.

---
name: button
description: Build or review a single button. Use when adding any button or link-styled action, choosing between primary, secondary, tertiary, and ghost variants, sizing a button or its touch target, writing its label, adding an icon or icon-only button, handling loading, disabled, and pressed states, or building a button group or split button.
---

# Button

Assumes `design-foundations` for tokens, focus, and motion. Deletion and other irreversible
actions belong to `destructive-actions`; menus and toolbars to `popover-and-menu`; bulk
action bars to `data-table-design`.

## Element choice

- Navigates to a URL → `<a>`. Performs an action → `<button type="button">`. Submits a form → `<button type="submit">`. A styled `<div>` with a click handler has no keyboard, no Enter and Space, no role, and no name.
- Never nest a button inside a link or a link inside a button, and never put a button inside a clickable card row without stopping propagation.
- Always set `type` on a button inside a form. The default is `submit`, and an unset type is the classic cause of a form posting when the user clicked "Add row".

## Variants

| Variant | Use | Rule |
| --- | --- | --- |
| Primary | The one action the screen exists for | At most one per view, or it stops meaning anything |
| Secondary | Real alternatives (Cancel, Back) | Outline or tonal fill, same size as primary |
| Tertiary / ghost | Low-frequency, in-place actions | Needs a visible hover and focus state, since it has no resting border |
| Destructive | Delete, revoke, cancel a subscription | Danger color, and never the default focus target in a dialog |
| Link-styled | Inline in prose | Underlined, not a bare colored word |

A row of three equally weighted buttons is a decision the design failed to make. Rank them.

## Placement

- **One primary per view**, and the label must match the destination or result: a button reading "Continue" that charges a card is a dark pattern.
- Size scale `sm 32 / md 40 / lg 48`px height; pad the hit area rather than inflating the visual.
- Order on desktop: primary rightmost in dialogs, leftmost in forms and toolbars. Pick one per product and never mix. On mobile, stack full width with the primary on top.
- Cancel is never the same weight as Confirm, and never adjacent to a destructive primary without separation.
- Beyond ~3 actions in a row, move the rest into an overflow menu (`popover-and-menu`).
- A floating action button is one per screen, bottom-right above the safe area, and never covering content or the bottom bar.

## Size and target

- Minimum 24×24 CSS pixels of pointer target including spacing (WCAG 2.2 AA), 44×44 as the practical floor for anything used on a phone.
- Height comes from padding, not a fixed height, so the label can wrap or grow with translation (`internationalization-design`).
- Pad horizontally more than vertically. Icon-only buttons stay square.
- Full-width buttons on mobile only when the action is the screen's purpose; a full-width Cancel is a mis-tap waiting to happen.
- Adjacent buttons need at least 8px between them; touching targets produce wrong taps.

## Label

- Verb plus object: "Save changes", "Delete project", "Send invite". "OK", "Submit", and "Yes" describe nothing.
- Match the label to the heading of what it opens or the outcome it produces, so the user can predict the result.
- Sentence case, no ending period, no all-caps as a text transform (it breaks screen-reader pronunciation and non-Latin scripts).
- Keep labels short enough to survive 30-40% expansion in translation without wrapping to three lines.
- Icon-only buttons need an accessible name (`aria-label` or visually hidden text) *and* a tooltip; the tooltip alone is not a name, and a name alone leaves sighted users guessing (`tooltip`).

## States

Every button ships all of these, and the loading state is the one that gets skipped:

- **Hover** and **active**: a real change, not only the cursor. Keep the transition ≤150ms.
- **Focus-visible**: a 2px ring at 2px offset, ≥3:1 against both the button and the page. Never remove it because the design "looks cleaner".
- **Loading**: keep the accessible name, set `aria-busy`, swap the label to a present-tense state ("Saving…"), and **fix the width** so the layout does not jump. Block the repeat request in the handler rather than removing the control.
- **Pressed** for toggle buttons: `aria-pressed="true"`, with the state visible without color alone.

## Stop disabling submit buttons

A disabled button is removed from the tab order, stays silent to screen readers, fails
contrast (greyed text lands near 1.9:1), and **cannot fire the pointer events a tooltip
needs**, so the explanation attached to it is unreachable. The user is left stuck with no
way to learn why.

Instead:

- **Keep the button enabled and validate on click**: mark the blocking fields, move focus to the first one, and announce the summary (`form-design`).
- If you must disable, put the reason in always-visible text next to the button and keep the control focusable with `aria-disabled="true"` rather than the `disabled` attribute.
- **Loading is not disabled.** Use the busy state above: focus kept, spinner shown, `aria-busy="true"`, accessible name intact, and re-submission blocked in the handler rather than by removing the control.
- The one case for a genuinely disabled button is typed confirmation of an irreversible action, where the gate is the message (`destructive-actions`).

## Icons and composition

- Icon before the label for object-type actions ("＋ New file"), after it for directional or disclosure ones ("Continue →", "Export ▾"). Do not use both.
- Optically align the icon to the text baseline and size it to the label's cap height, not to the line box.
- **Split buttons**: the main action and the menu trigger are two buttons in one group; the menu trigger gets its own accessible name ("More save options") and its own focus ring.
- **Button groups**: one shared border radius on the outer corners, and `role="group"` with a label.
- **Toolbars**: group by function with dividers, keep icon sizes consistent, and expose one roving `tabindex` across the group with arrow-key navigation, so Tab does not walk through twelve controls. A `role="toolbar"` without that keyboard behavior is a lie.

## Behavior

- Enter and Space both activate a `<button>`; a link activates on Enter only. Reimplementing this on a `div` gets it wrong.
- One click, one action. Debounce in the handler, not by disabling on the first click - a slow network then leaves a dead button.
- Never change a button's meaning under the pointer (a "Save" that becomes "Delete" after an async load).
- Motion is a state change, not a performance: no bounce on press, no gradient sweep on hover.

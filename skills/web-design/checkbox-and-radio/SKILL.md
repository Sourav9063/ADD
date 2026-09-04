---
name: checkbox-and-radio
description: Build or review checkboxes, radio buttons, and their groups. Use when offering a single yes/no choice, a multi-select list, one-of-many options, a select-all with indeterminate state, agreement or consent checkboxes, or card-style selectable options, and when grouping, labeling, or validating a set of choices.
---

# Checkbox and Radio

Assumes `design-foundations` for tokens and focus. Immediate-effect switches are
`toggle-switch`; long option lists are `select-and-combobox`.

## Which control

- **Checkbox**: independent choices, any number selected, and - as a single control - a yes/no that takes effect on submit ("Email me updates").
- **Radio**: exactly one of a set, where the options are visible and comparable. Always ships with a default selected unless the choice is genuinely unmade and the form validates for it.
- **Never a radio group of one** and never a single radio you cannot deselect. If the user can change their mind to "neither", the set needs an explicit "None" option.
- Past ~7 options, move to a select; radios are for sets the user should read at once.

## Build on the native input

Use a real `<input type="checkbox">` or `<input type="radio">` and style it with
`appearance: none` or `accent-color`. A `div` with an SVG loses form participation, the
keyboard contract, autofill, and the group semantics - and every reimplementation gets
arrow-key roving wrong.

- The `<label>` wraps or is tied by `for`, so **clicking the text toggles the control**. A tiny 16px box as the only target is the single most common defect in this component.
- The whole row is the hit area: at least 24px tall including padding, 44px on touch, with the checkbox optically aligned to the first line of the label, not centered on a wrapped paragraph.
- Keep the control on the left of the label in LTR (mirrored in RTL, see `internationalization-design`). A trailing checkbox reads as a status, not a choice.

## Groups

- Wrap every group in a `<fieldset>` with a `<legend>` naming the question. Without it, a screen reader announces five unrelated options and no question.
- Stack vertically. A horizontal row of checkboxes makes it ambiguous which label belongs to which box, and it wraps unpredictably.
- Order deliberately: frequency, then alphabetical, then a trailing "Other" with a conditional text field revealed only when chosen.
- Group-level errors sit under the legend and are referenced by `aria-describedby` on the fieldset, not repeated on every option.
- Conditional content revealed by a choice appears directly beneath that option, indented and inside the same group, so its dependency is visible.

## Select-all and indeterminate

- A parent checkbox controlling children is `indeterminate` when some are checked. That is a DOM property, not an attribute, and it must be set in script; `aria-checked="mixed"` conveys it.
- Clicking the parent when mixed selects all, not none. Say what it applies to ("Select all 40 on this page" vs "Select all 1,204"), which is the distinction `data-table-design` depends on for bulk actions.
- Never let a select-all silently include rows the user cannot see or has filtered out.

## Card and tile options

- A selectable card is still an input: the whole card is the label, the underlying control keeps focus and state, and the selected style is more than a border color - pair it with a check mark and a fill.
- Keep interactive elements out of the card's label (a link inside a selectable card is a click target conflict). If the card needs a "Learn more", place it outside the label region.

## Consent and agreement

- Never pre-check a consent box, and never bundle two consents into one. Each obligation gets its own control.
- The label states what is agreed to, with links inline, and the link opens without losing the form state.
- Required consent is validated like any other field: an inline error next to the control, not a blocked submit button (`form-design`).

## Keyboard and accessibility

- A radio group is **one tab stop**: Tab enters at the checked option, arrows move and select, and Tab leaves. Checkboxes are each their own tab stop and toggle with Space.
- Do not trap arrow keys for checkboxes, and do not make radios require Space after arrowing - arrowing already selects.
- Focus-visible ring on the control at ≥3:1, and never hidden by the custom sprite that replaced the native box.
- State must survive grayscale: a checked box needs a mark, not just a filled color.
- Disabled options explain the condition, or are removed. `aria-disabled` keeps them announced when the reason matters.

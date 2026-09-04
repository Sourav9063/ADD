---
name: form-design
description: Build or review a form as a whole. Use when creating a form, login or signup screen, settings page, checkout, stepper, wizard, or inline editor, when choosing which control a field should use, or when handling field order, validation timing, error messages, required fields, autosave, or submit.
---

# Form Design

Assumes `design-foundations` for tokens, motion, and contrast.

## Pick the control

Each control owns its own anatomy, states, and keyboard contract. This skill owns the form
around them.

| Need | Skill |
| --- | --- |
| Free text, numbers, long answers | `text-input` |
| One of many options | `checkbox-and-radio` (few), `select-and-combobox` (many) |
| Independent yes/no, applied on submit | `checkbox-and-radio` |
| On/off applied immediately | `toggle-switch` |
| A value on a range | `slider` |
| Dates, ranges, times | `date-picker` |
| Files and images | `file-upload` |
| Credentials and codes | `password-input`, `otp-input` |
| The submit control itself | `button` |

Choosing wrong is the most expensive decision in a form: a toggle inside a Save form, a
dropdown for three options, or a slider for an exact number cannot be fixed by styling.

## Field layout

Fixed vertical order, always: **label → input → helper text → error text**.

- Labels above fields, one column. Two columns break the reading order and collapse badly; side-by-side pairs are for genuinely paired values (city and postcode, first and last name).
- Reserve the helper and error row's height up front, or the layout jumps on validation.
- Mark **optional** fields, not required ones, when most are required, and vice versa. Whichever is rarer gets the marker. If you use `*`, define it once at the top.
- Group related fields under a heading or `<fieldset>`, and order them the way the user holds the information, not the way the database stores it.
- Ask for less. Every field costs completions; if you cannot say what a field is for, cut it.

## Validation timing

1. **On blur**: validate a field when focus leaves it. Late enough that the user finished, early enough that they are still thinking about it.
2. **After it errors, switch that field to live validation**, so the error clears the instant the input becomes valid.
3. **Never on keystroke for a field that has not errored yet.** Flagging "invalid email" at `s@` is hostile.
4. **On submit**, validate everything, focus the first invalid field, and announce the count.
5. Show a positive check when a field is right; confirmation is feedback too.

**Never disable the submit button as the only validation feedback.** Let it be pressed and
show the errors; a dead button with no explanation leaves the user stuck, guessing which
field is wrong (`button`).

## Error copy

Say what happened and what to do: "Password needs 8+ characters" beats "Invalid input".
Never blame ("You entered..."), never expose the validator's language (`ValidationError:
regex mismatch`). Put the message beside the field it belongs to; a summary at the top is
an addition for long forms, not a replacement.

## Inputs this skill still owns

- **Masked input** (card, phone): format while typing in fixed chunks, keep the caret directly after the character just typed rather than jumping to the end, and validate on blur so nothing reads "invalid" mid-entry. On paste, strip separators and reformat instead of rejecting. Store and submit the unmasked value.
- **Rating**: make the current value readable as text, not only as filled stars. Fill stars ahead of the cursor so the value previews before commit, keep that preview separate from the committed value, and snap back when the pointer leaves without clicking. Allow correcting and clearing a submitted rating, support arrow keys over a radio group, and never accept a rating on hover - a stray pointer must not submit an opinion. When displaying an average, show the count beside it and render partial fills truthfully; rounding 3.4 up to four full stars is a small lie users notice.
- **Color picker**: always allow typing a value (hex, or `oklch` when you want predictable lightness steps), show the picked color against the surface it will actually appear on, and keep recent and preset swatches within one tap. Show a live contrast result while picking rather than after review, so a failing choice is caught at the moment it is made. Preview alpha over both light and dark backgrounds - a white canvas hides what transparency actually does. A gradient canvas with no text input is unusable by keyboard; name swatches for screen readers.

## Long and multi-step forms

- Split at meaningful boundaries, one topic per step, with a step indicator showing position and total. Visible, incomplete progress is what pulls people through a long form, so show how much is done and how much remains rather than a bare step name; never start the bar at zero when the first step is already behind them.
- Never lose entered data on Back. Validate each step before advancing.
- **Autosave**: debounce ~500-1000ms and model `typing / saving / saved / offline / error` explicitly; never claim "Saved" until the server confirms. Queue offline edits locally, show the pending count, and replay oldest first on reconnect.
- Detect concurrent edits and merge or warn rather than silently applying last-write-wins. Warn before navigation or tab close while unsaved work remains.

## Inline editing

- Signal editability on hover and focus, then swap text for an input without changing typography, padding, or surrounding layout. Enter commits and Escape cancels; use one consistent save-or-cancel rule for blur.
- Save cheap edits optimistically. On failure, restore the previous value, retain the draft, explain the failure inline, and allow retry. Require an explicit Edit mode when a typo is costly.

## Settings

- Group settings by user task, keep common options visible, and disclose advanced options in place. Add search when several sections would otherwise require hunting, and keep its term in a query parameter.
- Match persistence to risk: save low-stakes toggles immediately with inline confirmation; use explicit Save/Cancel for identity, billing, permissions, and other consequential changes.
- Mark modified values and provide a per-setting reset. Preserve drafts on failure, and isolate irreversible actions in a labelled danger zone at the bottom.

## Submit

On submit, keep focus, swap the label to a loading state, set `aria-busy`, and block repeat
requests in the handler without removing the button from the interaction model. Keep its
width fixed. On success, move focus to the confirmation. On failure, keep every value
entered; never clear a form because the server said no.

## Accessibility

- Real `<form>`, real `<button type="submit">`; Enter submits.
- `aria-invalid="true"` on failing fields; error text referenced by `aria-describedby`.
- The error summary is a focusable `role="alert"` region listing links to each bad field.
- Correct `type`, `inputmode`, and `autocomplete` on every field; it is the cheapest usability win available.
- Grouped inputs (radios, checkbox sets, address blocks) live in a `<fieldset>` with a `<legend>`.

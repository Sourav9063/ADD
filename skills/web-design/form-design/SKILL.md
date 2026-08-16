---
name: form-design
description: Build or review forms, inputs, and their states. Use when creating a form, login or signup screen, settings page, checkout, stepper or wizard, or when handling field labels, placeholders, validation, error messages, required fields, autosave, or submit buttons.
---

# Form Design

Assumes `design-foundations` for tokens, motion, and contrast.

## Field anatomy

Fixed vertical order, always: **label → input → helper text → error text**.

- **Label above the field.** A placeholder is not a label — it disappears the moment the user types, so they lose the question while answering it. Placeholders are for format examples only (`MM/YY`), and even then a helper line is safer.
- Helper text sits below and stays visible in every state. Error text replaces it in place, so the row height must be reserved up front — otherwise the layout jumps on validation.
- Label ties to the input with `<label for>` (or wrapping). Helper and error tie with `aria-describedby`.
- Field width should hint at expected length: a ZIP field the width of an email field is a lie.
- Mark **optional** fields, not required ones, when most are required — and vice versa. Whichever is rarer gets the marker. If you use `*`, define it once at the top.

## The six states

Design all six or one of them will look like a bug.

| State | Treatment |
| --- | --- |
| Default | Surface fill + border at ≥3:1 against the page |
| Focus | 2px ring, 2px offset, ≥3:1 contrast — not a soft glow |
| Error | Red border **+ icon + message** saying what is wrong and how to fix it |
| Success | Inline check inside the field, where the eye already is — not a toast |
| Disabled | Grayscale fill, `not-allowed` cursor, `disabled` attribute, and an explanation nearby of what unlocks it |
| Loading | In-field spinner and input blocked, so it cannot be mistaken for disabled |

Do not fake disabled with `opacity: 0.5` — that reads as loading. Never disable a submit
button as the only validation feedback; let it be pressed and show the errors, or the
user is stuck with no explanation.

## Validation timing

1. **On blur** — validate a field when focus leaves it. Late enough that the user finished, early enough that they are still thinking about it.
2. **After it errors, switch that field to live validation**, so the error clears the instant the input becomes valid.
3. **Never on keystroke for a field that has not errored yet.** Flagging "invalid email" at `s@` is hostile.
4. **On submit**, validate everything, focus the first invalid field, and announce the count.
5. Show a positive check when a field is right — confirmation is feedback too.

## Error copy

Say what happened and what to do: "Password needs 8+ characters" beats "Invalid input".
Never blame ("You entered..."), never expose the validator's language (`ValidationError:
regex mismatch`). Put the message beside the field it belongs to; a summary at the top is
an addition for long forms, not a replacement.

## Specific inputs

- **Password**: reveal toggle, live strength meter tied to real entropy rather than arbitrary symbol rules, rules shown before typing starts, and `autocomplete="new-password"` / `"current-password"`.
- **OTP**: one input per digit but a single logical field — auto-advance, backspace goes back, paste fills every box, `inputmode="numeric"` and `autocomplete="one-time-code"`. Verify automatically on the last digit.
- **Masked input** (card, phone): format while typing, keep the caret from jumping, never reject characters silently, and submit the unmasked value.
- **Date**: let people type. A picker is the fallback, not the only path. Default the view near the likely date (birthdays start at years, bookings start at today) and mark today, selected, and disabled dates distinctly.
- **File upload**: click *and* drop, per-file progress, cancel and retry, state accepted types and size limit before the attempt, and fail one file without losing the others.
- **Toggle vs checkbox**: toggle = takes effect immediately; checkbox = takes effect on submit. Never a toggle inside a form with a Save button.
- **Select**: below ~7 options use radios; above ~15 make it searchable.

## Long and multi-step forms

- Split at meaningful boundaries, one topic per step, with a step indicator showing position and total.
- Never lose entered data on Back. Validate each step before advancing.
- **Autosave**: debounce ~500–1000ms, show a real three-state indicator (`Saving… / Saved HH:MM / Couldn't save — retry`), and never claim "Saved" until the server confirmed it. Keep the draft locally so a dropped connection does not delete work.
- Warn before navigating away with unsaved changes.

## Submit

Disable-on-submit to prevent double posts, swap the label to a loading state, and keep
the button width fixed. On success, move focus to the confirmation. On failure, keep every
value entered — never clear a form because the server said no.

## Accessibility

- Real `<form>`, real `<button type="submit">`; Enter submits.
- `aria-invalid="true"` on failing fields; error text referenced by `aria-describedby`.
- The error summary is a focusable `role="alert"` region listing links to each bad field.
- Correct `type`, `inputmode`, and `autocomplete` on every field — it is the cheapest usability win available.
- Grouped inputs (radios, checkbox sets, address blocks) live in a `<fieldset>` with a `<legend>`.

## Checklist

- [ ] Label above; helper and error space reserved so nothing shifts.
- [ ] All six states styled, disabled distinguishable from loading.
- [ ] Blur-then-live validation; no keystroke errors on a first pass.
- [ ] Errors carry icon + text, sit next to the field, and say the fix.
- [ ] `autocomplete`/`inputmode` set; keyboard-only submit works; values survive failure.

---
name: form-design
description: Build or review forms, inputs, and their states. Use when creating a form, login or signup screen, settings page, checkout, stepper, wizard, or inline editor, or when handling field labels, placeholders, validation, error messages, required fields, autosave, or submit buttons.
---

# Form Design

Assumes `design-foundations` for tokens, motion, and contrast.

## Field anatomy

Fixed vertical order, always: **label → input → helper text → error text**.

- **Label above the field.** A placeholder is not a label: it disappears the moment the user types, so they lose the question while answering it. Placeholders are for format examples only (`MM/YY`), and even then a helper line is safer.
- Helper text sits below and stays visible in every state. Error text replaces it in place, so the row height must be reserved up front; otherwise the layout jumps on validation.
- Label ties to the input with `<label for>` (or wrapping). Helper and error tie with `aria-describedby`.
- Field width should hint at expected length: a ZIP field the width of an email field is a lie.
- Mark **optional** fields, not required ones, when most are required, and vice versa. Whichever is rarer gets the marker. If you use `*`, define it once at the top.

## The six states

Design all six or one of them will look like a bug.

| State | Treatment |
| --- | --- |
| Default | Surface fill + border at ≥3:1 against the page |
| Focus | 2px ring, 2px offset, ≥3:1 contrast, not a soft glow |
| Error | Red border **+ icon + message** saying what is wrong and how to fix it |
| Success | Inline check inside the field, where the eye already is, not a toast |
| Disabled | Grayscale fill, `not-allowed` cursor, `disabled` attribute, and an explanation nearby of what unlocks it |
| Loading | In-field spinner and input blocked, so it cannot be mistaken for disabled |

Do not fake disabled with `opacity: 0.5`; that reads as loading. Never disable a submit
button as the only validation feedback; let it be pressed and show the errors, or the
user is stuck with no explanation.

## Validation timing

1. **On blur**: validate a field when focus leaves it. Late enough that the user finished, early enough that they are still thinking about it.
2. **After it errors, switch that field to live validation**, so the error clears the instant the input becomes valid.
3. **Never on keystroke for a field that has not errored yet.** Flagging "invalid email" at `s@` is hostile.
4. **On submit**, validate everything, focus the first invalid field, and announce the count.
5. Show a positive check when a field is right; confirmation is feedback too.

## Error copy

Say what happened and what to do: "Password needs 8+ characters" beats "Invalid input".
Never blame ("You entered..."), never expose the validator's language (`ValidationError:
regex mismatch`). Put the message beside the field it belongs to; a summary at the top is
an addition for long forms, not a replacement.

## Specific inputs

- **Password**: reveal toggle, live strength meter tied to real entropy rather than arbitrary symbol rules, rules shown before typing starts and updated per keystroke, and `autocomplete="new-password"` / `"current-password"`. **Never block paste** — it breaks password managers and is a WCAG 2.2 failure — and offer a one-tap generated password.
- **OTP**: one input per digit but a single logical field: auto-advance, backspace on an empty box clears the previous one, paste fills every box, `inputmode="numeric"` and `autocomplete="one-time-code"`. Hold the value as one string, not an array of characters. Verify automatically on the last digit; on a wrong code clear the boxes and return focus to the first. Put Resend behind a visible countdown (~30s) rather than a dead button.
- **Masked input** (card, phone): format while typing in fixed chunks, keep the caret directly after the character just typed rather than jumping to the end, and validate on blur so nothing reads "invalid" mid-entry. On paste, strip separators and reformat instead of rejecting. Store and submit the unmasked value.
- **Date**: let people type, and lead with presets (`Today`, `Last 7 days`, `Last 30 days`) — they cover the large majority of real selections, with the calendar reserved for the rest. Default the view near the likely date (birthdays start at years, bookings start at today) and mark today, selected, and disabled dates distinctly. For ranges: first click sets the start, second sets the end, hovering previews the span, and both edges stay draggable afterwards. Show two months side by side on desktop. Keyboard is arrows to move, Page Up/Down for months, Shift+Page Up/Down for years, Enter to commit, Escape to close. On mobile use a full-height sheet with the confirm button in thumb reach, not a shrunken desktop popover.
- **File upload**: click *and* drop, with the dropzone changing state on drag-over so the target is obvious before release. Per-file progress showing percent and time remaining (not a bare spinner), cancel and retry inline without re-selecting the file, and state accepted types and size limit before the attempt. Confirm each file with a thumbnail, type, and size — a filename alone is not confirmation. One file failing must not take the queue down with it.
- **Toggle vs checkbox**: toggle = takes effect immediately; checkbox = takes effect on submit. Never a toggle inside a form with a Save button. The thumb must move far enough to read as a position change (rail roughly twice the thumb's width), the label states the thing being switched (not "On"), and state survives grayscale — a colored track alone fails. Animate rail color, thumb position, and label together over ~250ms; an instant snap loses the causality. For a toggle that hits the network, flip optimistically, show progress in place, and roll back visibly on failure so it never sits in an ambiguous state. Space toggles, focus ring visible, `aria-checked` set — or use a real checkbox input and style it.
- **Select**: below ~7 options use radios; past ~10 make it searchable rather than scrollable. The trigger needs a visible caret, a real hover and focus state, and a full-size touch target; the menu flips above the trigger when there is no room below.
- **Range slider**: pair every slider with a numeric input, since a drag cannot be precise and a 4px track cannot be hit on touch. Expand the drag zone to the full row height, keep handles at ≥44px hit areas, and make the filled portion of the track the value — an unfilled track forces guessing. Show the value in a readout or a tooltip floating above the handle during the drag, snap to steps when round numbers matter, and let arrow keys step with Home/End jumping to the extremes. Expensive work commits on release, not on every move. Two-handle ranges fill the band between the handles and must not let them cross.
- **Rating**: make the current value readable as text, not only as filled stars. Fill stars ahead of the cursor so the value previews before commit, keep that preview separate from the committed value, and snap back when the pointer leaves without clicking. Allow correcting and clearing a submitted rating, support arrow keys over a radio group, and never accept a rating on hover — a stray pointer must not submit an opinion. When displaying an average, show the count beside it and render partial fills truthfully; rounding 3.4 up to four full stars is a small lie users notice.
- **Color picker**: always allow typing a value (hex, or `oklch` when you want predictable lightness steps), show the picked color against the surface it will actually appear on, and keep recent and preset swatches within one tap. Show a live contrast result while picking rather than after review, so a failing choice is caught at the moment it is made. Preview alpha over both light and dark backgrounds — a white canvas hides what transparency actually does. A gradient canvas with no text input is unusable by keyboard; name swatches for screen readers.

## Long and multi-step forms

- Split at meaningful boundaries, one topic per step, with a step indicator showing position and total. Visible, incomplete progress is what pulls people through a long form, so show how much is done and how much remains rather than a bare step name; never start the bar at zero when the first step is already behind them.
- Never lose entered data on Back. Validate each step before advancing.
- **Autosave**: debounce ~500–1000ms and model `typing / saving / saved / offline / error` explicitly; never claim "Saved" until the server confirms. Queue offline edits locally, show the pending count, and replay oldest first on reconnect.
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

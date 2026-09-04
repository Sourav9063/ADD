---
name: text-input
description: Build or review a single-line text input or textarea. Use when adding a text, email, number, phone, URL, or search field, a multiline textarea, prefixes, suffixes, character counters, or clear buttons, or when handling input width, keyboard type, autofill, readonly, or field-level error display.
---

# Text Input

Assumes `design-foundations` for tokens and focus. Form layout, validation timing, and error
copy belong to `form-design`; this skill is the field.

## Anatomy

Fixed vertical order, always: **label → input → helper text → error text**.

- **Label above the field**, always visible. A placeholder is not a label: it vanishes the moment typing starts, taking the question with it, and it fails contrast in most designs. Use placeholders for format examples only (`MM/YY`), and prefer a helper line even then.
- Reserve the helper and error row's height up front, or validation shifts the whole form down.
- `<label for>` (or a wrapping label) ties the name; `aria-describedby` ties helper and error text.
- **Width hints at expected length.** A ZIP field as wide as an email field is a lie about what is wanted. Match the field to the content, not to the container.
- Affixes (currency symbol, `https://`, units) sit inside the field boundary with the input padded around them, and are not part of the value. Never make the user retype what the affix already states.

## Keyboard, autofill, and platform

- Set `type`, `inputmode`, and `autocomplete` on every field. It is the cheapest usability win available: it selects the right on-screen keyboard, enables autofill, and makes password managers work.
- `type="number"` only for genuine quantities with spinners; it mangles phone numbers, card numbers, and anything with leading zeros. Use `inputmode="numeric"` with `type="text"` and pattern validation instead.
- Font size 16px or larger on mobile, or iOS zooms the page on focus and never zooms back.
- `enterkeyhint` on the last field of a mobile form ("send", "search", "go") so the return key does what the user expects.
- `spellcheck="false"` and `autocapitalize="off"` for codes, usernames, and identifiers.

## States

| State | Treatment |
| --- | --- |
| Default | Surface fill, border ≥3:1 against the page |
| Hover | Border darkens slightly; do not move or resize the field |
| Focus | 2px ring at 2px offset, ≥3:1, not a soft glow |
| Filled | Visually distinct from empty only if the design depends on it; never remove the label |
| Error | Border + icon + message; `aria-invalid="true"` |
| Success | Inline check inside the field, where the eye already is - never a toast, and only where confirmation earns its place |
| Disabled | Grayscale fill, `not-allowed` cursor, real `disabled`, with the unlock condition stated nearby |
| Readonly | Looks like a value, not a control; still focusable and copyable |
| Loading | In-field spinner with input blocked, so it cannot be mistaken for disabled |

Do not fake disabled with `opacity: 0.5`; it reads as loading. Readonly and disabled are
different promises: readonly means "this is the value and you cannot change it here",
disabled means "this is not applicable yet".

## Content behavior

- Trim leading and trailing whitespace on submit, never while typing - deleting a space under the caret feels like a bug.
- Preserve what the user typed. Reformatting on blur is fine; silently rewriting during entry is not (see `date-picker` and masked input in `form-design`).
- `maxlength` silently swallows the last keystroke. Prefer a counter that shows the remaining count, warns near the limit, and lets a paste land so the user can edit it down.
- A character counter is announced politely, not on every keystroke, and states the unit ("120 characters left"), not a bare number.
- A clear button is a real button with a name ("Clear search"), at least 24px, and it returns focus to the field.

## Textarea

- Size it to the expected answer: three rows for a note, ten for a description. A one-line textarea invites one-line answers.
- Allow resizing (`resize: vertical`) or auto-grow to a cap and then scroll. Never `resize: none` on a long-form field.
- Enter inserts a newline. If ⌘/Ctrl+Enter submits, say so near the control.
- Preserve drafts across navigation and errors; losing a long answer is the most expensive failure a form has.

## Accessibility

- Every input has a programmatic name. A placeholder is not one, and neither is adjacent text without `for`/`id`.
- Errors: `aria-invalid="true"` plus the message referenced by `aria-describedby`, announced when it appears (`feedback-design`).
- Never rely on color alone for the error or success state; pair with an icon and text.
- Do not hijack Backspace, Escape, or arrow keys inside a field.
- Group related fields (address, name parts) in a `<fieldset>` with a `<legend>`.

---
name: password-input
description: Build or review a password field. Use when adding a password, new-password, or change-password input, a reveal toggle, a strength meter, password rules and requirements, a generated-password offer, or when password managers and paste are not working.
---

# Password Input

Assumes `text-input` for the field and `auth-flow-design` for the surrounding flow. This is
the field people fail most often, and almost every failure is the design's fault.

## Non-negotiables

- **Never block paste, and never `autocomplete="off"`.** Both break password managers, which are the single largest security improvement available to your users, and blocking paste on a one-time or generated credential is a WCAG 2.2 accessible-authentication failure.
- Set the right token: `autocomplete="current-password"` when signing in or confirming the old password, `autocomplete="new-password"` when creating or resetting one - including on a confirmation field.
- Accept long values: at least 64 characters, spaces, Unicode, and every printable character. A `maxlength` of 16 rejects exactly the passwords you want people to use.
- Never send, log, or echo the value. No password in a URL, a toast, a confirmation email, or an analytics event.

## Reveal toggle

- Ship one. Typing a long generated password blind, on a phone, is where retries and lockouts come from.
- It is a real `<button>` inside the field with `aria-pressed`, an accessible name that changes ("Show password" / "Hide password"), and a 24px minimum target.
- Default hidden, revert to hidden on submit and on blur where the surface is shared or public.
- Do not implement it by swapping the input's `type` in a way that destroys autofill or moves the caret to the end mid-edit.
- Warn when Caps Lock is on, near the field, rather than letting the user fail twice.

## Requirements and strength

- **State the rules before typing starts**, as visible text - not in a tooltip, not only in the error. Then validate them live, marking each rule met as it is met.
- Say what is wrong specifically: "Needs 8 or more characters", not "Invalid password".
- Prefer a length minimum plus a breached-password check over composition rules. Forced symbol-and-digit recipes produce `Password1!` and nothing more secure.
- A strength meter must reflect actual entropy - length and predictability - not a count of character classes. A meter that calls `Aa1!aaaa` strong is teaching the wrong lesson.
- Keep the meter's states few (weak / fair / strong), paired with words and not only color, and never block submission on a subjective rating; block on the stated rules.
- Offer a **generate** control that fills the field, reveals the value, and copies it, so the safe path is also the fast one.

## New password and confirmation

- With a working reveal toggle, a confirm-password field earns nothing but typos of itself. Drop it, or keep it only where the account cannot be recovered.
- If it stays, validate it on blur against the first field and never before the first field is complete.
- On a change-password form, ask for the current password once, and say plainly that other sessions will end if they will.
- After a successful change or reset, sign the user in or return them to what they were doing - never dump them at a login screen to type the password they just created.

## Errors and lockout

- On a failed sign-in, keep the identifier, clear only the password, focus the password field, and keep the message generic about which credential was wrong (`auth-flow-design`).
- Count-based lockout states that it is a lockout, how long it lasts, and how to recover. Silent throttling reads as a broken product.
- Never reveal whether the account exists through timing, wording, or a different error style.

## Accessibility

- Real `<input type="password">` with a visible, programmatic label. Screen readers announce it as a password field; a masked text input does not.
- Errors use `aria-invalid` plus a message referenced by `aria-describedby`, announced when it appears.
- Requirement lists are associated with the field and their met/unmet state is conveyed in text, not only by a green tick's color.
- Do not auto-submit on a length threshold, and never clear the field on an unrelated validation error elsewhere in the form.

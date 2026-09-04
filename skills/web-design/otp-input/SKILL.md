---
name: otp-input
description: Build or review a one-time code input. Use when adding an OTP, verification code, 2FA, magic-link code, or PIN entry field, segmented code boxes, autofill from SMS or an authenticator, resend timers, or when a code entry loses digits on paste or backspace.
---

# OTP Input

Assumes `text-input` for the field and `auth-flow-design` for the flow around it. The code
is **one value**, however many boxes it is drawn as. Every classic bug in this component
comes from modelling it as an array of characters.

## The field

- Hold the value as a single string in state. Render segments if the design calls for it, but never store six independent inputs - that is what breaks paste, backspace, and autofill.
- `inputmode="numeric"` and `autocomplete="one-time-code"`, so iOS and Android offer the code from SMS and Chrome offers it from the platform. This one attribute removes most of the friction in the flow.
- Accept the code in any shape the user has: **paste fills every box**, spaces and dashes are stripped, and a code copied with a trailing newline still works. Rejecting a pasted code because it "does not match the format" is the most common failure here and a WCAG 2.2 accessible-authentication failure.
- Fixed width per segment with tabular numbers so the boxes do not shift as digits land (`typography-design`).
- Alphanumeric codes are uppercase-insensitive: accept either case and display one.

## Typing behavior

- Auto-advance on entry, and **backspace on an empty box clears and moves to the previous one**. Without that, correcting a typo means clicking each box.
- Arrow keys move between segments; clicking any segment puts the caret in the right place rather than always the first.
- Overtyping a filled segment replaces it instead of being ignored.
- Never advance past the last segment or wrap around to the first.
- **Verify automatically once the last digit lands.** A code entry with a separate submit button makes people type six digits and then hunt for a button.

## The wait and the retry

- Say where the code went and to which address or number, partially masked ("•••• 4417"), with a way to correct it that does not restart the flow.
- **Resend behind a visible countdown** (~30s), not a dead button and not an unlimited one. Show the timer, then enable it with an obvious label.
- Offer the alternate factor next to resend ("Use an authenticator app instead", "Call me instead"), because SMS is the factor most likely to fail.
- State the expiry in the copy ("This code expires in 10 minutes") and, when it expires, say so and offer a new one rather than returning "Invalid code".
- On a wrong code: clear the boxes, return focus to the first, announce the error, and keep the remaining-attempts count visible if there is a lockout.

## Accessibility

- If the value is segmented, each segment needs a name ("Digit 1 of 6") and the group needs a `<fieldset>`/`<legend>` or `role="group"` with a label naming the whole thing ("Verification code").
- Announce arrival, verification, and failure politely; do not announce every digit.
- Prefer a single `<input>` with letter-spacing over six inputs when the design allows it. It is simpler, pastes cleanly, and reads correctly to screen readers and password managers.
- Auto-submit must still leave a visible submit path for anyone whose assistive tech or input method fills the field differently.
- Targets stay at 44px on touch; a row of six 32px boxes is unusable one-handed.

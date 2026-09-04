---
name: auth-flow-design
description: Build or review authentication flows end to end. Use when designing sign-in, sign-up, social login, passkeys, magic links, two-factor and one-time codes, password reset, email verification, account lockout, session expiry, or step-up re-authentication, or when login is losing users or blocking password managers.
---

# Auth Flow Design

Assumes `form-design` for field anatomy, labels, and validation, and `design-foundations`
for tokens and focus. This skill owns the flow: what is asked, in what order, what happens
when it fails, and how someone gets back in.

## Gate as late and as little as possible

- Ask for an account when the product needs one, not on arrival. Anything that can be tried first - browsing, a demo, a guest checkout - should be.
- Sign-up asks for the minimum that the next step requires. Everything else is collected later, in context, when the user has a reason to give it.
- Never make the user choose "Sign in" versus "Sign up" before they can type. In an identifier-first flow, continue with the same UI and generic copy regardless of whether the account exists; do not branch visibly to sign-in or sign-up based on the lookup. When a low-risk product deliberately accepts that disclosure for usability, record the threat decision and rate-limit the lookup.
- If sign-in and sign-up stay separate, put the link to the other one where people look for it, and carry the typed email across.

## The sign-in form

- One column, real `<label>`s, submit on Enter, and the form works before JavaScript loads if the stack allows it.
- Mark up for password managers or people will not use one: `autocomplete="username"` on the identifier (with `type="email"` when it is an email). The password field's own contract - tokens, paste, reveal, strength - is `password-input`.
- For passkeys, append the `webauthn` token last (`autocomplete="username webauthn"`); the attribute is parsed from the right. Offer passkeys as the primary path where supported and keep a password or email-link fallback, since not every device and browser can do conditional UI.
- On failure, keep the identifier filled and clear only the password, put focus on the field to correct, and never dump the user back to an empty form.
- Show which method they used last ("You signed in with Google") on the account, so social sign-in does not silently create a duplicate account.

## Passwords and sign-up

- Set the policy here, not in the field: minimum length 15 when the password is the only factor, or 8 only when it is always used as part of multi-factor authentication; accept at least 64 characters; impose no composition rules or scheduled expiry; screen against a breached-password list; and force a change only on evidence of compromise. `password-input` renders and validates whatever policy you set.
- No "confirm email" field, ever. It mostly generates typos of itself.
- Explain any required field that is not obviously necessary, and say what happens next ("We'll email a link to confirm this address").
- Let people finish sign-up before verification when the product allows it, with a persistent banner to verify, rather than stranding them on a "check your email" dead end.

## One-time codes and second factors

- The code field itself is `otp-input`: one logical value, paste in any format, auto-submit on completion, resend behind a countdown.
- Let the user change the destination without restarting the flow, and never expire a code so fast that someone switching devices loses the race. State the expiry.
- Offer more than one factor and **issue recovery codes at enrollment**, with a stated way back in if the device is lost. An account with exactly one recoverable path will lock people out.
- Remember-this-device is opt-in, scoped, and revocable from the account, with the list of trusted devices visible.

## Reset, recovery, and lockout

- Reset requests get one message whether or not the account exists, and that message says to check spam and how long the link lasts.
- Reset links are single-use and short-lived. On success, sign the user in, tell them other sessions were ended, and notify the account by email.
- Before identity is established, nonexistent, locked, disabled, and credential-mismatch cases use the same generic response, HTTP status, and approximately equal timing. Offer reset or support without confirming which condition occurred.
- After the user proves control through an authenticated session or recovery channel, name an actionable condition such as lockout, expired link, or unverified email, including how to resolve it and how long it lasts.

## Sessions and step-up

- Long-lived sessions by default; forcing re-login on an active user rarely buys the security it claims. Where a timeout exists, warn before it fires with an extend control, and preserve unsaved work through the re-auth.
- Sensitive changes - password, email, payment, deletion, key export - re-authenticate at the point of the action, in place, without discarding the form the user was filling.
- Sign-out clears local state, says it worked, and lands somewhere useful. Offer "sign out of all devices" where sessions are listed.
- Expiring mid-request must return the user to what they were doing after sign-in, not to a dashboard.

## Accessibility and anti-abuse

- WCAG 2.2 forbids a cognitive function test with no alternative. Passkeys, email links, OAuth, paste, and password-manager autofill all satisfy it; transcribing a code by hand, solving a puzzle, or retyping a password from memory as the only path does not.
- Prefer invisible or risk-based challenges to CAPTCHA. Where a challenge is unavoidable, only object recognition and personal-content recognition are permitted alternatives, and there must be a non-visual route.
- Errors are announced, not just colored: server-side failures go to a live region and take focus to the first field to fix (see `feedback-design`).
- Every step works at 320 CSS pixels wide, at 200% zoom, and one-handed on mobile, with the numeric keypad for codes.
- Copy carries the weight here: name the provider, name the address, say what happens next. See `microcopy`.

---
name: microcopy
description: Write or review interface text. Use when wording buttons, labels, placeholders, helper text, error and empty-state messages, confirmations, tooltips, onboarding, notifications, or permission prompts, and when copy sounds robotic, vague, blaming, or inconsistent.
---

# Microcopy

Copy carries as much weight as layout. Identical forms convert differently on wording
alone. Every string is UI, so it gets designed, not typed in at the end.

## Principles

- **Write the outcome, not the mechanism.** "Create my free account" beats "Submit"; "Get my report" beats "Continue". The user should be able to predict what happens from the label alone.
- **Second person, active voice, present tense.** "You'll get a receipt by email", not "A receipt will be sent to the user."
- **Front-load the meaning.** People scan the first two words of everything. "Payment failed: card expired" beats "There was a problem processing your recent payment."
- **Shortest version that is still clear.** Cut "please", "simply", "just", "in order to", and any sentence that only restates the heading. But never cut to the point of ambiguity; brevity is not the goal, clarity is.
- **Use the user's words**, not the database's. "Team" not "Organization entity", "Photo" not "Asset".
- **Say the same thing the same way everywhere.** Delete/Remove, Sign in/Log in, Folder/Collection: pick one per concept and enforce it. Inconsistent nouns make users think two things exist.
- **Never blame the user.** "That code has expired", not "You entered an invalid code."
- **No jargon, no log output.** "Operation failed", "Error 500", "Null reference" are messages to yourself, not to a person.

## By surface

**Buttons**: verb + object, sentence case: *Save changes, Delete project, Send invite*.
Never OK/Yes/No in a dialog; the label restates the action so the button reads correctly
without the question. Cancel stays "Cancel".

**Labels**: nouns, above the field, persistent. A placeholder is not a label; it vanishes
mid-answer. Use placeholders only for format examples (`name@company.com`).

**Helper text**: set expectations *before* the mistake: "8+ characters, one number" beats
an error after the fact. Say why you need unusual data ("We use this to calculate tax").

**Errors**: three parts: what happened, why, what to do next. *"That email's already
registered; sign in instead?"* Not "Invalid input". Keep the message beside the thing that
failed, and put the stack trace behind Details with a copyable reference ID.

**Empty states**: one line of what belongs here, one line of value, one CTA to the first
real step. Write like a product, not a log file: never "No records found" on a first run.
Distinguish nothing-yet from nothing-matching (see `feedback-design`).

**Confirmations**: name the object and the consequence: *"Delete 'Q3 Report'? This can't be
undone."* Never "Are you sure?" alone. If it is reversible, skip the dialog and offer Undo.

**Success**: confirm the specific thing ("Invite sent to ada@example.com"), not "Success!".

**Tooltips**: a short clarification, never required information, never a paragraph.

**Notifications**: say who did what to which object, and lead with the object when the
actor is the system.

**Onboarding and permissions**: explain the benefit before the ask. "Turn on notifications
so you know when a teammate replies" gets granted; a bare system prompt gets dismissed
forever.

**Numbers and dates**: spell out ambiguity: "3 days left" not "72h"; "Ends 14 Mar 2026"
not "14/03". Handle singular/plural properly ("1 file" / "2 files"), and never show `0`
where "None yet" reads better.

## Draft content is content

Placeholder text is the loudest signal that nobody read the screen. Whatever ships into a
review, a demo, or a screenshot is judged as the product.

- **No Lorem Ipsum.** Write real draft copy at real length. Fake Latin hides every wrapping, truncation, and hierarchy problem the layout has.
- **No "John Doe", no "Acme Corp".** Use varied, plausible names for people, teams, and products, and vary the string lengths so one long name tests the layout.
- **No round fake numbers.** `99.99%`, `50%`, and `$100.00` read as invented. Organic figures read as real data.
- **No filler vocabulary.** "Elevate", "seamless", "unleash", "next-gen", "game changer", "delve", "in the world of". These say nothing and mark the copy as machine-written.
- **Sentence case for headings**, not Title Case On Everything.
- **No exclamation marks in success messages**, and no "Oops!" in errors. "Connection failed. Try again" respects the reader more than either.

## Tone

Match the user's stress level. Playful in an empty state is charming; playful in a failed
payment is insulting. Humour goes in low-stakes, first-run, and celebratory moments, and
nowhere near money, data loss, security, or errors. Warm and plain always beats clever.

Write for a distracted reader on a phone at ~8th-grade reading level. If a sentence needs a
second pass, rewrite it.

## Inclusive and international

- Default to they/them for unknown people; avoid "guys", "he/she", "crazy", "sanity check", "master/slave", "blacklist".
- No idioms, puns, or sports metaphors; they do not translate and they are the first thing to break in a new market.
- Write each sentence as one translatable string, and give the translator context for anything a key name alone would not explain.

Layout headroom, RTL, plural rules, and locale formats live in
`internationalization-design`.

## Reviewing copy

Read it aloud. Then check: Would a new user know what happens next? Does it say the same
thing as the button they came from? Is there a shorter version that keeps the meaning? Does
it work if the user is angry, or if the number is 0 or 1,000,000? Is anything only in
English-idiom form?

## Checklist

- [ ] Buttons name the outcome; no OK/Submit/Yes-No pairs.
- [ ] Visible labels; placeholders only as format examples.
- [ ] Errors give cause + fix, never blame, never expose internals.
- [ ] Empty states carry one clear next step, tone matched to the situation.
- [ ] One term per concept across the entire product.
- [ ] Plurals, zero states, and long numbers handled.
- [ ] No placeholder copy, placeholder names, round fake numbers, or filler vocabulary.
- [ ] Inclusive language; full-sentence strings; no untranslatable idiom.

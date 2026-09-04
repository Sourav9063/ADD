---
name: onboarding-design
description: Build or review first-run and activation experience. Use when designing a welcome flow, product tour, coach marks or instructional overlays, setup wizard, getting-started checklist, sample data, permission priming, or a new-feature announcement, or when new users sign up and never reach the product's value.
---

# Onboarding Design

Assumes `design-foundations` for tokens and motion. The best onboarding is an interface that
does not need any. Everything here is a fallback for the part of the product that could not
be made self-evident.

## Skip it when you can

Tested against skipping, deck-of-cards tutorials lose: users who read them were slower to
complete their first task and rated the app *harder* to use than users who skipped straight
in. The mechanism is simple - people cannot read an overlay and use the app at the same
time, so they have to memorize instructions that fade from working memory in about twenty
seconds, and a tutorial makes a simple product look complicated.

So: before designing a tour, fix the UI. An overlay that exists to explain an unlabeled
icon, unfamiliar wording, or a hidden gesture is a bug report about the interface. Reserve
walkthroughs for genuinely novel interaction models, and make those interactive - the user
performs the step rather than watching it described.

## The path to first value

- Name the activation moment: the single thing a new user must reach for the product to have proven itself. Design the first session backwards from it and cut everything that does not serve it.
- Defer setup. Ask only for what the first useful action requires and collect the rest in context later (see `auth-flow-design`).
- Prefill the product rather than presenting a void: sample data, a template, an imported source, or a generated first item that can be edited or deleted. A workspace with something in it teaches more than any tour.
- Personalization questions must change what the user then sees. A survey that only feeds analytics is a tax on the person who is least invested.
- **Empty states are the primary onboarding surface** - what this screen will hold, one primary action, a ghost preview of the filled state. `empty-state` owns the anatomy; put the effort there before building anything modal.

## Checklists

- A getting-started checklist works where a tour does not: it persists, it is scannable, and the user chooses the order. Keep it to three to five items that each end in real value, not "watch a video".
- Show progress honestly and mark items complete when the user does them elsewhere in the product. Never re-open a completed task.
- An unfinished list pulls attention back - the same reason a partly filled progress bar draws people on. Use it once; a permanent nag bar is noise.
- It must be dismissible for good, and findable again from help or settings after dismissal.

## Coach marks and tours, if you ship them anyway

- One hint at a time, at the moment the user reaches that part of the UI. A screen annotated with every possible interaction teaches nothing.
- Skip standard icons and self-evident controls. Explain the atypical.
- Style the overlay so it is obviously not part of the interface, and never let it cover the element it describes.
- Every step has Skip and Back, Escape exits, and exiting does not restart on the next visit. Store completion per account, not per browser.
- Make it re-findable: a "Show me again" entry in help beats an unrepeatable one-shot the user dismissed by reflex.
- Prefer pull over push. Help triggered when the user hovers a new control, opens an empty panel, or hesitates on a step lands when it is wanted; a modal on launch interrupts a task the user already has in mind.

## Permissions and data asks

- Prime before the system prompt: explain the benefit in the product's own UI, then trigger the native dialog only when the user opts in. A denied permission is expensive to recover.
- Ask at the point of use - notifications when the first thing worth notifying about exists, location when a location is needed - never in a batch on first launch. See `microcopy` for the wording.
- A refusal must leave the product working, with the feature reachable again later.

## Feature announcements

Same rules as onboarding, with less license to interrupt: announce in place near the feature,
not as a modal over the work someone came to do; show it once, per account; and make it
dismissible with an obvious close. Reserve a modal for changes that alter how the product
behaves - migrations, pricing, destructive defaults - where a missed announcement is worse
than the interruption.

## Accessibility

- A tour step is a dialog: focus moves to it, is trapped while it is open, returns to the anchor on close, and Escape dismisses it (`modal-dialog`).
- Never obscure the focused element with a tooltip, popover, or sticky bar. Announce each step's content and its position ("Step 2 of 4").
- Anything timed - a self-advancing step, an auto-dismissing tip - needs a way to pause or extend it.
- Onboarding motion is decorative; drop it under `prefers-reduced-motion` rather than delaying the content behind it (`motion-design`).
- Nothing in the path may be reachable by pointer alone, and hover-triggered help needs a focus equivalent.

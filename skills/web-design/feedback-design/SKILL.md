---
name: feedback-design
description: Decide how a system answers the user. Use when choosing between a spinner, skeleton, progress bar, inline message, toast, banner, and dialog, when designing loading, empty, error, and success states for a surface, when adding optimistic updates or undo, or when the UI feels slow, silent, or unclear about whether an action worked.
---

# Feedback Design

Assumes `design-foundations` for tokens and motion. Every action needs an answer within
100ms and a resolution the user can trust. This skill chooses the response; the surfaces
own their own rules: `loading-indicators`, `empty-state`, `toast`, `alert-banner`, and
`modal-dialog`.

## Match the pattern to the wait

| Wait | Pattern |
| --- | --- |
| < 300ms | **Nothing.** A flash of a spinner reads as a glitch, not as feedback |
| 300ms-3s, known content shape | **Skeleton** in the real layout |
| 300ms-3s, unknown shape or in-button | **Spinner**, scoped to the thing that is loading |
| > 3s with known progress | **Progress bar** with percentage, plus time remaining or speed |
| > 3s without progress | Staged status text ("Compressing… Uploading… Finishing") |
| Reversible action | **Optimistic update**, no indicator at all |

Never spinner a full page; keep the primary structure (nav, header, filters) rendered and
load only the region that changes. Perceived speed matters more than measured speed: past
~400ms of silence attention leaves, so respond immediately even if the work continues.

## Choosing the notification surface

| Surface | Use for | Dismissal |
| --- | --- | --- |
| **Inline** (next to the control) | Validation, per-item results | Resolves with the state |
| **Toast** (bottom or top corner) | Transient confirmations, undo | Auto after 4-7s |
| **Banner** (top of page or section) | Persistent conditions: expired card, degraded service | User dismiss or condition clears |
| **Modal** | Blocking decisions only | Explicit action |
| **Notification center** | History, async completions | Read state |

Pick the wrong surface and people tune all of them out. The test is duration and
consequence: transient and minor is a toast, true-until-fixed is a banner, must-decide-now
is a dialog, belongs-to-one-control is inline.

## Optimistic UI and undo

- Apply reversible actions (like, star, reorder, mark read) instantly and reconcile in the background. On failure, revert visibly and say why; a silent revert is worse than a slow save.
- Prefer **undo over confirm** for reversible destructive actions: perform it, show "Deleted. Undo" for 5-10 seconds with a visible countdown, and pause the timer on hover or focus (`toast`). Save the confirmation dialog for the genuinely irreversible.
- Undo must be reachable by keyboard before the toast disappears; keep a permanent path (trash, history) as well.
- **Back undo with a soft delete**: flag the record and keep it recoverable for a stated retention window, then hard-delete on expiry. An immediate hard delete makes the Undo button a lie the first time the request loses the race. Where the product has a real undo stack, wire ⌘Z to it.
- Optimistic UI is for cheap, reversible work. Payments and irreversible operations keep a truthful busy state and confirm only after the write commits.
- Client validation provides fast feedback; it does not establish success. Revalidate on the server, show success only after related writes commit, and repaint IDs, totals, permissions, and other trusted values from the response rather than from what was sent.

## Errors

- Say what happened, why, and what to do next, in the user's terms. Keep the technical detail behind a "Details" disclosure and log the correlation ID.
- Put the error at the level it happened: a field error inline, a section error in that section, a page error as a page. Do not blow away a working screen for one failed widget.
- Always offer a way forward: Retry, go back, contact support with a prefilled reference.
- Auto-retry transient network failures a couple of times with backoff before telling the user anything.
- Never blame the user, never use a modal for a non-blocking error, and never put an error the user must act on in a disappearing toast.

## Success

Confirm where the action happened: an inline check on the saved field beats a toast that
steals attention and vanishes before it is read. Reserve celebration animations
(500-800ms, with overshoot) for genuine milestones; on every ordinary save they become
noise.

People remember a flow by its worst moment and its last one, not by its average. Spend the
effort on the sharpest pain (the error, the wait, the rejection) and on the final screen; a
rough middle with a clean ending is remembered better than an even, forgettable flow.

## State completeness

Every data-bearing surface ships five states, not one: **default, loading, empty, error,
and the too-much case** (long strings, huge numbers, hundreds of rows). Designing only the
happy path is the most common reason an interface looks unfinished. `empty-state` covers
the four kinds of empty; `responsive-design` covers overflow behavior.

Three more apply wherever the data source can produce them, and each needs its own
treatment rather than being folded into "loading" or "error": **partial** (some regions
resolved, others failed), **stale** (showing a cached or last-known value, which must say
how old it is), and **offline** (queued work and what happens on reconnect). This is the
canonical list; other skills select from it rather than restating it.

## Accessibility

- Live regions: `aria-live="polite"` for status and success, `role="alert"` (assertive) for errors. Do not make every message assertive.
- Loading containers get `aria-busy="true"`; buttons keep their accessible name and their focus while showing a spinner ("Saving…").
- Timed content needs a way to extend or dismiss it; hover and focus pause any countdown.
- Never communicate state with color alone: pair with icon and text.
- Announce result counts and step transitions; a screen reader user gets no benefit from a spinner.

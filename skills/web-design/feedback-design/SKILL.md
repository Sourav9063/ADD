---
name: feedback-design
description: Build or review system feedback. Use when adding loading indicators, spinners, skeletons, progress bars, empty states, error screens, success confirmations, toasts, banners, optimistic updates, undo, or when the UI feels slow, silent, or unclear about whether an action worked.
---

# Feedback Design

Assumes `design-foundations` for tokens and motion. Every action needs an answer within
100ms and a resolution the user can trust.

## Loading: match the pattern to the wait

| Wait | Pattern |
| --- | --- |
| < 300ms | **Nothing.** A flash of a spinner reads as a glitch, not as feedback |
| 300ms–3s, known content shape | **Skeleton** in the real layout: same boxes, same rhythm |
| 300ms–3s, unknown shape or in-button | **Spinner**, scoped to the thing that is loading |
| > 3s with known progress | **Progress bar** with percentage, plus time remaining or speed |
| > 3s without progress | Staged status text ("Compressing… Uploading… Finishing") |
| Reversible action | **Optimistic update**, no indicator at all |

Never spinner a full page; a lone spinner on a blank screen reads as frozen. Skeletons
are not a default; a skeleton that does not match the final layout causes a visible jolt
when content lands. Keep the primary structure (nav, header, filters) rendered and load
only the region that changes. Perceived speed matters more than measured speed: past
~400ms of silence attention leaves, so respond immediately even if the work continues.

## Optimistic UI and undo

- Apply reversible actions (like, star, reorder, mark read) instantly and reconcile in the background. On failure, revert visibly and say why; a silent revert is worse than a slow save.
- Prefer **undo over confirm** for reversible destructive actions: perform it, show "Deleted. Undo" for 5–10 seconds, and pause the timer on hover or focus. Save the confirmation dialog for the genuinely irreversible.
- Undo must be reachable by keyboard before the toast disappears; keep a permanent path (trash, history) as well.

## Empty states

Four different situations, four different treatments; never one shared "No data".

- **First run**: icon or illustration, one line of what this screen will hold, one primary CTA to create the first item, and a ghost preview of what a filled state looks like. This is the best onboarding surface in the product.
- **No results (search)**: echo the query, suggest corrections or broader terms.
- **Filtered out**: name the active filters and offer Clear all (see `filter-design`).
- **Error**: what failed, whether it is being retried, and a Retry button.

A bare blank screen is indistinguishable from a crash. Write like a product, not a log
file; never "ERROR 404: result set empty". One CTA, contextual, not "Try refreshing".

## Errors

- Say what happened, why, and what to do next, in the user's terms. Keep the technical detail behind a "Details" disclosure and log the correlation ID.
- Put the error at the level it happened: a field error inline, a section error in that section, a page error as a page. Do not blow away a working screen for one failed widget.
- Always offer a way forward: Retry, go back, contact support with a prefilled reference.
- Auto-retry transient network failures a couple of times with backoff before telling the user anything.
- Never blame the user, never use a modal for a non-blocking error.

## Choosing the notification surface

| Surface | Use for | Dismissal |
| --- | --- | --- |
| **Inline** (next to the control) | Validation, per-item results | Resolves with the state |
| **Toast** (bottom or top corner) | Transient confirmations, undo | Auto after 4–7s |
| **Banner** (top of page or section) | Persistent conditions: expired card, degraded service | User dismiss or condition clears |
| **Modal** | Blocking decisions only | Explicit action |
| **Notification center** | History, async completions | Read state |

Pick the wrong surface and people tune all of them out.

## Toasts

Five rules: one at a time (queue the rest, cap at ~3 stacked); never cover the primary
action or the element being acted on; 4–7s for informational, and **errors do not
auto-dismiss**; at most one action per toast, and never bury a critical action there;
enter with a slide + fade, exit faster, and pause the timer on hover or focus.

## Success

Confirm where the action happened: an inline check on the saved field beats a toast that
steals attention and vanishes before it is read. Reserve celebration animations (500–800ms,
with overshoot) for genuine milestones; on every ordinary save they become noise.

## Progress and long tasks

Show real progress, never a fake crawl to 90%. For multi-step work, list the steps and
mark them off. Let long jobs run in the background with a status entry the user can leave
and return to, and notify on completion. Never block the whole UI on one export.

## Accessibility

- Live regions: `aria-live="polite"` for status and success, `role="alert"` (assertive) for errors. Do not make every toast assertive.
- Loading containers get `aria-busy="true"`; buttons keep their accessible name while showing a spinner ("Saving…"), and are disabled only for the duration of the request.
- Toasts need a keyboard-reachable close and enough time to act; WCAG requires a way to extend or dismiss timed content.
- Never communicate state with color alone: pair with icon and text.
- Announce result counts and step transitions; a screen reader user gets no benefit from a spinner.

## Checklist

- [ ] Sub-300ms actions show nothing; no full-page spinners.
- [ ] Skeletons match the final layout; the shell stays rendered.
- [ ] Reversible actions optimistic with visible revert and an Undo window.
- [ ] All four empty states distinguished, each with one real CTA.
- [ ] Errors say cause + fix, sit at the right level, and offer Retry.
- [ ] Toasts queue, do not cover the primary action, and errors persist.
- [ ] Live regions correct; state never color-only.

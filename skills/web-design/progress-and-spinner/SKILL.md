---
name: progress-and-spinner
description: Build or review loading and progress indicators. Use when adding a spinner, progress bar, determinate or indeterminate progress, a step progress indicator, an upload or export progress display, or a long-running background task status, and when work takes long enough that the UI must say something.
---

# Progress and Spinner

Assumes `feedback-design` for which pattern fits which wait, and `skeleton` for
content-shaped placeholders. This skill is the indicator itself.

## Choose by what you know

| You know | Show |
| --- | --- |
| Nothing, and it will be under 300ms | **Nothing.** A flash of a spinner reads as a glitch |
| Nothing, 300ms-3s | Spinner scoped to the thing loading |
| The percentage | Determinate progress bar with the number |
| The steps but not the timing | A named step list, marked off as each completes |
| Nothing, over ~10s | Staged status text plus a way to leave and come back |

**Never fake progress.** A bar that crawls to 90% and waits destroys trust the moment the
user notices, and they always notice on the second run.

## Spinners

- Scope it to the region that is actually loading. A full-page spinner over a blank screen is indistinguishable from a frozen app; keep the shell, nav, and headers rendered.
- One spinner per view. Three spinners reads as three things going wrong.
- Rotation ~1s per turn, linear, no pulsing or bouncing. Size to the context: 16px in a button, 24px in a panel.
- In a button, the spinner replaces the icon, not the label, and the width stays fixed (`button`).
- Delay showing it by ~300ms so fast responses never flash it, but once shown keep it for a minimum ~400ms so it does not strobe.

## Progress bars

- Show the number with the bar ("64%"), and add a rate or time remaining for anything over a few seconds ("12 MB of 40 MB - about 20 seconds left").
- Never go backwards. If the total changes, say so ("3 of 12 files - 4 more found") rather than resetting the bar.
- Start at a visible non-zero sliver so the bar reads as started; end at 100% and hold briefly before the success state, or the completion is never seen.
- Animate width changes over ~200-300ms so the bar moves smoothly rather than teleporting between polls.
- Indeterminate bars are for known-shape waits with unknown duration; do not use one where a spinner is clearer, and never run one for minutes.

## Long tasks

- Anything past ~10 seconds gets a **staged status**: "Compressing… Uploading… Finishing", so the user can see which stage is slow.
- Let long jobs run in the background with a persistent status entry the user can navigate away from and return to, and notify on completion (`toast`, `alert-banner`).
- Offer cancel wherever the work is cancelable, and say what cancelling leaves behind.
- On failure, keep the progress context: which step failed, what completed, and a retry that resumes rather than restarting where possible (`feedback-design`).
- For multi-item work, show per-item state, not one aggregate bar that hides three failures (`file-upload`).

## Step indicators

- Show position and total ("Step 2 of 4") with the steps named, current step emphasized, completed steps marked, and remaining steps visible.
- Completed steps are navigable backwards where the flow allows it; future steps are not clickable teasers.
- Never start a multi-step bar at zero when the first step is already behind the user - visible, incomplete progress is what pulls people through (`form-design`).

## Accessibility

- `role="progressbar"` with `aria-valuenow`, `aria-valuemin`, `aria-valuemax`, and a label; omit `aria-valuenow` for indeterminate.
- Announce start, completion, and failure politely - not every percentage tick. Throttle updates to something like every 10%.
- The loading container gets `aria-busy="true"` while it is working, and drops it when done.
- A spinner alone tells a screen-reader user nothing: pair it with text ("Loading results") even if that text is visually hidden.
- Respect `prefers-reduced-motion`: keep the indicator (it is information) but drop decorative pulsing and shimmer.

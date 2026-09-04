---
name: loading-indicators
description: Build or review loading and progress UI. Use when adding a spinner, skeleton placeholder, progress bar, determinate or indeterminate progress, staged status text, step indicators, or upload and export progress, and when content jumps, flashes, or the UI goes silent while work runs.
---

# Loading Indicators

Assumes `design-foundations` for tokens and motion. `feedback-design` decides whether the
user needs feedback at all; this skill picks the indicator and builds it. Skeleton and
spinner are the same decision made two ways, so they live together.

## Choose by what you know

| You know | Show |
| --- | --- |
| It will be under 300ms | **Nothing.** A flash of a spinner reads as a glitch |
| 300ms-3s, and the content's shape | **Skeleton** in the real layout |
| 300ms-3s, unknown shape or in-button | **Spinner**, scoped to the thing loading |
| The percentage | **Determinate bar** with the number |
| The steps but not the timing | A named step list, marked off as each completes |
| Nothing, and it will run past ~10s | Staged status text plus a way to leave and come back |

**Never fake progress.** A bar that crawls to 90% and waits destroys trust the moment the
user notices, and they always notice on the second run. Never mix skeletons and spinners in
one view either; it reads as two different things going wrong.

## Skeletons

A skeleton is a promise about the layout that is coming. Break it and it costs more than a
spinner would have.

- **Match the real layout**: same boxes, same rhythm, same number of rows as a typical result. A mismatch causes the visible jolt the skeleton existed to prevent.
- Reuse the real component with placeholder content where you can. Hand-drawn skeleton markup rots the first time the card changes.
- Mirror text as lines at the real line height with the **last line shorter**, and vary line widths slightly across rows so it reads as prose rather than as blocks.
- Keep images and avatars at their real aspect ratio and shape so nothing reflows.
- Show a plausible count - 3-6 cards, 5-10 rows - not one lonely placeholder and not thirty.
- **Cap the skeleton at roughly 2 seconds.** Past that, show whatever has arrived, or switch to real progress; a shimmer that keeps shimmering stops reading as loading and starts reading as stuck.
- **Animate it.** A slow shimmer or pulse, ~1.5-2s per cycle, left to right and mirrored under RTL; a static skeleton reads as broken layout. Keep it low-contrast, synchronize sibling placeholders, and drop to a gentle fade under `prefers-reduced-motion`.

## Spinners

- Scope it to the region that is loading. A full-page spinner over a blank screen is indistinguishable from a frozen app; keep the shell, nav, and headers rendered.
- One spinner per view, rotating ~1s per turn, linear, with no pulsing or bouncing. 16px in a button, 24px in a panel.
- In a button, the spinner replaces the icon rather than the label, and the width stays fixed (`button`).
- Delay showing it by ~300ms so fast responses never flash it, then keep it for a minimum ~400ms so it cannot strobe.

## Progress bars and long work

- Show the number with the bar ("64%"), and add a rate or time remaining past a few seconds ("12 MB of 40 MB - about 20 seconds left").
- Never go backwards. If the total changes, say so ("3 of 12 files - 4 more found") rather than resetting.
- Start at a visible non-zero sliver and hold 100% briefly before the success state, or completion is never seen. Animate width changes over ~200-300ms so the bar moves rather than teleports between polls.
- Indeterminate bars suit known-shape waits of unknown duration; never run one for minutes.
- Past ~10 seconds, switch to **staged status** ("Compressing… Uploading… Finishing") so the user can see which stage is slow, let the job run in the background with a status entry they can return to, and notify on completion (`toast`).
- Offer cancel wherever the work is cancelable, and say what cancelling leaves behind. On failure, keep the context: which step failed, what completed, and a retry that resumes rather than restarting.
- For multi-item work, show per-item state rather than one aggregate bar that hides three failures (`file-upload`).

## Step indicators

- Show position and total ("Step 2 of 4") with steps named, the current one emphasized, completed ones marked, and remaining ones visible.
- Completed steps are navigable backwards where the flow allows it; future steps are not clickable teasers.
- Never start a multi-step bar at zero when the first step is already behind the user - visible, incomplete progress is what pulls people through (`form-design`).

## Transition and accessibility

- Cross-fade from placeholder to content over ~150-200ms; a hard cut draws the eye to the shift. If the result is empty or fails, go straight to that state rather than leaving an ambiguous placeholder (`empty-state`).
- Skeleton shapes are `aria-hidden="true"` inside a container marked `aria-busy="true"`; a screen reader gets nothing useful from twelve empty boxes.
- `role="progressbar"` with `aria-valuenow`, `aria-valuemin`, `aria-valuemax`, and a label; omit `aria-valuenow` for indeterminate.
- Announce start, completion, and failure politely - not every percentage tick. Throttle to something like every 10%.
- A spinner alone tells a screen-reader user nothing: pair it with text ("Loading results"), visually hidden if need be.
- Keep the indicator under `prefers-reduced-motion` - it is information - and drop only the decorative shimmer and pulsing.

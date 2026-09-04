---
name: slider
description: Build or review a range slider. Use when adding a single or dual-handle slider for price, volume, opacity, zoom, or filtering, pairing a slider with a numeric input, choosing steps and units, or when a slider is hard to hit, imprecise, or expensive to update.
---

# Slider

Assumes `design-foundations` for tokens and focus. Use a slider only when the **relative**
position matters more than the exact number - volume, opacity, brightness, a fuzzy price
band. When precision matters, the number field is the control and the slider is optional.

## Pair it with a number

- **Always pair a slider with a readable, editable numeric value.** A drag cannot be precise, and a value that exists only as a handle position cannot be typed, copied, or verified.
- Put the value in a small input beside the track for input-like uses (price, dimensions), or in a readout above the handle for continuous ones (volume, opacity).
- Show the unit with the number, and the range bounds at the ends of the track so the scale is legible without dragging.
- Typing in the number moves the handle; dragging updates the number live. Clamp on blur, and explain the clamp ("Maximum 500").

## Track and handle

- **The filled portion of the track is the value.** An unfilled uniform track forces the user to estimate against invisible bounds.
- Expand the hit area to the full row height - 44px on touch - regardless of how thin the track looks. A 4px track is unhittable with a thumb; a transparent padded wrapper fixes it without changing the visual.
- Handles are at least 24×24 of real target, visually distinct from the track, and keep a hover and focus state.
- Clicking anywhere on the track jumps the handle to that position; dragging continues from there.
- Show tick marks only when steps are few and meaningful, and label the ones users navigate by.

## Steps and commit

- Snap to steps when round numbers matter (currency, minutes, percentages in fives) and keep continuous values continuous. State the step in the helper text if it is not obvious.
- **Expensive work commits on release**, not on every pointer move: filter queries, re-renders, network writes. Update the readout continuously so the drag still feels live (`search-and-filter-design`).
- Debounce keyboard stepping the same way; holding an arrow key should not fire fifty requests.
- Non-linear scales (price ranges spanning orders of magnitude) need a logarithmic track, or the useful range collapses into the first tenth of it.

## Dual handles

- Fill the band **between** the handles, and label both ends.
- Handles must not cross; on collision, either swap roles explicitly or stop at the neighbor, and keep a minimum gap where a zero-width range is meaningless.
- Each handle gets its own accessible name ("Minimum price", "Maximum price") and its own tab stop.
- When the histogram of underlying data exists (price distribution), render it behind the track - it turns a blind guess into an informed one.

## Accessibility

- Native `<input type="range">` where possible: keyboard, screen reader, and platform behavior come free. Custom handles need `role="slider"` with `aria-valuemin`, `aria-valuemax`, `aria-valuenow`, and an `aria-valuetext` that includes the unit ("$45 per month") - a bare number is meaningless spoken.
- Keyboard: arrows step, Page Up/Down jump by a larger increment, Home and End go to the bounds. All of it works without the pointer.
- Focus-visible ring on the handle at ≥3:1, and the track meets 3:1 against the surface so the filled portion is distinguishable.
- Announce the value on change, throttled, not on every intermediate pixel.
- Do not use a slider as the only way to reach a required value; provide the number input as the accessible path, and never disable it "to keep them in sync".

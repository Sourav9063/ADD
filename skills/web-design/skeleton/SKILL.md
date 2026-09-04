---
name: skeleton
description: Build or review skeleton loading placeholders. Use when adding shimmer or placeholder blocks for cards, lists, tables, or detail views while data loads, deciding between a skeleton and a spinner, or when content jumps, flashes, or shifts as it arrives.
---

# Skeleton

Assumes `feedback-design` for when a skeleton is the right pattern and
`progress-and-spinner` for the alternatives. A skeleton is a **promise about the layout
that is coming**. Break that promise and it costs more than a spinner would have.

## When to use one

- The wait is roughly 300ms to 3s **and** you know the shape of what will land.
- The region has structure worth previewing: cards, list rows, a table, a profile header.
- Not for unknown-shape content, not for a button, not for sub-300ms waits, and not for a wait long enough that the user needs real progress (`progress-and-spinner`).
- **Never mix skeletons and spinners in the same view.** It reads as two different things going wrong.

## Match the real layout

- Same boxes, same rhythm, same number of rows as the typical result. A skeleton that does not match the final layout causes a visible jolt when content lands - the exact thing it exists to prevent.
- Reuse the real component with placeholder content where you can, so the two cannot drift apart. Hand-drawn skeleton markup rots the first time the card changes.
- Mirror text as lines at the real line height, with the **last line shorter** so it reads as a paragraph rather than a block. Vary line widths slightly across rows.
- Keep images and avatars at their real aspect ratio and shape (`aspect-ratio`), so nothing reflows.
- Show a plausible count - 3-6 cards, 5-10 rows - not one lonely placeholder and not thirty.

## Motion

- A slow shimmer or pulse, ~1.5-2s per cycle, left-to-right (mirrored in RTL). **A static skeleton reads as broken layout**, not as loading.
- Keep the animation subtle: a low-contrast sweep, not a strobe. Gray at roughly one step above the surface, never near the text color.
- Synchronize the shimmer across sibling placeholders so the region pulses as one surface.
- Under `prefers-reduced-motion`, drop the sweep to a gentle opacity fade or a static tint (`motion-design`).

## Transition to content

- Cross-fade over ~150-200ms rather than swapping instantly; a hard cut draws the eye to the shift.
- Keep the structure rendered around the skeleton - nav, header, filters, tabs - and load only the region that changes.
- Do not stagger a long cascade of items into place; past a couple of hundred milliseconds it becomes a performance, not feedback.
- Hold the skeleton for a minimum ~300-400ms once shown, so a fast response does not flash it.
- If the result is empty or fails, go to the empty or error state directly (`empty-state`, `feedback-design`) - never leave the skeleton up as an ambiguous "maybe still loading".

## Accessibility

- The skeleton region is `aria-busy="true"` and its placeholder shapes are hidden from assistive tech (`aria-hidden="true"`); a screen reader gets nothing useful from twelve empty boxes.
- Announce the state once, politely - "Loading results" - and announce the outcome when it lands ("12 results").
- Never put real text inside a skeleton to be replaced later; it will be read out mid-swap.
- Skeleton fills must still meet non-text contrast against the surface where they convey structure, and must not be mistaken for disabled content.

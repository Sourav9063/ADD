---
name: icon-design
description: Choose, draw, or audit interface icons. Use when picking or mixing icon sets, sizing icons against text, matching stroke weight, drawing a custom glyph, deciding whether an icon needs a label, or when icons look inconsistent, blurry, or optically misaligned.
---

# Icon Design

Assumes `design-foundations` for tokens and the accessible-name rule. Icons are the detail
that most often gives away an interface assembled from parts.

## One set, one grid, one weight

One icon set, one grid (20 or 24px), one stroke width across the whole product. Mixing
filled and outline styles, or a 1.5px stroke beside a 2px one, is the fastest way to look
assembled from parts. Emoji are not an icon set.

- Adding one glyph a set lacks means drawing it **in that set's language** - same grid, same stroke, same corner radius, same terminals - not importing a second library for one icon.
- Filled and outline can coexist only as a deliberate state pair (outline for inactive, filled for selected in a bottom bar), applied consistently everywhere that state exists.
- Prefer inline SVG over an icon font: fonts fail with content blockers, are announced as text by some screen readers, and cannot carry two-tone glyphs.

## Size and optical correction

- **Keep the bounding box fixed** across the set, then correct **optically** inside it: circles and other organic shapes need roughly 5-8% more area than a square to read the same size, and a triangle centered by its box sits visibly left.
- Size icons to the text they sit beside by **cap height, not line box**, so the glyph and the letterforms share a visual weight.
- **Match stroke weight to the neighbouring text**: roughly 1.5px next to regular text, 2px next to semibold. A hairline icon beside bold text reads as a rendering bug.
- Scale stroke with size instead of scaling the SVG: a 16px icon at a 2px stroke rendered from a 24px original looks heavier than its neighbours.
- Snap to the pixel grid at the sizes you actually ship. A 24px glyph rendered at 22px blurs its verticals, and no amount of anti-aliasing recovers the crispness.
- Fix asymmetric glyphs in the SVG itself rather than compensating with a margin in one component, or every other consumer inherits the misalignment.

## Meaning

- Icons carry meaning only when they are **conventional**: magnifier, trash, gear, chevron. Anything else is decoration until proven otherwise, and a novel glyph for a novel concept is a memory test.
- **Pair with a label** wherever the space allows. Icon-only controls belong to toolbars and dense repeated rows, not to primary navigation or one-off actions.
- Do not overload one glyph with two meanings in the same product, and do not use two glyphs for one meaning.
- Status icons must be distinguishable in shape, not only in color, so they survive grayscale (`design-foundations`).
- Direction-sensitive glyphs (back, next, indent, trending) mirror under RTL; logos, clocks, and media transport controls do not (`internationalization-design`).

## Implementation

- Use `currentColor` so icons inherit state and theme rather than carrying their own hardcoded fill.
- Decorative icons get `aria-hidden="true"`; an icon-only control gets `aria-label` and a tooltip on focus as well as hover (`tooltip`).
- Strip fixed `width`, `height`, and `fill` from source SVGs and size with CSS, keeping `viewBox` so the glyph scales.
- Ship only the icons used. A full library imported for six glyphs is one of the easiest wins in a bundle audit (`frontend-performance`).
- Animate icon state (menu to close, chevron rotation) with a transform on one path, not by cross-fading two glyphs, which reads as a flicker.

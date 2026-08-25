---
name: responsive-design
description: Make a layout adapt across viewports, containers, and input methods. Use when choosing breakpoints, deciding what collapses or moves at small sizes, reaching for container queries, handling notches and safe areas, building full-bleed sections or horizontal scrollers, fixing content that clips, overflows, or gets cut off, or when a layout only works at the width it was designed at.
---

# Responsive Design

`design-foundations` owns the grid and the spacing scale. This skill owns what happens when
the space changes: where the layout breaks, what it becomes, and which edges it respects.

A responsive layout is not one design that shrinks. It is a structure that holds until it
genuinely stops fitting, then becomes a different structure on purpose.

## Breakpoints come from the content

Break where the layout actually stops fitting, not at 768px because a preset says so. That
point is where the sidebar squeezes body text below a readable measure, or the card grid
drops below a usable column width. Every product has its own.

**Collapse late.** A layout that keeps its expanded structure as long as it fits stays
stable and familiar, and premature collapsing throws away space the user paid for.

**Prefer container queries for components.** A card should adapt to the column it sits in,
not to the viewport. A viewport media query breaks the same card correctly in the main
column and wrongly in a narrow sidebar.

```css
.card-list { container-type: inline-size; }
@container (max-width: 400px) { .card { grid-template-columns: 1fr; } }
```

Reserve media queries for page-level structure: how many regions exist, and whether
navigation is persistent or behind a control.

## What adaptation looks like

Four moves cover almost everything. Name the one you are making:

- **Column drop.** A multi-column region loses columns as space narrows, keeping order.
- **Reflow.** Horizontally arranged elements stack vertically.
- **Off-canvas.** Secondary content moves behind a toggle: a sidebar becomes a drawer.
- **Priority-plus.** The most important items stay visible and the rest move into an overflow control. This is the right answer for toolbars and tab bars; see `tab-design`.

Reordering across a breakpoint is where reading order and tab order diverge. If CSS moves
content, fix the DOM instead.

## Edges: content bleeds, controls float

Two layers behave differently at the viewport edge.

- **Content layer.** Backgrounds, hero media, and scrollable lists extend edge to edge.
- **Control layer.** Text and interactive elements stay inside the layout margins and the safe areas, floating above the content.

A full-bleed section inside a constrained article is one grid, not a set of negative
margins:

```css
.article {
  display: grid;
  grid-template-columns: 1fr min(70ch, calc(100% - 48px)) 1fr;
}
.article > *           { grid-column: 2; }
.article > .full-bleed { grid-column: 1 / -1; }
```

Anything fixed or sticky pads itself out of the notch and gesture zones with
`env(safe-area-inset-*)`. Full-width buttons in a content layout stay inside the layout
margins with a visible radius; a button glued to three edges reads as system chrome and
clips against curved corners. Edge-to-edge is correct only when it is deliberately platform
chrome.

## Hidden content needs an affordance

Hiding complexity is good. Hiding it with no cue is a trap.

- **Peeking items.** In a horizontal scroller, size items so the next one peeks 16 to 32px past the container edge. A row of cards ending exactly at the edge looks complete and nobody scrolls it. Pair `scroll-snap-type` with `scroll-padding-inline` matching the container padding, so snapped items land on the content edge rather than under it.
- **Disclosure controls.** Label them with what is hidden: "Show 12 more results", not "More".
- **Truncation cues.** Clamped text shows an ellipsis and a way to expand; see `typography-design`.

## Never park a critical action where it clips

The bottom edge of a resizable pane, below the fold of a fixed-height modal, and behind an
expanding software keyboard are all places a primary action disappears. Keep it in normal
flow or in stable chrome with safe-area padding. When a modal's body scrolls, its action
row does not.

## Fluid type and media

- Scale type between breakpoints with `clamp()` rather than stepping it at each one, and keep the clamped range inside the scale from `typography-design`. Never set a viewport-relative size with no minimum; it becomes unreadable on small screens and fails zoom.
- Serve `srcset` and `sizes` so a phone does not download a desktop hero. Where the subject needs a different crop rather than a different size, that is art direction: use `<picture>`.
- Give every image explicit `width` and `height` or an `aspect-ratio` so reflow does not shift the page as it loads; see `frontend-performance`.

## Adapt to capability, not to device

Detect what the input can do, never what the user agent claims to be.

- `@media (hover: hover)` gates hover-only affordances. Anything reachable only by hover is unreachable on touch.
- `@media (pointer: coarse)` enlarges targets: 44x44px minimum on touch, 24x24px on fine pointers, with 8px of clearance between adjacent targets.
- Borderless controls need more clearance than bordered ones, because nothing else marks where one target ends and the next begins. Roughly 12px between adjacent bordered controls, 24px around text and icon-only ones, unless the project has an established density that already works.

## Plan for growth

Content grows in the direction the design did not budget for. Put no fixed width or height
on a text container: use `max-width` and let rows wrap, size buttons from their label with
`padding-inline`, and use `min-height` where a floor is genuinely needed. A one-word button
label is the riskiest string on the screen, because short strings grow proportionally more
when translated. See `internationalization-design`.

## Testing order

Test the smallest and largest supported sizes first; those break first. Then sweep the
sizes between, resizing continuously rather than jumping between preset widths, because
breakage lives between the presets. Finish with 200% zoom and a 320px viewport with no
horizontal scrolling, which is the WCAG reflow requirement rather than a nice-to-have.
Real devices for anything involving gestures, keyboards, or safe areas; a resized desktop
browser does not have a notch.

## Checklist

- [ ] Breakpoints justified by where the content stops fitting, not by device presets.
- [ ] Components adapt with container queries; media queries reserved for page structure.
- [ ] The adaptation at each break is a named move, not a set of one-off overrides.
- [ ] Fixed and sticky elements pad for `env(safe-area-inset-*)`.
- [ ] Off-screen and collapsed content has a visible affordance.
- [ ] No critical action sits where a resize, scroll, or keyboard can clip it.
- [ ] Hover gated behind `hover: hover`; targets enlarged for coarse pointers.
- [ ] No fixed sizes on text containers; buttons sized by their label.
- [ ] Holds at 320px and at 200% zoom with no horizontal scrolling.

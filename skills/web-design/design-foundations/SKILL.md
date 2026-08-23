---
name: design-foundations
description: Apply shared visual, motion, and accessibility baselines when building or reviewing any UI surface. Use when picking spacing, radii, shadows, colors, animation durations, or focus styles, when a UI "looks cheap" or "feels janky", or alongside form-design, tab-design, filter-design, data-table-design, overlay-design, and feedback-design.
---

# Design Foundations

Baseline every other web-design skill assumes. Read this first; the section skills do
not repeat these rules.

## Tokens, not values

Never write a raw hex, pixel, or duration into a component. Define tokens once and
reference them, so a theme change is one edit instead of a grep.

Use three layers: **primitives** (the raw scale: `blue-500`, `space-4`), **semantic**
aliases (`accent`, `danger`, `surface-raised`), and **component** tokens where a part needs
its own hook. Each layer references the one above it, and components consume the semantic
layer only — that is what makes a rebrand or a theme one edit. Any stray value snaps to the
scale: `13px` becomes `12px`, `17px` becomes `16px`.

- **Space**: one scale, 4px base: `4 8 12 16 24 32 48 64`. No `13px`, no `7px`.
- **Radius**: `sm 6 / md 10 / lg 16 / full`. Nested corners: inner radius = outer radius − padding. Scale radius with the element: tooltips and chips take the smallest step, inputs and buttons the next, cards above that, modals and panels the largest. A modal at the same radius as a chip looks unresolved.
- **Type**: 5–7 steps max, each with its own line height. Body 15–16px, line height 1.5. Generate the steps from one ratio rather than picking sizes by eye — 1.2 for dense product UI, 1.25–1.333 for general interfaces, up to 1.618 for editorial and marketing display. Related sizes are what make a screen look composed instead of assembled; round the results to whole pixels.
- **Color**: semantic names (`surface`, `surface-raised`, `border`, `text`, `text-muted`, `accent`, `danger`), not `gray-400`. Components consume semantic tokens only.
- **Elevation**: 4 levels max. Shadows must use one consistent light source, with larger blur and lower opacity as elevation rises. Stack two or three shadows rather than one heavy blur — a tight contact shadow (~2px) anchors the element to the surface, a mid spread (~12px) gives it body, and a wide ambient one (~32px) sets it in the room. One flat drop shadow on everything is the default that reads as unfinished.
- **Duration / easing**: see the motion scale below.

## Hierarchy and layout

- Group with **proximity and spacing before borders**. If a divider is only there because spacing is wrong, fix the spacing. The eye groups by nearness, alignment, and shared enclosure before it reads anything, so space between groups must clearly exceed space within them — roughly 12px between related fields against 40px between sections, not 16 against 20.
- One primary action per view. Everything else is secondary or tertiary; competing primaries mean no hierarchy.
- Establish a grid — 12 columns desktop, 6 tablet, 4 on large phones, 1 stacked — and break it deliberately, not accidentally. Split on clean column ratios (`4:8` sidebar, `6:6` even, `3:9` narrow nav) rather than arbitrary widths, and proportion the major regions with the same ratio the type scale uses; a 62/38 split reads as composed where 55/45 reads as an accident. Gutter width carries tone: tight gutters feel dense and technical, wide ones editorial.
- Beyond proximity, the eye groups by **similarity** (things that look alike are read as one set, so vary treatment only when the meaning varies), **continuity** (items on a shared axis scan as a sequence, which is why ragged alignment slows reading), **common region** (a shared background or border binds items more strongly than spacing, which is why an unnecessary card fuses unrelated content), and **figure/ground** (one element must sit forward — dimming what is behind a dialog is what makes it read as deliberate rather than floating).
- Contrast within a screen comes from **size, weight, and color**: pick two, not all three, per level.
- Isolate the option you want chosen (different treatment, not just a badge); uniform cards convert worse than one visually distinct card. Isolation only works against a uniform baseline and only if one thing is emphasized — highlight two and they cancel. Combine scale and elevation with the color shift so the emphasis survives grayscale.
- Order matters: users recall the first and last items in a list far better than the middle. Put the important entries at the ends.

## Icons

One icon set, one grid (20 or 24px), one stroke width across the whole product. Mixing
filled and outline styles, or a 1.5px stroke beside a 2px one, is the fastest way to look
assembled from parts.

- Keep the bounding box fixed across the set, then correct **optically** inside it: circles and other organic shapes need roughly 5–8% more area than a square to read the same size, and a triangle centered by its box reads off-center. Size icons to the text they sit beside by cap height, not line box.
- Scale stroke with size instead of scaling the SVG: a 16px icon at a 2px stroke rendered from a 24px original looks heavier than its neighbors.
- Icons carry meaning only when they are conventional. Anything ambiguous gets a label; an icon-only control gets `aria-label` and a tooltip on focus as well as hover.
- Use `currentColor` so icons inherit state and theme, and give decorative icons `aria-hidden="true"`.

## Gradients

Gradients are depth, not decoration. Two stops from the same hue family, a small
lightness shift, and a direction consistent with the light source of your shadows.

- **Keep hue travel under ~60°.** Neighboring hues (teal → cyan) blend clean; opposite ones (orange → blue) pass through a muddy gray dead zone. Interpolate through `oklch`, or add midpoints, when you need a wider span.
- **Move lightness in one direction only.** Dark → light → dark reads as banding, not as form.
- Prefer a soft radial glow behind content over a full-bleed linear wash; the gradient is ambience, not the surface itself.
- Text on a gradient must pass contrast at its **darkest and lightest** point, not on average, and body text never sits on the mid-transition where the ratio is least predictable. Add a scrim if it does not pass.
- Large-area gradients band on 8-bit displays: overlay 2–3% noise or keep the range short.
- One gradient per surface. Gradient text, gradient border, and gradient background together read as a template, not a product.

## Motion scale

| Intent | Duration | Easing |
| --- | --- | --- |
| Tap / press feedback | < 100ms | `ease-out` |
| Entrance (menus, sheets, cards) | 200–300ms | `cubic-bezier(0.16, 1, 0.3, 1)` |
| Exit | ~150ms (≈40% faster than entrance) | `ease-in` |
| Attention (toast, celebration) | 500–800ms | spring / slight overshoot |
| List stagger | 50ms per item | - |

Rules: exits are always faster than entrances; symmetric timing feels sluggish. Never
`linear` on an entrance. Reserve springs and bounce for moments that genuinely need
attention. Animate `transform` and `opacity`; animating layout properties drops frames.

Respect `prefers-reduced-motion: reduce`: replace movement with a short opacity fade,
never remove the state change itself.

## Accessibility baseline

- **Contrast**: 4.5:1 body text, 3:1 large text (≥24px or ≥19px bold), 3:1 for UI borders, icons, and focus rings. Check the disabled and placeholder colors too; those are where it usually fails.
- **Never signal with color alone.** ~1 in 12 people cannot rely on a red border. Pair color with an icon and text.
- **Focus**: never `outline: none` without a replacement. Use `:focus-visible` with a 2px ring at 2px offset, visible on light and dark surfaces. The focus ring and the selected/active style must be different colors, or keyboard users cannot tell where they are versus what is chosen.
- **Focus order follows the DOM.** If CSS reorders content, tab order jumps. Fix the DOM, not with `tabindex` above 0.
- **Skip link** first in the DOM, visible on focus.
- **Hit targets**: 44×44px minimum on touch, 24×24px minimum on pointer, with 8px between adjacent targets.
- **Hover is not an interaction**, it is an enhancement. Anything reachable only by hover is unreachable on touch and by keyboard. Design the touch path first. Gate hover effects with `@media (hover: hover)` and enlarge controls for coarse pointers with `@media (pointer: coarse)`; detect capability, not device names.
- Every icon-only control needs an accessible name (`aria-label`); decorative images get `alt=""`.
- Zoom to 200% and reflow at 320px wide without horizontal scrolling.

## Dark mode

Dark mode is not black mode. Invert intent, not values, and swap a whole token set rather
than flipping colors at render time.

Elevate with progressively lighter surfaces rather than darker shadows — shadows barely
read on a dark base, so lightness carries the depth that shadow carries in light mode. Drop
pure `#000` and `#fff`: a near-black base around `#121212` leaves room to elevate, and
off-white text avoids the glare that pure white causes on a dark field. Build text
hierarchy from opacity tiers of one foreground color (high / medium / disabled) instead of
introducing new grays, and desaturate accents roughly 20% so they do not vibrate.
Re-check contrast in both themes; passing in one proves nothing about the other.

## Review checklist

- [ ] Every value in the diff traces to a token.
- [ ] Text and non-text contrast pass in both themes.
- [ ] Tab through the whole surface: visible ring, sane order, no traps, nothing hover-only.
- [ ] `prefers-reduced-motion` handled; exits faster than entrances.
- [ ] One primary action; the layout still reads at 320px and at 200% zoom.

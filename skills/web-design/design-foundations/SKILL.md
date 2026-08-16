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

- **Space**: one scale, 4px base — `4 8 12 16 24 32 48 64`. No `13px`, no `7px`.
- **Radius**: `sm 6 / md 10 / lg 16 / full`. Nested corners: inner radius = outer radius − padding.
- **Type**: 5–7 steps max, each with its own line height. Body 15–16px, line height 1.5.
- **Color**: semantic names (`surface`, `surface-raised`, `border`, `text`, `text-muted`, `accent`, `danger`), not `gray-400`. Components consume semantic tokens only.
- **Elevation**: 4 levels max. Shadows encode depth, so they must be consistent — one light source, larger blur and lower opacity as elevation rises. Two stacked shadows (tight + soft) read better than one heavy one.
- **Duration / easing**: see the motion scale below.

## Hierarchy and layout

- Group with **proximity and spacing before borders**. If a divider is only there because spacing is wrong, fix the spacing.
- One primary action per view. Everything else is secondary or tertiary — competing primaries mean no hierarchy.
- Establish a grid (12-column desktop, 4-column mobile) and break it deliberately, not accidentally.
- Contrast within a screen comes from **size, weight, and color** — pick two, not all three, per level.
- Isolate the option you want chosen (different treatment, not just a badge); uniform cards convert worse than one visually distinct card.
- Order matters: users recall the first and last items in a list far better than the middle. Put the important entries at the ends.

## Motion scale

| Intent | Duration | Easing |
| --- | --- | --- |
| Tap / press feedback | < 100ms | `ease-out` |
| Entrance (menus, sheets, cards) | 200–300ms | `cubic-bezier(0.16, 1, 0.3, 1)` |
| Exit | ~150ms (≈40% faster than entrance) | `ease-in` |
| Attention (toast, celebration) | 500–800ms | spring / slight overshoot |
| List stagger | 50ms per item | — |

Rules: exits are always faster than entrances — symmetric timing feels sluggish. Never
`linear` on an entrance. Reserve springs and bounce for moments that genuinely need
attention. Animate `transform` and `opacity`; animating layout properties drops frames.

Respect `prefers-reduced-motion: reduce` — replace movement with a short opacity fade,
never remove the state change itself.

## Accessibility baseline

- **Contrast**: 4.5:1 body text, 3:1 large text (≥24px or ≥19px bold), 3:1 for UI borders, icons, and focus rings. Check the disabled and placeholder colors too; those are where it usually fails.
- **Never signal with color alone.** ~1 in 12 people cannot rely on a red border. Pair color with an icon and text.
- **Focus**: never `outline: none` without a replacement. Use `:focus-visible` with a 2px ring at 2px offset, visible on light and dark surfaces. The focus ring and the selected/active style must be different colors, or keyboard users cannot tell where they are versus what is chosen.
- **Focus order follows the DOM.** If CSS reorders content, tab order jumps. Fix the DOM, not with `tabindex` above 0.
- **Skip link** first in the DOM, visible on focus.
- **Hit targets**: 44×44px minimum on touch, 24×24px minimum on pointer, with 8px between adjacent targets.
- **Hover is not an interaction**, it is an enhancement. Anything reachable only by hover is unreachable on touch and by keyboard. Design the touch path first.
- Every icon-only control needs an accessible name (`aria-label`); decorative images get `alt=""`.
- Zoom to 200% and reflow at 320px wide without horizontal scrolling.

## Dark mode

Invert intent, not values. Elevate with lighter surfaces rather than darker shadows, drop
pure `#000` and `#fff` for near-black/near-white, and desaturate accents so they do not
vibrate. Re-check contrast in both themes — passing in one proves nothing about the other.

## Review checklist

- [ ] Every value in the diff traces to a token.
- [ ] Text and non-text contrast pass in both themes.
- [ ] Tab through the whole surface: visible ring, sane order, no traps, nothing hover-only.
- [ ] `prefers-reduced-motion` handled; exits faster than entrances.
- [ ] One primary action; the layout still reads at 320px and at 200% zoom.

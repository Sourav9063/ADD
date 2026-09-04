---
name: design-foundations
description: Apply the shared token, layout, motion, and accessibility baseline for UI work. Use when picking spacing, radii, elevation, type steps, animation durations, z-index, focus styles, or hit targets, when a UI "looks cheap" or "feels janky", and alongside ui-composition or any component or surface skill.
---

# Design Foundations

The baseline every other web-design skill assumes, kept small because it loads with all of
them. Craft that only matters while styling lives in `visual-direction`; ramps, gradients,
and themes live in `color-systems`; icons in `icon-design`.

## Tokens, not values

Never write a raw hex, pixel, or duration into a component. Define tokens once and
reference them, so a theme change is one edit instead of a grep.

Use three layers: **primitives** (the raw scale: `blue-500`, `space-4`), **semantic**
aliases (`accent`, `danger`, `surface-raised`), and **component** tokens where a part needs
its own hook. Each layer references the one above it, and components consume the semantic
layer only - that is what makes a rebrand or a theme one edit. Any stray value snaps to the
scale: `13px` becomes `12px`, `17px` becomes `16px`.

- **Space**: one scale, 4px base: `4 8 12 16 24 32 48 64`. No `13px`, no `7px`.
- **Radius**: `sm 6 / md 10 / lg 16 / full`. Scale radius with the element: tooltips and chips take the smallest step, inputs and buttons the next, cards above that, modals and panels the largest. Nest concentrically, outer radius = inner radius + the padding between them; a modal at the same radius as a chip looks unresolved.
- **Type**: 5-7 steps max, each with its own line height. Body 15-16px, line height 1.5. Generate the steps from one ratio rather than picking sizes by eye - 1.2 for dense product UI, 1.25-1.333 for general interfaces, up to 1.618 for editorial and marketing display. Round to whole pixels. `typography-design` covers what happens to text after the scale exists.
- **Color**: semantic names (`surface`, `surface-raised`, `border`, `text`, `text-muted`, `accent`, `danger`), not `gray-400`. Components consume semantic tokens only. `color-systems` builds the ramps underneath them.
- **Elevation**: 4 levels max, one consistent light source, larger blur and lower opacity as elevation rises. Stack two or three shadows rather than one heavy blur - a tight contact shadow (~2px) anchors the element, a mid spread (~12px) gives it body, a wide ambient one (~32px) sets it in the room. One flat drop shadow on everything reads as unfinished.
- **Z-index**: one scale, `dropdown 1000 / sticky 1100 / drawer 1200 / modal 1300 / popover 1400 / toast 1500`. Never an ad-hoc `9999`; an escalating number is a symptom of a stacking context upstream, not a fix. `z-index` applies only to positioned elements, and a parent's `transform`, `filter`, or `opacity` traps its children no matter how high their value. Prefer the top layer (native `<dialog>`, the popover API), which sidesteps the scale entirely.
- **Duration / easing**: see the motion scale below.

## Hierarchy and layout

- Group with **proximity and spacing before borders**. If a divider is only there because spacing is wrong, fix the spacing. Space between groups must clearly exceed space within them - roughly 12px between related fields against 40px between sections, not 16 against 20.
- **One primary action per view.** Everything else is secondary or tertiary; competing primaries mean no hierarchy. `button` ranks and places them.
- Establish a grid - 12 columns desktop, 6 tablet, 4 on large phones, 1 stacked - and break it deliberately. Split on clean column ratios (`4:8` sidebar, `6:6` even, `3:9` narrow nav) rather than arbitrary widths. `responsive-design` covers where it adapts.
- Beyond proximity, the eye groups by **similarity** (vary treatment only when meaning varies), **continuity** (items on a shared axis scan as a sequence), **common region** (a shared background binds more strongly than spacing, which is why an unnecessary card fuses unrelated content), and **figure/ground** (one element sits forward; dimming behind a dialog is what makes it read as deliberate).
- Contrast within a screen comes from **size, weight, and color**: pick two, not all three, per level.
- **A container's own padding is at most the gap to its neighbours.** Content cards want at least 24px of internal padding; a compact stat tile is a different component, not the same one shrunk.
- **Weight section spacing by role.** Uniform section padding down a page makes everything read as equally important, which is to say not important at all.
- **Keep controls visually distinct from content.** Every interactive element needs a background, a border, an underline, or a consistent control zone; a badge shaped like the buttons around it collects dead clicks.
- Users recall the first and last items in a list far better than the middle. Put the important entries at the ends.

## Motion scale

| Intent | Duration | Easing |
| --- | --- | --- |
| Tap / press feedback | < 100ms | `ease-out` |
| Entrance (menus, sheets, cards) | 200-300ms | `cubic-bezier(0.16, 1, 0.3, 1)` |
| Exit | ~150ms (≈40% faster than entrance) | `ease-in` |
| Attention (toast, celebration) | 500-800ms | spring / slight overshoot |
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
- **Hover is not an interaction**, it is an enhancement. Anything reachable only by hover is unreachable on touch and by keyboard. Design the touch path first. Gate hover effects with `@media (hover: hover)` and enlarge controls for coarse pointers with `@media (pointer: coarse)`; detect capability, not device names. Ungated, a touch device fakes hover on the first tap and the style sticks until the user taps elsewhere.
- Every icon-only control needs an accessible name (`aria-label`); decorative images get `alt=""`.
- Zoom to 200% and reflow at 320px wide without horizontal scrolling.

Before handing off any surface, tab through it end to end and confirm every value in the
diff traces to a token. The keyboard pass is what catches invisible focus, jumped order,
traps, and hover-only controls, and it takes under a minute.

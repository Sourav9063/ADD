---
name: color-systems
description: Build, extend, or audit a product color palette. Use when generating a color ramp or scale, picking brand and accent hues, adding status colors, choosing between hex, hsl, and oklch, theming light and dark, handling Display P3 and wide gamut, setting gradient interpolation, supporting increased contrast, or when a palette has drifted into dozens of near-duplicate values.
---

# Color Systems

`design-foundations` owns the three token tiers, the semantic names components consume, and
the contrast floors. This skill owns what sits underneath: how ramps are built, what
notation they use, and how they survive a theme, a display, and an audit.

Most color bugs are system bugs: a value picked in isolation, a token borrowed because it
looked right, a pair nobody measured. Color has an exact answer, so compute it rather than
estimate it.

## What a system needs

One **neutral** ramp carrying 80–90% of the interface (backgrounds, borders, body text), one
**accent** ramp (brand hue, interactive and selected states), and only the **status** ramps
the product actually renders. A `warning` ramp nothing imports is maintenance for zero
pixels. A second accent earns its place only when two things must be distinguishable at a
glance, and it must never sit adjacent to the first.

## Every step has a job

A ramp is not a gradient to pick from by eye. Generate the steps these roles call for, skip
the rest:

| Role | Tailwind | Radix |
| --- | --- | --- |
| Page background | 50 | 1 |
| Subtle background | 50 | 2 |
| Component background | 100 | 3 |
| Component hover | 200 | 4 |
| Component active / selected | 200 | 5 |
| Subtle border | 200 | 6 |
| Border, separator | 300 | 7 |
| Strong border, focus ring | 400 | 8 |
| Solid fill | 500 | 9 |
| Solid fill hover | 600 | 10 |
| Low-contrast text | 700 | 11 |
| High-contrast text | 900 | 12 |

The conventions differ in kind. Radix numbers **by role**, so step 9 is the solid fill in
every ramp and appearance and component CSS never changes across themes. Tailwind numbers
**by lightness**, so the mapping holds in light mode and inverts in dark. Match the project;
for a new system prefer role-defined, because a role survives a theme change that a
lightness label does not.

## A well-formed ramp

Four properties, judged perceptually rather than by whatever the notation calls lightness:
steps move evenly in **perceived** lightness; hue stays constant end to end; vividness peaks
mid-ramp and falls off at both ends; steps sit denser at the light end, or `50` and `100`
will not read as two surfaces. Both ends stop short of pure black and white, which carry no
hue. Generate with a color library, not by eye.

**Neutrals.** Pure gray is a good default that never needs revisiting when the brand changes.
Tinting a few percent toward the accent is a stylistic option, not a correction: warm reads
approachable and editorial, cool reads technical and precise. Hold the choice across the
whole ramp, since a warm gray border on a cool gray background is visible even when neither
color is nameable alone. Neutrals carry the most roles, so never generate fewer neutral
steps than accent steps.

**Status hues must not collide with the accent.** If the brand is red, the danger ramp cannot
also be red or the destructive and primary buttons are the same button. Move it and check
side by side. Status ramps usually need four roles, not twelve.

## Notation

Match what the project uses. A consistent hex system beats hex with `oklch()` scattered
through it, and one converted value in a hex codebase is noise. Bulk conversion is a
migration with its own task, not a side effect of touching a file.

For a genuinely new system `oklch()` is the best default: even lightness steps stay even and
a fixed hue stays fixed. `hsl()` looks like a designer's controls, but its lightness is not
perceptual and its hue drifts, which is why HSL-built ramps bunch at one end.

Fix a failing contrast pair by **changing lightness**, the channel contrast responds to.
Changing hue moves the color's meaning and usually not its ratio.

## Gamut

Every sRGB color exists in Display P3; the reverse is not true. A color more vivid than the
display can render gets clipped, and clipping flattens neighbouring steps into one rendered
color, so the top of a ramp loses its distinctions. Maximum vividness varies by hue, so a
clipping ramp clips at some steps and not others.

Generate against sRGB unless the product is display-restricted, then layer P3 on. Order
matters: sRGB first so every display gets something, P3 second so it overrides only where it
renders. A P3 color with no fallback does not degrade, it fails.

```css
.accent { background: #3b82f6; }
@media (color-gamut: p3) { .accent { background: oklch(0.62 0.24 259); } }
```

`color-mix()`, relative color syntax, and `light-dark()` all compute at render time. Useful
for states, awkward for tokens: the result cannot be inspected in a design tool or
contrast-checked statically, and a token defined by three chained derivations is unreadable.
Keep them out of the primitive tier and measure the rendered result.

## Gradients

Gradients are depth, not decoration: two stops from the same hue family, a small lightness
shift, and a direction consistent with the light source of the product's shadows.

- **Keep hue travel under ~60°.** Neighbouring hues (teal to cyan) blend clean; opposite ones (orange to blue) pass through a muddy gray dead zone.
- **Move lightness in one direction only.** Dark to light to dark reads as banding, not as form.
- Prefer a soft radial glow behind content over a full-bleed linear wash; the gradient is ambience, not the surface itself.
- One gradient per surface. Gradient text, gradient border, and gradient background together read as a template, not a product.
- Text on a gradient must pass contrast at its **darkest and lightest** point, never on average, and body text never sits on the mid-transition. Add a scrim if it does not pass.

The interpolation space is a look, not a correctness setting. **`in oklab`** is the best
default: even brightness, no hue surprises. **`in oklch`** is polar, interpolating the hue
angle and arcing through every hue between the stops, so reach for it when a two-hue
gradient goes gray in the middle and control the route with `shorter hue` or `longer hue`.
**The sRGB default** darkens and mutes the midpoint, which is what most interfaces already
have because it is what you get without asking.

The gray dead zone is a rectangular-space problem: two hues opposite on the wheel sit either
side of the neutral axis, and a straight line between them passes near gray. Switch to a
polar space or add a third stop. Large low-contrast gradients band on 8-bit displays: widen
the contrast, shrink the area, or overlay subtle noise. Text on a gradient is measured at
its worst region, never its average.

## Meaning and appearance variants

**One color, one meaning.** Treat anything within 15 degrees of hue as the same color. It
runs both ways: if the accent means interactive, that hue on static text invites a click
that does nothing, and an interactive element rendered neutral misleads just as badly. Use a
semantic token only in its named role; a separator borrowed as a text color works until
borders get lighter, and then the text goes with them. Where a color is load-bearing in
finance, status, or alerts, check `internationalization-design` before hardcoding it.

**Dark mode is not black mode.** Invert intent, not values, and swap a whole token set
rather than flipping colors at render time. Elevate with progressively lighter surfaces
rather than darker shadows, since shadow barely reads on a dark base and lightness has to
carry the depth. Drop pure `#000` and `#fff`: a near-black base around `#121212` leaves room
to elevate, and off-white text avoids the glare pure white causes on a dark field. Build
text hierarchy from opacity tiers of one foreground color (high / medium / disabled) instead
of introducing new grays, and desaturate accents roughly 20% so they do not vibrate.
Re-check contrast in both themes; passing in one proves nothing about the other.

Every custom color needs light, dark, and increased-contrast variants:

```css
:root { --color-accent-solid: #3b82f6; }
@media (prefers-color-scheme: dark) { :root { --color-accent-solid: #60a5fa; } }
@media (prefers-contrast: more)     { :root { --color-accent-solid: #1d4ed8; } }
```

Widen the foreground/background gap by at least 15 points of perceived lightness for
increased contrast, then remeasure; widening without remeasuring is not fixing it. Pick one
switching mechanism, `prefers-color-scheme` or a class, and use it throughout. Half the
tokens on each is how a theme ends up half-applied.

## Auditing an existing palette

Most codebases hold several times more colors than the design has decisions.

1. **Collect every literal**: hex, `rgb(`, `hsl(`, `oklch(`, utility prefixes, SVG `fill` and `stroke`, chart configs, email templates. Color hides outside stylesheets.
2. **Sort by perceived lightness within each hue family.** Duplicates surface as near-identical neighbours.
3. **Collapse near-duplicates.** Two colors closer than about one ramp step are one color that drifted. Keep the most-used, retire the rest, never average them.
4. **Assign each survivor a role.** A color matching no role is a missing token or a mistake. Say which.
5. **Count what is left.** More than one ramp per role means the palette outgrew its structure, not that the product needs more color.

Consolidating changes rendered output on screens nobody asked you to touch, so report the
inventory as a proposal and wait for a decision.

---
name: color-systems
description: Build, extend, or audit a product color palette. Use when generating a color ramp or scale, picking brand and accent hues, adding status colors, choosing between hex, hsl, and oklch, theming light and dark, handling Display P3 and wide gamut, setting gradient interpolation, supporting increased contrast, or when a palette has drifted into dozens of near-duplicate values.
---

# Color Systems

`design-foundations` owns the three token tiers, the semantic names components consume, and
the contrast floors. This skill owns what sits underneath: how the ramps are built, what
notation they are written in, and how they survive a theme, a display, and an audit.

Most color bugs are system bugs: a value picked in isolation, a token borrowed because it
looked right, a pair nobody measured. Color is one of the few interface concerns with an
exact answer, so compute it rather than estimate it.

## What a system needs

| Ramp | How many | Carries |
| --- | --- | --- |
| Neutral | 1 | 80 to 90% of the interface: backgrounds, borders, body text |
| Accent | 1 | The brand hue: interactive, selected, and primary states |
| Status | 0 to 4 | `danger`, `warning`, `success`, `info`, and only the ones the product renders |

A `warning` ramp nothing imports is maintenance for zero pixels. A second accent hue earns
its place only when two things must be distinguishable at a glance, and it must never sit
adjacent to the first.

## Every step has a job

A ramp is not a gradient to pick from by eye. Generate the steps the roles below call for
and skip the rest:

| Role | Tailwind | Radix |
| --- | --- | --- |
| Page background | 50 | 1 |
| Subtle background | 50 | 2 |
| Component background | 100 | 3 |
| Component hover | 200 | 4 |
| Component active or selected | 200 | 5 |
| Subtle border | 200 | 6 |
| Border, separator | 300 | 7 |
| Strong border, focus ring | 400 | 8 |
| Solid fill | 500 | 9 |
| Solid fill hover | 600 | 10 |
| Low-contrast text | 700 | 11 |
| High-contrast text | 900 | 12 |

The two conventions differ in kind. Radix numbers steps **by role**, so step 9 is the solid
fill in every ramp and every appearance, and component CSS never changes across themes.
Tailwind numbers them **by lightness**, so the mapping above holds in light mode and
inverts in dark. Match whichever the project uses; for a new system prefer the role-defined
model, because a role survives a theme change that a lightness label does not.

## A well-formed ramp

Four properties, all judged perceptually rather than by whatever the notation calls
lightness:

- Steps move evenly in **perceived** lightness.
- Hue stays constant end to end.
- Vividness peaks mid-ramp and falls off at both ends.
- Steps sit denser at the light end than the dark end, or `50` and `100` will not read as two surfaces.

Both ends stop short of pure black and white, which carry no hue at all. Generate this with
a color library, not by eye.

**Neutrals.** A pure gray ramp is a good default that never needs revisiting when the brand
color changes. Tinting it a few percent toward the accent is a stylistic option, not a
correction: warm neutrals read approachable and editorial, cool ones technical and precise.
Whichever you pick, hold it across the whole ramp; a warm gray border on a cool gray
background is visible even when neither color is nameable alone. Neutrals carry the most
roles, so never generate fewer neutral steps than accent steps.

**Status hues must not collide with the accent.** If the brand is red, the danger ramp
cannot also be red, or the destructive and primary buttons are the same button. Move it and
check the two side by side. Status ramps usually need four roles, not twelve.

## Notation

Match what the project already uses. A consistent hex system beats hex with `oklch()`
scattered through it, and a single converted value in a hex codebase is noise, not an
improvement. Bulk conversion is a migration with its own task, not a side effect of
touching one file.

For a genuinely new system, `oklch()` is the best default: even lightness steps stay even
and a fixed hue stays fixed. `hsl()` looks like a designer's controls but its lightness is
not perceptual and its hue drifts, which is why ramps built by varying HSL lightness bunch
at one end.

Fix a failing contrast pair by **changing lightness**, the channel contrast actually
responds to. Changing hue moves the color's meaning and usually not its ratio.

## Gamut

Every sRGB color exists in Display P3; the reverse is not true. A color more vivid than the
display can render gets clipped, and clipping is not graceful: it flattens neighbouring
steps into one rendered color, so the top of a ramp loses its distinctions. Maximum
vividness varies by hue, so a clipping ramp clips at some steps and not others.

Generate against sRGB unless the product is display-restricted, then layer P3 on as an
enhancement. Order matters: the sRGB value first so every display gets something, the P3
rule second so it overrides only where it renders.

```css
.accent { background: #3b82f6; }

@media (color-gamut: p3) {
  .accent { background: oklch(0.62 0.24 259); }
}
```

A P3 color with no sRGB fallback does not degrade, it fails.

## Derived color

`color-mix()`, relative color syntax (`oklch(from var(--accent) calc(l - 0.1) c h)`), and
`light-dark()` all compute at render time. That makes them useful for states and awkward
for tokens: the result cannot be inspected in a design tool or contrast-checked
statically, and a token defined by three chained derivations is unreadable. Keep derived
values out of the primitive tier and measure the rendered result.

## Gradients

The interpolation space is a look, not a correctness setting.

- **`in oklab`** is the best default: even brightness across the transition, no hue surprises.
- **`in oklch`** is polar, so it interpolates the hue angle and arcs around the wheel through every hue between the stops. Reach for it when a two-hue gradient goes gray in the middle, and control the route with `shorter hue` or `longer hue`.
- **The sRGB default** darkens and mutes the midpoint. It is what most interfaces already have, because it is what you get without asking.

The gray dead zone is a rectangular-space problem: two hues on opposite sides of the wheel
sit either side of the neutral axis, and a straight line between them passes near gray.
Switch to a polar space or add a third stop. Large low-contrast gradients band on 8-bit
displays; widen the contrast, shrink the area, or overlay subtle noise. Text on a gradient
is measured at its worst region, never its average.

## Meaning and appearance variants

**One color, one meaning.** Treat anything within 15 degrees of hue as the same color. The
rule runs both ways: if the accent means interactive, that hue on static text invites a
click that does nothing, and an interactive element rendered neutral misleads just as
badly. Use a semantic token only in the role it names; a separator borrowed as a text color
works until borders get lighter, and then the text goes with them.

Color meaning is not universal. Where a color is load-bearing in finance, status, or
alerts, see `internationalization-design` before hardcoding it.

Every custom color needs a light and a dark variant, plus an increased-contrast one for
users who ask for it:

```css
:root { --color-accent-solid: #3b82f6; }
@media (prefers-color-scheme: dark) { :root { --color-accent-solid: #60a5fa; } }
@media (prefers-contrast: more)     { :root { --color-accent-solid: #1d4ed8; } }
```

Widen the foreground and background gap by at least 15 points of perceived lightness for
the increased-contrast variant, then remeasure. Widening without remeasuring is not fixing
it. Pick one switching mechanism, `prefers-color-scheme` or a class, and use it throughout;
half the tokens on each is how a theme ends up half-applied.

## Auditing an existing palette

Most codebases hold several times more colors than the design has decisions.

1. **Collect every literal.** Hex, `rgb(`, `hsl(`, `oklch(`, and utility-class prefixes, including SVG `fill` and `stroke`, chart configs, and email templates. Color hides outside stylesheets.
2. **Sort by perceived lightness within each hue family.** Duplicates surface immediately as near-identical neighbours.
3. **Collapse near-duplicates.** Two colors closer than about one ramp step are one color that drifted. Keep the most-used and retire the rest; never average them.
4. **Assign each survivor a role.** A color matching no role is either a missing token or a mistake. Say which.
5. **Count what is left.** More than one ramp per role means the palette outgrew its structure, not that the product needs more color.

Consolidating a palette changes rendered output on screens nobody asked you to touch.
Report the inventory as a proposal and wait for a decision.

## Checklist

- [ ] One neutral ramp, one accent ramp, and only the status ramps the product renders.
- [ ] Every generated step maps to a role; no steps nothing consumes.
- [ ] Ramp holds hue, steps evenly in perceived lightness, and stops short of pure black and white.
- [ ] Status hues read apart from the accent side by side.
- [ ] Notation matches the project; new systems use `oklch()`.
- [ ] Wide-gamut colors have an sRGB value declared first.
- [ ] Gradient interpolation space chosen deliberately; text measured at the worst region.
- [ ] Light, dark, and `prefers-contrast: more` variants all measured, not assumed.

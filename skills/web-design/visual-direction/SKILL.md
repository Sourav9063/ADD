---
name: visual-direction
description: Choose and hold a visual direction before building UI. Use when starting a page, screen, or product from scratch, when the user asks to "make it look good" or "match this vibe", when working from reference images or a site they admire, when output looks generic, templated, or machine-made, when producing design variants, or when critiquing whether a shipped interface has a coherent point of view.
---

# Visual Direction

Every other skill here answers "how should this component behave". This one answers the
question asked first and skipped most often: **what is this supposed to look like, and why
that.**

Generated UI converges on the same choices: the indigo-to-purple gradient, the rounded card
with a soft shadow, the hero above three feature cards above a testimonial row. None is
wrong alone. Together they read as nobody's product. The fix is grounding the direction in
something real, writing it down before code, and not re-deriving it on the next screen.

## Ground it in something real

Never start from a vibe adjective. Stop at the first rung with something on it:

1. **What the user gave you.** Screenshots, Figma, brand kit, reference sites. Read the actual pixels: palette, type pairing, density, radius, shadow depth, motion feel.
2. **The product's existing surfaces.** **Code beats screenshots** by a wide margin, so when a codebase exists spend the effort extracting its real tokens rather than inferring from an image.
3. **A named anchor.** "Linear-like" or "editorial like print" means specific traits: hierarchy, pacing, contrast, image treatment, motion. Name those, not the brand.
4. **Nothing.** Say plainly that with no reference the result is a reasonable default rather than their taste, propose a direction, and confirm once before building.

From a reference, extract the reusable **structure** (macrostructure, archetypes, type and
color relationships), never the pixels. Reproducing a reference's identity, copy, or assets
is copying, not designing.

## Write it down, then stop re-deriving it

Two short blocks before the first component:

- **The read.** Surface type (marketing narrative, app shell, transactional form, data view, editor, settings), audience, and where this lands on the dials that change output: visual variance, motion intensity, information density, asset dependence. A dashboard earns trust by getting out of the way; a launch page can perform.
- **The system.** Concrete values, not adjectives: palette roles, type families and scale, spacing base, radius strategy, elevation levels, motion curves and durations. "Modern and clean" is not a system. Build each per `color-systems`, `typography-design`, and `design-foundations`.

Confirm the system before the full build. A rough pass with real tokens and placeholder
content beats a polished screen in the wrong direction, because the wrong direction gets
scrapped whole.

Then it is a constraint, not a suggestion. Every later screen references the recorded values
instead of re-deriving them, and where the system lacks a pairing the screen needs (a badge
fill with a label, a new disabled state), that is a decision to record, not a value to
invent inline. Re-deriving per screen is how a product ends up with three type scales and
four grays without anyone deciding to.

## Surfaces and optical detail

The details nobody can name individually, which together are the difference between
polished and almost-right. `design-foundations` sets the radius and elevation scales; this
is how they are applied.

- **Nest radii concentrically.** Outer radius = inner radius + the padding between them. Mismatched radii on closely nested surfaces are the most common source of visual tension in an otherwise clean component. Past roughly 24px of padding the two layers read as separate surfaces, so give each an independent radius instead of forcing the math.
- **Shadows for depth, borders for structure.** Where a border exists only to lift an element, replace it with layered transparent shadow: a 1px spread ring, a tight contact shadow, and a wider ambient one. Shadows use transparency, so they hold over images and varied backgrounds where a fixed border color was never designed to sit. Keep real borders for dividers, table cell boundaries, input outlines, and selected or focus states, which communicate structure rather than elevation.
- **Align optically when geometric centering looks wrong.** A button with a trailing icon wants a couple of pixels less padding on the icon side. Fix asymmetric glyphs in the SVG itself where you can, so no component needs a compensating margin (`icon-design`).
- **Outline images at 1px, low opacity**, so they sit in the same surface language as everything else: pure black at ~10% in light mode, pure white at ~10% in dark. Never a near-black or near-white from the palette, which picks up the surrounding tint and reads as dirt on the image edge. Use `outline` with a negative offset rather than `border`, so it adds no layout width and hugs the corner radius.
- **Proportion the major regions with the same ratio the type scale uses.** A 62/38 split reads as composed where 55/45 reads as an accident. Gutter width carries tone too: tight gutters feel dense and technical, wide ones editorial.
- **Isolate the option you want chosen** (different treatment, not just a badge); uniform cards convert worse than one visually distinct card. Isolation only works against a uniform baseline and only if one thing is emphasized - highlight two and they cancel. Combine scale and elevation with the color shift so the emphasis survives grayscale.

## Vary structure, not just palette

Two pages with different palettes still read as one template when they share a page shape.
Structural sameness is the strongest tell and it survives a perfect color system.

Decide the **argument** first: hook, problem, solution, how it works, proof, close. Four
distinct beats minimum. Then pick a shape that carries it and name it: long-scroll
narrative, editorial index, bento showcase, feature stack, comparison. The shape serves the
argument, not the reverse. Check it against the last thing you built; if nav, hero, and
footer are the same archetypes, change one. Coherent within a product, varied across them.

App shells are exempt. Their shape follows the work being done, and a novel dashboard layout
is a cost, not a feature. See `navigation-design`.

## Show, do not tell

The default failure is a wall of feature cards, each a heading plus two sentences. Writing
another paragraph is the path of least resistance; showing the thing is the design work.

Before writing a paragraph, check whether a visual with a caption carries it, and default to
the visual: a real chart for a speed claim, three panels for a three-step flow, a mockup for
a feature. Text earns its place in headlines, subheads, captions, and labels.

## Source assets, do not fabricate them

An interface with no real imagery reads as unfinished whatever the tokens are, and
fabricated substitutes read worse than nothing.

- **Do not hand-author illustrations** as SVG or CSS path data. Use real assets or mark the slot honestly pending. Geometric brand marks, interface icons, and data graphics are fine to author.
- **Avatars are photographs**, never initials-in-a-circle, silhouettes, or generated people presented as real customers.
- **For brand work the logo is non-negotiable.** A brand is recognized by its mark and product imagery, not its hex codes. If the real mark cannot be sourced, stop and ask rather than shipping a colored rectangle.
- **Never invent proof.** No fabricated testimonials, no logo walls of non-customers, no invented metrics. Omit the section instead.

Placeholder copy is the other half of this. `microcopy` owns the rules; the short version is
that Lorem Ipsum, "Acme Corp", and round fake numbers all announce that nobody read the
result.

## Variants are different answers

When direction is genuinely uncertain, build two or three rather than arguing about one. A
variant must differ on a **named axis**: layout, density, interaction model, or motion.
Three color swaps of one layout is one design in three shirts and teaches nothing. Every
variant clears the same floor: real content, all states, keyboard reachable. Present the
tradeoff, promote one, delete the rest.

## Critique

Asked whether something is good, or self-checking before handoff, give each dimension a
concrete finding rather than a score alone:

| Dimension | Question |
| --- | --- |
| Coherence | Does every detail trace to the stated direction, or has it drifted? |
| Hierarchy | Does the eye go where intended? Does it survive squinting? |
| Craft | Alignment, one spacing scale, controlled color count, consistent radii and strokes. |
| Necessity | Delete each element in turn. Does the design get worse? If not it was decoration. |
| Originality | Is there a decision that is unexpected and right, or is it the template? |

Critique the design, not the designer, and rank by user impact rather than ease of fix.

## Tells

Sweep before handoff. Each is individually defensible and collectively diagnostic: purple-to-indigo
or cyan gradient backgrounds and decorative gradient text; hero then exactly three feature
cards then testimonial then CTA then footer; every section the same height and padding;
`transition: all` and motion ignoring `prefers-reduced-motion`; emoji as icons or mixed icon
sets; dead links and no current-page indication; glass and blur on everything rather than one
layer; bento grids and pricing tables with nothing to hold; copy that describes the product
without ever showing it.

Any tell that survives should be a choice you can defend, not one you missed.

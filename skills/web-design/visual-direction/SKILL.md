---
name: visual-direction
description: Choose and hold a visual direction before building UI. Use when starting a page, screen, or product from scratch, when the user asks to "make it look good" or "match this vibe", when working from reference images or a site they admire, when output looks generic, templated, or machine-made, when producing design variants, or when critiquing whether a shipped interface has a coherent point of view.
---

# Visual Direction

Every other skill in this group answers "how should this component behave". This one
answers the question asked first and skipped most often: **what is this supposed to look
like, and why that.**

Generated UI converges. Left to invent taste from a text description, the same handful of
choices come out every time: the same indigo-to-purple gradient, the same rounded card with
a soft shadow, the same hero above the same three feature cards above the same testimonial
row. None of it is wrong on its own. Together it reads as nobody's product.

The fix is not a bigger catalog of styles to pick from. It is grounding the direction in
something real, writing it down before writing code, and then not re-deriving it on the
next screen.

## Ground the direction in something real

Never start from a vibe adjective. Work down this order and stop at the first rung that
has something on it:

1. **What the user gave you.** Screenshots, a Figma file, a brand kit, reference sites. Read the actual pixels: palette, type pairing, density, radius, shadow depth, motion feel.
2. **The product's existing surfaces.** If a codebase exists, read it and extract the real tokens. **Code beats screenshots.** Rebuilding from source is far more accurate than inferring from an image, so when both exist, spend the effort on the code.
3. **A named anchor.** If the user says "Linear-like" or "editorial like a print magazine", name the specific traits that means (hierarchy, pacing, contrast, image treatment, motion) rather than the brand.
4. **Nothing.** Say plainly that with no reference the result is a reasonable default rather than their taste, propose a direction, and get one round of confirmation before building.

When working from a reference, extract the **reusable structure**, never the pixels:
macrostructure, archetypes, type relationships, color relationships. Reproducing a
reference's identity, copy, or assets is copying, not designing.

## Write the direction down before the code

Two short blocks, both before the first component:

**The read.** What is being built, for whom, in what register. Surface type (marketing
narrative, app shell, transactional form, data view, editor, settings), audience, and where
this lands on the dials that actually change output: visual variance, motion intensity,
information density, and how much it depends on real assets. A dashboard earns trust by
getting out of the way; a launch page can afford to perform. The same tokens serve them
differently.

**The system.** Concrete values, not adjectives: palette roles, type families and scale,
spacing base, radius strategy, elevation levels, motion curves and durations. "Modern and
clean" is not a system. Point at `color-systems`, `typography-design`, and
`design-foundations` for how each is built.

Confirm the system before building the whole thing. A rough first pass with real tokens and
placeholder content is worth more than a polished screen in the wrong direction, because
the wrong direction gets scrapped entirely.

## Lock it, then reuse it

Once the system exists, it is a constraint, not a suggestion. Every later screen references
the recorded values rather than re-deriving a palette or a type pairing from the brief
again. Re-deriving per screen is exactly how a product ends up with three type scales and
four grays, and it happens without anyone deciding to do it.

Record where the values live in the repository so the next session reads them instead of
guessing. When a screen needs a pairing the system does not have (a badge fill with a
label, a new disabled state), that is a decision to make and record, not a value to invent
inline.

## Vary the structure, not just the palette

Two pages with different palettes still read as the same template when they share a page
shape. Structural sameness is the strongest tell, and it survives a perfect color system.

Decide the **argument** before the shape. For a page that has to persuade, that is roughly:
hook, problem, solution, how it works, proof, close. Four distinct beats minimum. Then pick
a shape that carries that argument, and name it: long-scroll narrative, editorial index,
bento showcase, feature stack, side-by-side comparison. The shape exists to serve the
argument, not the other way around.

Then check the shape against the last thing you built. If the nav, the hero, and the
footer are the same archetypes as last time, change one. Within a single product keep pages
coherent; across products, vary.

App shells are exempt from this. Their shape is governed by the work being done, and
inventing a novel dashboard layout is a cost, not a feature. See `navigation-design`.

## Show, do not tell

The default failure is a wall of feature cards, each with a heading and two sentences
explaining a benefit. Writing another paragraph is the path of least resistance; showing
the thing is the design work.

Before writing a paragraph to explain something, ask whether a visual with a caption could
carry it, and default to the visual. A "fast analytics" claim becomes a real chart. A
three-step onboarding becomes three visual panels. A feature becomes a small mockup of that
feature. Text earns its place in headlines, subheads, captions, and labels, where a visual
genuinely cannot carry the meaning.

## Source assets, do not fabricate them

An interface with no real imagery reads as unfinished no matter how good the tokens are,
and fabricated substitutes read worse than nothing.

- **Do not hand-author illustrations** as SVG or CSS path data. Use real illustration assets, or leave the slot honest and say it is pending. Simple geometric brand marks, interface icons, and data graphics are fine to author.
- **Avatars are photographs.** Never initials-in-a-circle, faceless silhouettes, or generated people presented as real customers.
- **For brand work, the logo is non-negotiable.** A brand is recognized by its mark and its product imagery, not its hex codes. If the real mark cannot be sourced, stop and ask rather than shipping a colored rectangle.
- **One icon set, one stroke weight**, per `design-foundations`. Emoji are not an icon set.
- **Never invent proof.** No fabricated testimonials, no logo walls of companies that are not customers, no invented metrics. Omit the section instead.

## Content realism

Placeholder content is the loudest tell that nobody looked at the result.

- No Lorem Ipsum. Write real draft copy.
- No "John Doe", no "Acme Corp". Use varied, plausible names for people and products.
- No round fake numbers. `99.99%` and `$100.00` read as invented; organic figures do not.
- No filler vocabulary: "elevate", "seamless", "unleash", "next-gen", "game changer", "in the world of". See `microcopy` for tone.
- Sentence case headings, active voice, no exclamation marks in success messages, no "Oops!" in errors.
- Vary the data: different dates, different lengths, one long name that tests the layout.

## Variants are different answers

When the direction is genuinely uncertain, build two or three variants rather than
arguing about one. But a variant must differ on a **named axis**: layout, density,
interaction model, or motion. Three color swaps of the same layout are one design in three
shirts, and comparing them teaches nothing.

Every variant clears the same floor: real content, all states, keyboard reachable. Present
the tradeoff, promote one, delete the rest.

## Critique

When asked whether something is good, or as a self-check before handing off, score it on
five dimensions and give each a concrete finding rather than a number alone:

| Dimension | Question |
| --- | --- |
| Coherence | Does every detail trace back to the stated direction, or has it drifted into a mix? |
| Hierarchy | Does the eye go where intended? Does it survive squinting at it? |
| Craft | Alignment, one spacing scale, controlled color count, consistent radii and stroke weights. |
| Necessity | Delete each element in turn. Does the design get worse? If not, it was decoration. |
| Originality | Is there a decision here that is unexpected and right, or is it the default template? |

Critique the design, not the designer, and rank findings by user impact rather than by how
easy they are to fix.

## Common tells

Sweep for these before handing anything off. Each one is individually defensible and
collectively diagnostic:

- Purple-to-indigo or cyan gradient backgrounds, and gradient text as decoration.
- Hero, then exactly three feature cards, then a testimonial, then a CTA, then a footer.
- Every section the same height and the same padding, so nothing gets its own moment.
- `transition: all`, and motion that ignores `prefers-reduced-motion`.
- Emoji used as icons; mixed icon sets or stroke weights.
- Dead links: a `<button>` or `<a href="#">` that goes nowhere, and no indication of the current page.
- Glass and blur applied to everything rather than to one layer.
- Bento grids and pricing tables whose cells have nothing to hold.
- Copy that describes the product without ever showing it.

## Checklist

- [ ] Direction grounded in a reference, the existing product, or an explicitly stated default.
- [ ] The read and the system written down and confirmed before full build.
- [ ] Later screens reuse the recorded system instead of re-deriving it.
- [ ] Page shape chosen to carry a named argument, and different from the last one built.
- [ ] Sections show rather than describe; no section is a text wall where a visual belongs.
- [ ] Assets are real or honestly marked pending; no invented proof.
- [ ] No placeholder copy, placeholder names, or round fake numbers.
- [ ] Variants differ on a named axis, not by tint.
- [ ] Tells swept; every remaining one is a deliberate choice you can defend.

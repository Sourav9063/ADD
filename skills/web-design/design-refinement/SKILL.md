---
name: design-refinement
description: Improve the look of an interface that already exists without breaking what it does. Use when redesigning, modernizing, refreshing, or restyling an existing site, page, or app, when polishing UI before launch, when asked to make a section bolder, louder, or more distinctive, to make it quieter, calmer, or tone it down, or to simplify, declutter, or strip a screen back.
---

# Design Refinement

Changing the look of a shipped interface fails in two opposite ways: polish that quietly
turns into a redesign nobody approved, and a redesign that only polishes the look it was
meant to replace. Name the mode first, protect what must not move, then change the
smallest thing that reaches the goal.

Load `ui-composition` for the screen workflow and `visual-direction` when the direction
itself changes. This skill owns the mode, the preservation contract, and the tuning passes.

## Name the mode

| Mode | The request | What stays | What changes |
| --- | --- | --- | --- |
| Polish | "Clean this up", "get it ready to ship" | The visual world, content, behavior, scope | Defects, drift, missing states |
| Tune | "Bolder", "quieter", "simpler" | The system; everything outside the named target | One axis of intensity on one target |
| Redesign | "Modernize", "redesign", "it looks dated" | Product truth: content, function, brand commitments | The visual world |

A new section inside an established page is neither: it inherits the page, and
`ui-composition` owns it. When the request is ambiguous between polish and redesign, ask
once, because the two produce opposite diffs. When a polish or tune reveals that the concept
itself is wrong, say so and recommend a redesign instead of smuggling one in.

## Audit before touching anything

Record the baseline so nothing disappears by accident:

- tokens, shared components, and the most reused comparable screen (`ui-composition`);
- routes, navigation labels, and the information architecture;
- the SEO baseline: titles, meta descriptions, heading outline, structured data, canonical URLs;
- analytics events, test IDs, and form field `name` and `id` values that integrations read;
- brand assets, legal and compliance copy, and every factual claim or figure on the page.

**Never change silently:** URLs, navigation labels, form field names, analytics hooks, the
logo, legal copy, and product claims. Each is load-bearing outside the page: bookmarks and
search ranking, muscle memory, autofill and integrations, reporting, trademark, and law.
Change one only when the request authorizes it, and name each change in the report.

## Redesign: the old look is evidence, not authority

Keep what the product *is*: its content, its function, its confirmed brand assets, and the
recognizable traits users would miss. Discard what it merely *looked like*. Do not carry old
spacing, radii, or colors into the new system out of caution; one screen in two visual
languages is worse than either. Choose the new direction with `visual-direction`, then
rebuild the system before the screens.

Reach for levers in order of cost, and stop at the first that meets the brief:

1. **Type**: face, scale, measure, and weight contrast (`typography-design`).
2. **Space**: one scale, a deliberate rhythm, section spacing weighted by role.
3. **Color**: strategy and roles, then values (`color-systems`).
4. **Surfaces**: radius family, elevation, borders, image treatment.
5. **Motion**: one authored moment, then state feedback (`motion-design`).
6. **Recomposition**: reorder or reshape sections around the argument.
7. **Replacement**: swap whole blocks for new patterns.

Most "it looks dated" requests are solved by the first three. The last two change the
page's argument, so confirm them before building.

## Polish: fix causes, in order

Classify each finding before fixing it: a **missing token** the system needs, a **one-off**
a shared component should replace, a **conceptual mismatch** with how comparable screens
work, or a **local defect**. Fix at the narrowest level that removes the cause.

Work in this order, across the whole path rather than perfecting one corner:

1. Broken or blocked tasks, data loss, misleading state, inaccessible paths.
2. Missing loading, empty, error, success, disabled, and permission states (`feedback-design`).
3. Hierarchy, responsive, and design-system drift.
4. Visual and motion inconsistency: optical alignment, shared baselines across sibling cards, card actions pinned to the card bottom, one icon family, consistent radii.
5. Cleanup: dead styles, duplicated values, debug output.

## Tune: one axis, one target

"Everything else stays" is literal. Touch only the named target, and add no new color, face,
radius, or shadow the system does not already own; if the system cannot express the change,
name the addition and ask.

**Bolder.** A flat section usually opts out of moves its neighbours already make. Bring it up
to the system's own strongest level: its largest type step at full weight, its signature
motif, its accent committed over a larger area. Make one decisive move, then quiet what
surrounds it so the move reads; if everything got louder, nothing did. Adding effects (glow,
gradient, blur, motion) is the reflex answer and rarely the bold one. Check the skeleton:
with the copy removed, does the structure alone still say what matters?

**Quieter.** Find the intensity sources first: saturation, competing heavy weights, too many
accents, extreme contrast, motion distance, decoration. Lower them while keeping a few
anchors at full strength, since hierarchy still needs peaks. Quiet is not grayscale and not
generic: keep the point of view, remove the noise around it.

**Simpler.** Name the one job, then delete each element in turn and keep only what the
screen is worse without. Remove repeated information, containers that only group, cards
nested in cards, and copy that restates its heading. Move rare options behind progressive
disclosure. Never remove information needed to decide, a recovery path, or an accessible
name.

## Verify and report

Verify in the bounded rounds `ui-composition` defines, comparing against the recorded
baseline: every preserved item still present and working, keyboard and screen-reader paths
intact, no layout shift introduced. Report the mode, the levers used, what was deliberately
preserved, every authorized change to the never-change list, and the open items left for
the user.

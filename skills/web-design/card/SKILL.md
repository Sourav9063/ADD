---
name: card
description: Build or review a single card. Use when creating a content card, product tile, media card, or summary panel, ordering its media, title, metadata, and actions, styling its padding, radius, border, and shadow, or handling card hover, click targets, and nested actions.
---

# Card

Assumes `design-foundations` for tokens, elevation, and radius. Grids, feeds, and the
choice between card, list, and table belong to `card-and-list-design`; this skill is the
card itself.

## Is a card the right container?

A card groups a *self-contained* thing you can act on as a unit. It is not a decoration for
a paragraph, and a page of cards inside cards inside cards ("bento everything") flattens
hierarchy instead of creating it. If the items are comparable records scanned by one
attribute, use a table; if the visual is not the content, use a list.

## Anatomy

Fixed order, repeated across every card in the product, because scanning depends on the
position being predictable:

**media → eyebrow/meta → title → description → metadata → actions**

- **Generous padding**: 20-24px in dense UI, up to 40px for marketing cards. Cramped padding is the strongest "cheap" signal a UI gives off.
- **Radius** from the token scale; nested media radius = outer radius − padding, or the corners visibly disagree.
- **Two shadows, not one**: a tight dark one for contrast plus a wide soft one for ambience, and a hairline border at ~10-12% opacity so the edge survives on any background.
- **Hierarchy through weight and opacity**: title at 600, body at ~60-70% of the title's emphasis. Equal weight everywhere means nothing is read first (`typography-design`).
- Truncate titles at 2 lines and descriptions at 3 (`line-clamp`), with the full text on the detail view - never only in a tooltip.
- In a row, cards are equal height with the action row pinned to the bottom (`margin-top: auto`) so ragged content does not stagger the buttons.
- Reserve media aspect ratio so images do not shift the layout as they load (`frontend-performance`).

## Click targets

Nested links inside a clickable card produce ambiguous targets and unusable markup. Use the
**stretched-link** pattern: one real `<a>` on the title, expanded to cover the card with a
pseudo-element, with any secondary action positioned above it in its own stacking context
and stopping propagation.

- One primary destination per card. Never wrap a card containing buttons in an `<a>`.
- Text inside a stretched-link card cannot be selected; if selection matters (code, IDs), do not stretch the link.
- A whole-card target still needs a visible affordance - cursor, border, or elevation change - that it is clickable at all.

## Hover and focus

- Lift ~8px and expand the shadow over ~200ms `ease-out`. Faster reads as twitchy, slower feels stuck.
- **Never scale the whole card**: it shifts neighbors and breaks the grid. Scale the *image* to ~1.05 inside an `overflow: hidden` frame so the content presses against the glass while the outer box holds still.
- Reveal secondary actions staggered ~60ms apart into a reserved row so nothing reflows. On touch and for keyboard users those actions are permanently present - hover-only actions do not exist on a phone.
- The focus style is the hover style plus a real focus ring, not the hover style alone.

## Selection and state

- Selected cards use a real checkbox or `role="option"` with `aria-selected`, plus a fill and a check - not a colored border alone (`checkbox-and-radio`).
- Status lives in one badge, not three (`badge-and-tag`).
- Loading uses a skeleton card in the same shape (`skeleton`); a card with three empty rows and no shimmer reads as broken.
- Disabled or unavailable cards say why, and stay readable rather than dropping to 40% opacity.

## Accessibility

- The card is not a landmark. Use `<article>` or `<li>` inside a real list, with the title as a heading at the correct level.
- One tab stop for the card's primary link plus one per secondary action; twelve focus stops per card makes a grid unusable.
- Meaningful media gets real `alt`; decorative card art gets `alt=""`.
- Do not convey the card's meaning through its accent color alone - a colored left border needs a text equivalent.

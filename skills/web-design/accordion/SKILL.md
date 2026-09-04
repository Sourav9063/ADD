---
name: accordion
description: Build or review accordions and disclosure. Use when adding collapsible sections, an FAQ list, expandable rows or panels, a show-more toggle, or nested settings groups, and when deciding whether content should be collapsed at all.
---

# Accordion

Assumes `design-foundations` for tokens and motion. An accordion trades visibility for
scannability. That trade is worth it when the user needs *one* of many sections and the
headings tell them which - and it is a bad trade otherwise.

## Should this collapse at all?

- **Collapse** when the content is long, optional, and independent: FAQs, advanced settings, per-item detail.
- **Do not collapse** the primary content of a page, anything most users need on arrival, or short content that would fit anyway. Hiding three lines behind a click is friction with no payoff.
- Do not use an accordion to make a long page look short. Content people must read should be visible; collapsing it moves the scroll into a series of clicks.
- Never collapse form fields that are required, or errors - an error inside a collapsed panel is invisible and blocks submit with no explanation (`form-design`).

## Behavior

- **Multiple panels open at once by default.** Auto-closing the previous panel is the single most annoying variant, because comparing two sections becomes impossible. Reserve single-open mode for cases where the panels are genuinely alternatives.
- Open the panel the user is most likely to need on first render - the first item, the section matching the URL hash, or the one with an error.
- Deep-link to a panel: an anchored or query-backed open state that survives refresh and Back, and expands automatically when linked (`navigation-design`).
- Expanding must not move the header the user just clicked. Keep the clicked header in place and let content grow downward; if the panel opens above the fold boundary, scroll it into view deliberately.
- Search on the page should reveal matches inside collapsed panels, or the content is unfindable - browser find-in-page cannot see it either. Use `hidden="until-found"` where supported.

## Header and affordance

- The whole header row is the trigger, not just the chevron or the text.
- A chevron that **rotates** 180° on expand states the state; a plus/minus swap states an action. Pick one convention per product.
- Put the chevron consistently: leading for nested or hierarchical content, trailing for FAQ-style lists. Never both in one product.
- Give the header enough height to be a real target (44px on touch), a hover state, and a focus ring.
- Show the payload where it helps: a count, a status badge, or a summary of the collapsed content ("3 selected") so the user can decide without opening.

## Motion

- Animate height over ~200-250ms `ease-out`, with the content fading in slightly behind the height change so text does not appear stretched.
- Height animation must be interruptible: clicking twice quickly reverses from the current position rather than queueing (`motion-design`).
- Animating to `height: auto` requires measuring the content or using `grid-template-rows: 0fr → 1fr`; a hard-coded max-height either clips long content or makes short content sluggish.
- Under `prefers-reduced-motion`, toggle instantly.

## Accessibility

- The header is a real `<button>` with `aria-expanded` and `aria-controls` pointing at the panel; the panel references its header with `aria-labelledby`.
- Wrap each header in the correct heading level (`<h3><button>…</button></h3>`), so screen-reader users can navigate the sections by heading.
- Collapsed content is genuinely hidden (`hidden` or `display: none`), not just visually clipped, or its links stay in the tab order and its text is announced.
- Tab moves between headers; arrow-key navigation between headers is optional and, if implemented, follows the APG accordion pattern.
- Native `<details>`/`<summary>` gives all of this for free and is the right default when custom styling and animation are not required.

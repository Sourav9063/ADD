---
name: link
description: Build or review links. Use when styling inline or standalone links, deciding on underlines and visited states, opening in a new tab, adding external, download, or anchor links, writing link text, or when links are indistinguishable from body text.
---

# Link

Assumes `typography-design` for underline craft and `design-foundations` for color and
focus. A link navigates; a button acts (`button`). Getting that backwards breaks
middle-click, Back, Enter versus Space, and how the element is announced.

## Make it look like a link

- **Underline links in body text.** Color alone fails anyone who cannot see the hue, and WCAG requires a non-color distinction unless the link contrast against surrounding text is at least 3:1 *and* a non-color cue appears on hover and focus.
- Standalone links - nav items, card titles, buttons-styled-as-links - may drop the underline because position and weight already mark them.
- Style the underline properly: `text-underline-offset` of a few pixels and a thinner `text-decoration-thickness`, with `text-decoration-skip-ink: auto` so descenders stay legible.
- Hover changes something real (thicker underline, darker color); focus shows a visible ring, not just an underline change.
- Link color meets 4.5:1 against the background, and remains distinguishable in dark mode (`color-systems`).
- Keep `:visited` where the product benefits from it - search results, documentation, long reference lists - because it is one of the few free wayfinding cues the web gives you.

## Write the text, not the URL

- The link text names the destination or the outcome: "Read the refund policy", not "click here", "read more", or a bare URL.
- It must make sense out of context, because screen-reader users navigate by a list of links. Twelve "Learn more" links are twelve identical entries.
- Do not link a whole sentence; link the phrase that names the target.
- Never expose a raw URL as link text except where the URL itself is the information; if you must, break it so it does not overflow (`typography-design`).
- Repeated links to the same place use the same words; different words imply different destinations.

## New tabs, external, and downloads

- **Default to same tab.** Opening a new tab takes the Back button away from the user; they can middle-click if they want one.
- Where a new tab is genuinely right (a reference alongside a form being filled), say so: an external-link icon plus text in the accessible name ("opens in a new tab").
- `target="_blank"` always ships with `rel="noopener"` - modern browsers imply it, but old ones do not and the reverse-tabnabbing risk is real.
- Download links state the format and size ("PDF, 2.3 MB") and use the `download` attribute where the file should not open in place.
- Links that leave for a different product or a payment processor say where they are going before they go.

## Anchors and in-page navigation

- Anchor targets get scroll margin so a sticky header does not cover the heading that was jumped to, and focus moves to the target, not just the scroll position.
- A skip link is the first focusable element on the page, visible on focus, and points at the main content (`navigation-design`).
- Do not hijack in-page anchors with smooth-scroll that ignores `prefers-reduced-motion`, and never trap the user in a scroll animation they cannot interrupt.
- Fragment links must survive being copied and pasted; generate stable IDs, not indexes that change on every render.

## Accessibility

- A link needs an `href`. An `<a>` without one is not focusable, not announced as a link, and not activatable by keyboard.
- Enter activates a link; Space does not. Do not add a Space handler to fake a button - use a button.
- Target size still applies: inline links in prose are exempt, but standalone links meet the 24px minimum.
- Icon-only links (social icons, an external-link glyph) need an accessible name, not a bare SVG.
- Do not remove focus outlines on links "because they are inline". Keyboard users navigate the page by them.

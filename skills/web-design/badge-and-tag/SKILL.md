---
name: badge-and-tag
description: Build or review badges, status pills, tags, chips, and notification counts. Use when showing status or state on a row or card, labeling categories, rendering removable tags or filter chips, adding a count indicator or dot on an icon, or when badges are multiplying and losing meaning.
---

# Badge and Tag

Assumes `design-foundations` for tokens and `color-systems` for status color. Three
different components share one shape, and mixing them is the usual failure:

- **Badge / status pill** - system state of the thing it sits on. Not clickable.
- **Tag / chip** - user or content metadata: categories, labels, skills. Often removable, sometimes clickable as a filter.
- **Count / dot** - an unread or pending quantity, attached to an icon or a nav item.

## Badges

- **Status, never decoration.** One per row or card unless they are a deliberate set (status + plan + region). Three badges of equal weight teach people to skip all of them.
- Icon **plus** text, never color alone: `● Active`, `⏸ Paused`, `✕ Failed`. A green pill and a red pill are identical in grayscale and to a red-green colorblind user (`design-foundations`).
- Reserve the danger color for genuinely bad states, and keep neutral states neutral. A palette where every badge is colored has no emphasis left.
- Keep the vocabulary small and fixed - five or six states across the product - and use the same word for the same state everywhere (`microcopy`).
- Size to the text with the label at 11-12px and enough horizontal padding to read as a pill, not a cramped box. No all-caps text transform on long or non-Latin labels.
- Do not put a badge in a heading; it competes with the title it is meant to annotate.

## Tags and chips

- Cap the visible tags at ~3 with a `+4` overflow that reveals the rest on click, not on hover only.
- Removable tags carry an × with its own accessible name ("Remove design") and a real 24px target - an 8px × inside a 20px pill is unhittable.
- A clickable tag is a real button or link with a hover and focus state; a tag that only *looks* clickable is worse than a plain one.
- Truncate long tags with a max width and reveal the full value on the detail view; never let one tag push the row's metadata off screen.
- Filter chips in a search UI follow `search-and-filter-design` - applied filters, individually removable, with Clear all.
- Colors for user-created tags come from a deterministic hash of the label or ID, so the same tag looks the same everywhere and nobody picks colors that fail contrast.

## Counts and dots

- Cap at `99+` and **never let the badge resize its container** - a growing count that shifts the nav is a layout bug that appears only in production.
- A dot (no number) is enough where the exact count does not matter; it is quieter and never overflows.
- Position over the icon's corner with a small gap or a matching-background stroke so it stays legible on any surface.
- Zero renders nothing at all, not a `0` badge.
- Announce counts as text ("3 unread notifications"), and update politely - a live region firing on every increment is noise.

## Accessibility

- A badge is content, not an image: the state must be in text that a screen reader reaches, even if the visual is an icon plus color.
- A status badge on a row needs the row's subject in its accessible name, or "Failed" is announced with no idea what failed.
- Text on tinted fills meets 4.5:1, and the pill's own edge meets 3:1 against the surface where the border carries meaning.
- Do not use `title` as the only source of a badge's meaning; it is unreachable on touch and unreliable for assistive tech (`tooltip`).

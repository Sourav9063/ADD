---
name: avatar
description: Build or review avatars and identity chrome. Use when showing a user or organization image, initials fallbacks, avatar stacks or groups, presence and status indicators on an avatar, avatar sizes and shapes, or upload and cropping of a profile picture.
---

# Avatar

Assumes `design-foundations` for tokens and `media-design` for upload and cropping. An
avatar's job is recognition at a glance, at sizes where nothing else survives.

## Fallbacks are the component

Most avatars in most products have no image. The fallback is the default case, not the
error case:

1. **Image** when one exists, cropped to fill, never letterboxed or stretched.
2. **Initials** - one or two letters - on a color derived deterministically from the user's ID or name, so the same person is the same color everywhere and across sessions.
3. **A neutral glyph** only when there is no name either. Never a broken-image icon, and never an empty gray circle with nothing in it.

Derive initials carefully: many names have one word, many scripts do not split on spaces,
and two initials from a three-part name are frequently wrong. Take what the name gives you,
and never invent a middle initial (`internationalization-design`).

## Shape and size

- Pick circle or rounded-square per product and hold it: circles for people, rounded squares for organizations and bots is a common, legible convention.
- A size scale of roughly 20 / 24 / 32 / 40 / 64 / 96px. Below 24px, initials stop being readable - use a single letter or drop to a dot.
- Render at 2× for crisp images, set explicit dimensions so the layout never shifts, and lazy-load anything below the fold (`frontend-performance`).
- Add a subtle inner border at ~10% opacity so a white or light image keeps an edge on a white surface.
- Never distort: `object-fit: cover` with a centered focal point, and prefer a face-aware crop if the platform offers one.

## Stacks and groups

- Overlap by roughly 25-30% of the avatar width, with a ring in the surface color separating each from the next.
- **Cap at 3-5 plus a `+n`**, and make the `+n` the same size and shape as the rest. The overflow reveals the full list on click, not on hover alone.
- Order deliberately - most recent, most active, or alphabetical - and keep it stable so the stack does not reshuffle on every render.
- The stack's accessible name is the list, not the count: "Sam, Aki, Jo and 4 others".

## Presence and status

- A presence dot sits at a fixed corner with a surface-colored ring, and its meaning is stated in text too - green is invisible to a screen reader and ambiguous in grayscale (`collaboration-design`).
- Distinguish online, idle, offline, and unknown; never render "unknown" as "offline", which claims something you do not know.
- A badge on an avatar (role, verified, count) uses the badge rules and never covers the face (`badge-and-tag`).

## Interaction

- An avatar that opens a profile or menu is a real `<button>` or `<a>` with a name, a focus ring, and a 24px minimum target - a 20px avatar needs padding around it, not a bigger picture.
- A decorative avatar next to a name that is already a link is not a second link; make one of them the target.
- Editing a profile picture happens in a real upload flow with cropping and a preview at the shape it will be used (`file-upload`).

## Accessibility

- `alt` is the person's name when the avatar carries identity on its own; `alt=""` when the name is already beside it, or the name gets announced twice on every row.
- Initials fallbacks must meet contrast against their generated background - clamp the generated palette to lightness values that pass, rather than hashing to arbitrary hues.
- Do not put the user's email or any private detail in the accessible name of a public avatar.
- Real photographs for real people; do not generate or stock-source a face and present it as a customer (`visual-direction`).

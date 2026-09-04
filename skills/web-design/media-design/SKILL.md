---
name: media-design
description: Build or review video, audio, and image media UI. Use when embedding or building a player, adding custom playback controls, captions, transcripts, or audio description, handling autoplay, posters, and buffering, or building an image gallery, carousel, lightbox, or zoom viewer.
---

# Media Design

Assumes `design-foundations` for tokens and focus, and `frontend-performance` for loading
cost. Media is the heaviest and least accessible thing on most pages, and a custom player
throws away everything the native element gives you for free.

## Before building a player

- Use the native `<video>` or `<audio>` element with `controls` unless the design genuinely needs chrome the native player cannot express. Native gets keyboard, screen reader, caption menus, picture-in-picture, and platform gestures at no cost.
- A hosted player (a real one, not an iframe of unknown quality) is the next choice. Audit it the way you would audit your own: keyboard, captions, focus styles.
- Build custom only when you own the whole contract below. "It looked nicer" is not sufficient reason to reimplement a media player.
- Reserve the box with `aspect-ratio` or `width`/`height`, ship a poster image, and load the media itself on interaction. See `frontend-performance`.

## Controls

- Minimum set: play/pause, current time and duration, a seek bar, volume with mute, captions toggle, and fullscreen. Playback speed and quality where the content justifies them.
- Controls persist for long enough to be found, reappear on any pointer or key input, and **never auto-hide while focus is inside them**. Hover-only controls do not exist on touch or for keyboard users.
- The seek bar is a real slider: draggable, clickable, with a buffered range shown behind the played range, and a hit area that survives a thumb. Show a time preview on scrub where the content is long.
- Tap targets meet the 24×24 minimum with the bar at the bottom of the frame, clear of the safe area on mobile (`responsive-design`).
- Time is `mm:ss` with `hh:mm:ss` only past an hour, in tabular numbers so the layout does not jitter (`typography-design`).

## Keyboard and semantics for custom players

- Follow the conventions people already have: Space or K toggles play, arrows seek by ~5s and adjust volume, J and L jump ~10s, M mutes, C toggles captions, F toggles fullscreen, Escape exits it. Document them in a help affordance.
- Shortcuts are scoped to the player when it has focus. A global Space handler that hijacks page scrolling is a bug.
- Every control built from a `div` needs its role, name, and state: `role="button"` with `aria-pressed` for toggles, `role="slider"` with `aria-valuenow`, `aria-valuemin`, `aria-valuemax`, and `aria-valuetext` for seek and volume. The play button's name changes between "Play" and "Pause"; do not swap only the icon.
- Keep focus styles. A player is the most common place they get deleted, and it is where keyboard users most need them.
- Buffering, errors, and caption-track changes go to a polite live region, not to an icon alone.

## Captions, transcripts, and description

- Captions for all prerecorded audio in synchronized media, as a real track (WebVTT) rather than burned into the pixels, so they can be sized, restyled, turned off, and read by assistive tech.
- Captions carry speaker identification and meaningful non-speech sound, stay in sync, and are checked by a human when they came from a machine.
- Provide a transcript as well, and make it descriptive - including the visual information - when the video carries meaning the audio does not. A transcript is also the cheapest accessibility win: it is searchable, indexable, and skimmable.
- Audio description where the visuals carry information the narration does not. Plan it in the script; retrofitting description into finished footage is what makes it expensive.
- Live content needs live captions; if you cannot provide them, say so up front rather than shipping auto-captions no one has checked.

## Autoplay

- Do not autoplay with sound. If media plays automatically for more than three seconds, WCAG requires a way to pause, stop, or control volume, visible on load without hovering or scrolling.
- Decorative background video is muted, has a visible pause control, and is skipped entirely under `prefers-reduced-motion`. Ship a poster fallback so it never blocks the first paint.
- Nothing flashes more than three times per second.
- Respect data saving and metered connections: `preload="none"` by default, `preload="metadata"` only when the duration is part of the layout.

## Playback states

- Buffering during playback shows a spinner inside the frame, not a page-level loader; a stall over a few seconds gets a message and a retry.
- Playback errors say what failed and what to do - unsupported format, network, geo-restriction, expired link - and leave the poster and the transcript in place.
- Preserve position on reload for long content, and offer a resume affordance rather than restarting silently.

## Galleries, carousels, and lightboxes

- Show the count and the current position; an unnumbered carousel hides how much is left. Thumbnails beat dots past about five items.
- Never auto-advance. If a carousel must rotate, it stops on hover, focus, and interaction, and has a visible pause. Hero carousels on marketing pages are a losing pattern - see `landing-page-design`.
- Arrows are real buttons, always reachable by keyboard, with swipe as an addition on touch and never as the only path. Slides that scroll out of view stay out of the tab order.
- A lightbox is a modal: focus trapped, Escape closes, focus returns to the thumbnail that opened it, background scroll locked (`overlay-design`). Keep arrow-key navigation between items and the counter visible.
- Zoom is a control, not a hover trick, and pinch-zoom must not be disabled.
- Load thumbnails eagerly and full-size images on demand; state the dimensions or file size where the download matters.

## Alternative text and content warnings

- Meaningful images get alt text describing what matters here, not a caption restated; decorative ones get empty alt. Gallery items usually need both a short name and a longer description.
- Do not put load-bearing text inside an image. It cannot be selected, translated, or resized, and it is the first thing to fail in `internationalization-design`.
- Where content warrants it, gate the media behind an explicit play or reveal rather than surprising the viewer.

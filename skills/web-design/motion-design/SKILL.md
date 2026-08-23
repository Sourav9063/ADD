---
name: motion-design
description: Design or fix UI animation. Use when adding transitions, easing, springs, page or shared-element transitions, scroll-driven or parallax effects, accordion and disclosure animation, list staggers, hover and press feedback, loading motion, or when an interface feels janky, twitchy, sluggish, or busy.
---

# Motion Design

`design-foundations` holds the duration table every component uses. This skill is for
deciding **whether** to animate, choosing the curve, and building the harder transitions.

## When to animate

Motion has exactly four jobs: show **causality** (this came from that), **continuity**
(same object, new position), **status** (something is happening), and **hierarchy** (look
here first). Animation that serves none of them is decoration, and decoration on a control
someone uses forty times a day becomes friction.

Rule of thumb: animate state *changes*, never state itself. If the user will see it more
than a few times a session, make it shorter than feels right; motion that delights on
first view irritates by the tenth.

## Curves

| Curve | Use |
| --- | --- |
| `ease-out`: `cubic-bezier(0.16, 1, 0.3, 1)` | Default for **entrances**. Mirrors how real objects settle: fast in, gentle stop |
| `ease-in`: `cubic-bezier(0.4, 0, 1, 1)` | **Exits**, where the element accelerates away |
| `ease-in-out`: `cubic-bezier(0.4, 0, 0.2, 1)` | Movement between two on-screen positions |
| **Spring**, mild overshoot | Press feedback, sheets, drag release, playful confirmations |
| `linear` | Only continuous motion: spinners, marquees, progress fills |

Shape decides feel more than distance does: same travel, same duration, different curve,
completely different product. `linear` on a start-stop element is the fastest way to look
cheap. Springs read as premium when the overshoot is subtle; over-tuned stiffness reads
as a malfunction, not personality.

Use the same curve for the same class of interaction everywhere. Three different card
hovers in one product is the animation equivalent of three type scales.

## Timings

From `design-foundations`: tap <100ms, entrance 200–300ms, exit ~150ms (≈40% faster;
symmetric timing feels like the UI is reluctant to let go), attention 500–800ms, list
stagger 50ms per item (30ms blurs together, 100ms drags).

Scale duration with distance and size a little: a full-screen sheet may take 350ms where
a dropdown takes 200ms, but never past ~400ms for anything the user is waiting on.

## Build it cheaply

- Animate `transform` and `opacity` only. `width`, `height`, `top`, and `margin` trigger layout on every frame.
- `will-change` sparingly and temporarily; a permanent one wastes memory on every layer.
- Prefer CSS for one-shot transitions, the Web Animations API when JS needs to interrupt or reverse, and a spring library only when interactions must be physically interruptible (drag, sheets).
- Interruptible is the standard: a hover-out mid-animation reverses from the current position, it does not queue or snap.
- Test on a mid-tier Android at 4× CPU throttle. 60fps on your laptop proves nothing.

## Specific transitions

**Accordion / disclosure.** The height-auto problem: animate `grid-template-rows: 0fr → 1fr`
on a wrapper (or `interpolate-size: allow-keywords` where supported), 250ms ease-out, with
the content fading slightly behind the height so text does not squash. Rotate the chevron
on the **same timeline** — a chevron even a few frames out of step with the panel reads as
broken. Never animate `max-height` to a guessed value; it makes short panels snap and long
panels stall.

Single-open (one closes as another opens) suits sequential or exclusive content; multi-open
suits FAQs and reference lists where people compare answers. When an item near the bottom
of the viewport expands, keep its header pinned in place rather than letting the page jump
out from under the tap. The header is a `<button>` with `aria-expanded` and `aria-controls`.

**Page and route transitions.** Use the View Transitions API where available. Keep them
under 300ms, do not block interaction during them, and skip them on Back/Forward where
users expect instantaneous restoration.

**Shared element.** When an item expands into a detail view, move the *same* element rather
than cross-fading two; that is the whole payoff of continuity. Match the ending geometry
exactly or the snap at the end undoes the effect.

**Layout shifts.** When items reorder, filter, or delete, animate the survivors to their new
positions (FLIP). Items disappearing without their neighbours moving reads as a bug.

**Number changes.** Count up over ~400ms for meaningful metrics; never animate numbers users
must read continuously.

## Scroll-driven motion

Native CSS handles this now: `animation-timeline: scroll()` for progress tied to the
scroller, `view()` for per-element entry, and `animation-range` to set exactly when it
fires. Pair with `position: sticky` for shrinking headers and reading-progress bars, and
layer two timelines at different rates for parallax. Skip the scroll listener with
`getBoundingClientRect()` and skip the animation library for effects the browser does in
two declarations off the main thread.

Rules: entry animations play **once**, never on every re-entry. Never hijack the scroll
speed itself. Never make content readable only after an animation completes; if JS or
motion fails, the text must still be there.

## Reduced motion

```css
@media (prefers-reduced-motion: reduce) {
  *, ::before, ::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

Treat that as the floor, not the design. Better: keep a short opacity fade, drop movement,
parallax, and auto-playing loops. The state change must still happen; reduced motion means
less movement, not less information. Vestibular triggers are large-area movement, parallax,
zoom, and spin, so those are the first to go.

Also: nothing flashes more than 3 times per second, and any looping animation over 5
seconds needs a pause control.

## Checklist

- [ ] Every animation serves causality, continuity, status, or hierarchy.
- [ ] Ease-out in, faster ease-in out; `linear` only for continuous motion.
- [ ] One curve per interaction class across the product.
- [ ] `transform`/`opacity` only; 60fps on a throttled mid-tier device.
- [ ] Animations interruptible and reversible from their current position.
- [ ] Accordions animate via `grid-template-rows`, not guessed `max-height`.
- [ ] Scroll effects are CSS-native, fire once, and never gate content.
- [ ] `prefers-reduced-motion` keeps the state change and drops the movement.

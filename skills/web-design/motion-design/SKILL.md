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

Frequency decides the budget before taste does:

| How often the user sees it | Budget |
| --- | --- |
| 100+ times a day: keyboard shortcuts, command palette, core navigation | None. Ever. |
| Tens of times a day: hover states, list navigation, frequent toggles | Near-imperceptible, or nothing |
| Occasional: modals, drawers, toasts, settings | Standard animation |
| Rare or first-run: onboarding, empty states, success, celebration | Where the delight budget lives |

**Keyboard-initiated actions are a disqualifier, not a judgment call.** A command palette
that animates open feels slow and disconnected by the twentieth invocation, and the best
ones do not animate at all. The same goes for decoration on data someone is reading or
acting on: a chart in a banking app is better still.

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

Timing can be asymmetric on purpose: slow where the user is deciding, fast where the system
responds. A hold-to-confirm fill takes two deliberate seconds on press and snaps back in
200ms on release.

## Physicality

Motion sells weight, and a handful of details are what separate credible from cheap.

- **Never animate from `scale(0)`.** Start at `scale(0.9)` to `scale(0.97)` with `opacity: 0`. Nothing in the physical world appears out of nothing, and the eye reads the difference immediately.
- **Popovers and menus scale from their trigger**, not from their own center. Set `transform-origin` to the trigger edge. Modals are the exception: they belong to the viewport, so they stay centered.
- **Press feedback is `scale(0.96)` to `scale(0.98)`** over 100 to 160ms on `:active`. Below 0.95 it reads as exaggerated. It applies to anything pressable, not just buttons.
- **`translate` percentages are relative to the element's own size**, so `translateY(100%)` moves a toast exactly its own height whatever that turns out to be. Prefer them to hardcoded pixels.
- **`scale()` scales children too**, including text and icons. That is a feature for press feedback and a problem everywhere else.
- **Mask an imperfect crossfade with a small blur.** When two states overlap visibly however the easing is tuned, `filter: blur(2px)` during the transition blends them into one perceived change. Keep it well under 20px; heavy blur is expensive, especially in Safari.

## Build it cheaply

- Animate `transform` and `opacity` only. `width`, `height`, `top`, and `margin` trigger layout on every frame.
- **Name the properties you transition.** `transition: all` fires on every property that happens to change, including ones added later, and is the most common cause of a smeared or surprising transition.
- `will-change` sparingly and temporarily, only for `transform`, `opacity`, and `filter`. Add it when you see first-frame stutter, not in advance; a permanent one wastes memory on every layer.
- **CSS transitions are interruptible and retarget from their current position. Keyframes restart from zero.** For anything triggered rapidly (toasts arriving, toggles, hover in and out), use transitions. Reserve keyframes for staged sequences that run once.
- `@starting-style` gives an entry animation with no JS and no mount flag, so an element added to the DOM transitions in rather than appearing.
- Prefer CSS for predetermined motion, the Web Animations API when JS needs to interrupt or reverse with CSS-level performance, and a spring library only when interactions must be physically interruptible (drag, sheets).
- **Do not drive child transforms from a CSS variable on the parent.** Updating it recalculates style for every child. Set `transform` on the element that moves.
- In motion libraries, shorthand transform props are often animated on the main thread rather than composited. Check what the library actually emits before trusting it under load.
- Test on a mid-tier Android at 4× CPU throttle. 60fps on your laptop proves nothing.

## Gestures

A drag that snaps to the nearest position is the tell that no one tuned it.

- **Dismiss on velocity, not distance.** A fast flick should dismiss even if it never crossed the threshold. Compare distance over elapsed time against a small constant rather than testing position alone.
- **Damp at the boundaries.** Dragging past a natural edge moves progressively less, then springs back. Real things slow before they stop; an invisible wall reads as a bug.
- **Capture the pointer once the drag begins**, so it keeps tracking when the pointer leaves the element's bounds.
- **Ignore additional touch points** after a drag starts, or a second finger makes the element jump.
- **Hand velocity off into the release animation.** A spring carries momentum through the handoff; a fixed-duration tween restarts from zero and the gesture visibly dies at the moment the finger lifts.

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
must read continuously. Use tabular figures or the digits jitter as they roll; see
`typography-design`.

**Theme switch.** Flipping light to dark changes color, background, border, and shadow on
almost every element at once, so every transition on those properties fires together and
the switch smears instead of snapping. Inject `transition: none !important` globally, force
a reflow, then remove it on the next frame.

**Icon swaps.** Cross-fade with `opacity`, `scale`, and a small `blur` rather than toggling
visibility, keeping both icons in the DOM with one absolutely positioned. Toggled
visibility has no exit, so the outgoing icon vanishes a frame before the new one arrives.

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

## Judging feel

Feel cannot be read off the code, so slow it down and look.

- **Replay at 10% speed**, or multiply the duration by five. What is subtly wrong at full speed is obvious at a tenth: a color crossfading through gray, easing that stops rather than settles, a `transform-origin` in the wrong corner, two coordinated properties drifting apart.
- **Step frame by frame** in the browser's animations panel to catch timing drift between properties that should be on one timeline.
- **Test gestures on a real device.** A trackpad drag is not a thumb drag, and no simulator reproduces momentum.
- **Look again the next day.** Imperfections invisible while building surface with fresh eyes.

Motion also never carries information alone: every animated state change needs a static cue
in color, an icon, or a label, or the state is invisible once the animation finishes.

## Checklist

- [ ] Frequency checked before anything else; nothing animates on a 100-times-a-day path.
- [ ] Every animation serves causality, continuity, status, or hierarchy.
- [ ] Ease-out in, faster ease-in out; `linear` only for continuous motion.
- [ ] One curve per interaction class across the product.
- [ ] `transform`/`opacity` only, named explicitly; no `transition: all`; 60fps on a throttled mid-tier device.
- [ ] Nothing animates from `scale(0)`; popovers scale from their trigger.
- [ ] Animations interruptible and reversible from their current position.
- [ ] Gestures dismiss on velocity, damp at boundaries, and hand momentum to the release.
- [ ] Accordions animate via `grid-template-rows`, not guessed `max-height`.
- [ ] Scroll effects are CSS-native, fire once, and never gate content.
- [ ] `prefers-reduced-motion` keeps the state change and drops the movement.

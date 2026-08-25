---
name: motion-design
description: Design or fix UI animation. Use when adding transitions, easing, springs, page or shared-element transitions, scroll-driven or parallax effects, accordion and disclosure animation, list staggers, hover and press feedback, drag and swipe gestures, loading motion, or when an interface feels janky, twitchy, sluggish, or busy.
---

# Motion Design

`design-foundations` holds the duration table. This skill decides **whether** to animate,
which curve, and how to build the harder transitions.

## Whether to animate

Motion has four jobs: **causality** (this came from that), **continuity** (same object, new
position), **status** (something is happening), **hierarchy** (look here first). Anything
else is decoration, and decoration on a control used forty times a day is friction.

Animate state *changes*, never state itself. Frequency sets the budget before taste does:

| Seen how often | Budget |
| --- | --- |
| 100+/day: shortcuts, command palette, core navigation | None. Ever. |
| Tens/day: hover, list navigation, frequent toggles | Near-imperceptible, or nothing |
| Occasional: modals, drawers, toasts, settings | Standard animation |
| Rare or first-run: onboarding, empty states, success | Where the delight budget lives |

**Keyboard-initiated actions are a disqualifier, not a judgment call**: a command palette
that animates open feels slow by the twentieth invocation. Same for decoration on data
someone is reading or acting on.

## Curves and timing

| Curve | Use |
| --- | --- |
| `ease-out` `cubic-bezier(0.16, 1, 0.3, 1)` | Default for **entrances**: fast in, gentle stop |
| `ease-in` `cubic-bezier(0.4, 0, 1, 1)` | **Exits**, accelerating away |
| `ease-in-out` `cubic-bezier(0.4, 0, 0.2, 1)` | Movement between two on-screen positions |
| Spring, mild overshoot | Press feedback, sheets, drag release |
| `linear` | Continuous motion only: spinners, marquees, progress |

Shape decides feel more than distance does. `linear` on a start-stop element is the fastest
way to look cheap; over-tuned spring stiffness reads as malfunction, not personality. Use
one curve per class of interaction across the product.

From `design-foundations`: tap <100ms, entrance 200–300ms, exit ~150ms (~40% faster, since
symmetric timing feels reluctant), attention 500–800ms, stagger 50ms per item. Scale a
little with distance (a full-screen sheet 350ms against a dropdown's 200ms) but never past
~400ms for anything the user waits on. Asymmetry is a tool: slow where the user decides,
fast where the system responds, so a hold-to-confirm fills over two seconds and snaps back
in 200ms.

## Physicality

- **Never animate from `scale(0)`.** Start at `0.9`–`0.97` with `opacity: 0`. Nothing appears out of nothing, and the eye reads the difference.
- **Popovers scale from their trigger**, not their own center: set `transform-origin` to the trigger edge. Modals are the exception; they belong to the viewport and stay centered.
- **Press feedback is `scale(0.96)`–`scale(0.98)`** over 100–160ms on `:active`, on anything pressable. Below `0.95` reads as exaggerated.
- **`translate` percentages are relative to the element's own size**, so `translateY(100%)` moves a toast exactly its own height. Prefer them to hardcoded pixels.
- **`scale()` scales children too**, including text and icons: a feature for press feedback, a problem elsewhere.
- **Mask an imperfect crossfade with `filter: blur(2px)`** during the transition, well under 20px since heavy blur is expensive in Safari.

## Build it cheaply

- Animate `transform` and `opacity` only; `width`, `height`, `top`, `margin` trigger layout every frame.
- **Name the properties you transition.** `transition: all` fires on everything that happens to change, including properties added later.
- **CSS transitions interrupt and retarget from their current position; keyframes restart from zero.** For anything rapidly triggered (toasts arriving, toggles, hover in and out) use transitions. Reserve keyframes for staged one-shot sequences.
- `@starting-style` gives entry animation with no JS and no mount flag.
- CSS for predetermined motion, the Web Animations API when JS must interrupt or reverse, a spring library only when interactions must be physically interruptible.
- **Do not drive child transforms from a CSS variable on the parent**; it recalculates style for every child. Set `transform` on the element that moves.
- Motion-library shorthand transform props are often main-thread rather than composited. Check what the library emits before trusting it under load.
- `will-change` sparingly, only for `transform`, `opacity`, `filter`, and only once you see first-frame stutter.
- Test on a mid-tier Android at 4x CPU throttle. 60fps on your laptop proves nothing.

## Gestures

A drag that snaps to the nearest position is the tell that nobody tuned it.

- **Dismiss on velocity, not distance**: a fast flick should dismiss without crossing the threshold. Compare distance over elapsed time, not position alone.
- **Damp at boundaries.** Past a natural edge, movement decreases and then springs back. An invisible wall reads as a bug.
- **Capture the pointer** once dragging starts, so it keeps tracking outside the element's bounds, and **ignore extra touch points** or a second finger makes it jump.
- **Hand velocity into the release animation.** A spring carries momentum through; a fixed-duration tween restarts from zero and the gesture dies as the finger lifts.

## Specific transitions

**Accordion.** Animate `grid-template-rows: 0fr → 1fr` on a wrapper (or `interpolate-size:
allow-keywords`), 250ms ease-out, content fading slightly behind the height so text does not
squash. Rotate the chevron on the **same timeline**. Never animate `max-height` to a guessed
value: short panels snap, long ones stall. Single-open suits exclusive content, multi-open
suits FAQs. When an item near the viewport bottom expands, keep its header pinned. The
header is a `<button>` with `aria-expanded` and `aria-controls`.

**Page and route.** View Transitions API where available, under 300ms, never blocking
interaction, skipped on Back/Forward where users expect instant restoration.

**Shared element.** Move the *same* element rather than cross-fading two, and match the
ending geometry exactly or the snap undoes the effect.

**Layout shifts.** When items reorder, filter, or delete, animate survivors to their new
positions (FLIP). Items vanishing without neighbours moving reads as a bug.

**Numbers.** Count up over ~400ms for meaningful metrics, never for numbers read
continuously, always with tabular figures (`typography-design`) or the digits jitter.

**Theme switch.** A light/dark flip changes color, background, border, and shadow at once,
so every transition fires together and the switch smears. Inject `transition: none
!important`, force a reflow, remove it next frame.

**Icon swaps.** Cross-fade `opacity`, `scale`, and a small `blur` with both icons in the DOM,
one absolutely positioned. Toggled visibility has no exit.

## Scroll-driven motion

Native CSS handles this: `animation-timeline: scroll()` for scroller progress, `view()` for
per-element entry, `animation-range` for exactly when it fires. Pair with `position: sticky`
for shrinking headers and progress bars; layer two timelines at different rates for
parallax. Skip the scroll listener and the animation library for what the browser does in
two declarations off the main thread.

Entry animations play **once**, never on re-entry. Never hijack scroll speed. Never make
content readable only after an animation completes: if JS or motion fails, the text is
still there.

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

That is the floor, not the design. Better: keep a short opacity fade and drop movement,
parallax, and auto-playing loops. The state change must still happen; reduced motion means
less movement, not less information. Vestibular triggers go first: large-area movement,
parallax, zoom, spin. Nothing flashes more than three times per second, and any loop over
five seconds needs a pause control.

Motion never carries information alone. Every animated state change needs a static cue in
color, icon, or label, or the state is invisible once the animation ends.

## Judging feel

Feel cannot be read off code. **Replay at 10% speed** or multiply duration by five: what is
subtly wrong at full speed is obvious at a tenth, including colors crossfading through gray,
easing that stops rather than settles, a wrong `transform-origin`, and coordinated properties
drifting apart. Step frame by frame in the animations panel for timing drift. Test gestures
on a real device, since no simulator reproduces momentum. Look again the next day.

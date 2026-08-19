---
name: tab-design
description: Build or review tabbed interfaces. Use when creating tabs, a tab bar, segmented control, or pill switcher, when tab content jumps or the active indicator teleports, when tabs overflow or wrap, or when deciding between tabs, accordions, and separate pages.
---

# Tab Design

Assumes `design-foundations` for tokens, motion, and focus rules.

Tabs are a system: trigger row, active indicator, panels, overflow behavior, and URL
state. Shipping only the trigger row is why tabs feel cheap.

## Use tabs only when they fit

- Sibling views of **equal weight** on one subject, 2–7 of them, that the user compares or switches between.
- **Not** for a sequence; that is a stepper. **Not** for content users need side by side. **Not** for deep-linked destinations with their own sub-navigation; those are routes.
- If content per tab is short and users want several open, use an accordion instead.
- Labels are 1–2 words, nouns, parallel in form, never truncated. If a label needs truncation, the label is wrong.

## Visual rules

- Exactly one active tab, and it must be unmistakable: the difference between active and idle should survive a grayscale screenshot.
- **The focus ring and the active state never share a color.** Otherwise keyboard users cannot tell where focus is versus what is selected.
- Idle tabs stay legible: `text-muted` at ≥4.5:1, not a 40%-opacity ghost.
- Counts and badges belong after the label, in a muted pill, and must not resize the tab when the number changes; reserve the width.
- Segmented control (a filled thumb inside a track) for ≤4 short, mutually exclusive options; an underline bar for content sections.

## Motion

- **The active indicator slides, it never teleports.** Animate it between tabs with a spring or `cubic-bezier(0.16, 1, 0.3, 1)` at 200–300ms, and match its timing to the panel transition.
- Panel change is a crossfade, not a hard cut: fade out ~120ms → ~80ms hold → fade in ~180ms, with a few pixels of directional slide matching the travel direction.
- Keep panel height stable, or animate the height change. A tab switch that shoves the page is the most common tab defect.
- Under `prefers-reduced-motion`, cut the slide and keep a short fade.

## Overflow

**Never wrap the tab row to a second line**: the active indicator's geometry breaks and
the row becomes a paragraph.

- Scroll horizontally in a single row with a fade mask on the overflowing edges.
- Add chevron buttons on pointer devices; scroll the active tab into view on mount and on change.
- Past ~7 tabs, reconsider: a dropdown, a sidebar, or nested routes usually fits better.

## Responsive

Do not shrink the desktop bar. Switch components by count and device:

- ≤4 tabs on mobile → full-width segmented control.
- 5+ on mobile → scrollable pill row, or a bottom sheet picker when labels are long.
- Primary app navigation on mobile is a bottom bar (max 5, icon + label); on desktop it is a sidebar.
- Support swipe between panels on touch **only** if panels are not horizontally scrollable themselves.

## State and data

- Reflect the active tab in the URL (`?tab=billing`) so it is linkable, refresh-safe, and Back-navigable.
- Preserve each panel's scroll position and form state across switches.
- Load panel data lazily on first activation, then cache. Show a skeleton shaped like that panel; never collapse to a spinner in an empty box.
- Prefetch the adjacent tab's data on hover or focus when it is cheap.

## Accessibility (ARIA APG)

```html
<div role="tablist" aria-label="Account settings">
  <button role="tab" id="tab-profile" aria-selected="true"
          aria-controls="panel-profile" tabindex="0">Profile</button>
  <button role="tab" id="tab-billing" aria-selected="false"
          aria-controls="panel-billing" tabindex="-1">Billing</button>
</div>
<div role="tabpanel" id="panel-profile" aria-labelledby="tab-profile" tabindex="0">…</div>
```

- **Roving tabindex**: the active tab is `0`, the rest `-1`, so Tab enters the row once and moves on to the panel.
- Arrow Left/Right (Up/Down when `aria-orientation="vertical"`) move between tabs and wrap; Home/End jump to first/last.
- Automatic activation (select on arrow) is fine when panels are cheap; use manual activation with Enter/Space when a panel triggers a fetch.
- Panel gets `tabindex="0"` only when it holds no focusable child.
- Closable tabs handle Delete and move focus to the neighbor.

## Checklist

- [ ] Indicator slides, timed with the panel crossfade; panel height does not jump.
- [ ] Row scrolls instead of wrapping; active tab auto-scrolled into view.
- [ ] Focus ring visually distinct from the active state.
- [ ] Arrow/Home/End keys work with roving tabindex; ARIA wired both ways.
- [ ] Active tab in the URL; panel scroll and form state survive switching.

---
name: overlay-design
description: Choose and coordinate layered UI. Use when deciding between inline disclosure, a popover, a drawer, a bottom sheet, and a modal, when overlays are stacking or conflicting, or when handling scrims, focus return, Escape order, scroll locking, and the z-index scale across the whole product.
---

# Overlay Design

Assumes `design-foundations` for tokens and motion. This skill picks the surface and owns
what is true of every overlay; each surface owns its own anatomy and keyboard contract:
`modal-dialog`, `drawer-and-sheet`, `popover-and-menu`, `tooltip`, `command-palette`.

## Pick the lightest surface that works

Start with one question: **does this need to block the user?** Almost always, no.

| Surface | Use for | Weight |
| --- | --- | --- |
| **Inline / expand in place** | Editing, disclosure, anything with surrounding context | None: the default, and the one people skip |
| **Popover / menu** (~200-320px, anchored to its trigger) | Quick choices, overflow actions, pickers | Dismiss on outside click; no scrim |
| **Drawer / side panel** | Details, secondary navigation, filters on desktop | Dims only what it covers; app stays alive behind |
| **Bottom sheet** (mobile) | Contextual actions and pickers within thumb reach | Drag handle, snap points, background partly visible |
| **Modal dialog** | Blocking, destructive, or irreversible decisions only | Full scrim, full attention |

Rules of thumb: a modal for a routine action is a punishment; navigation never goes inside a
blocking overlay; a hint is never an overlay you can click. **Never stack a modal on a
modal** - replace the content or step down to a drawer.

## True of every overlay

- **Escape closes**, innermost first, and returns focus to the trigger. Skipping the focus return is the single most common overlay defect.
- Nothing auto-dismisses on a timer, and nothing closes on scroll - except an anchored popover whose trigger scrolled away.
- Opening measures first: flip and shift to stay inside the viewport rather than clipping or overflowing the page.
- The trigger keeps `aria-expanded` and an active state while its surface is open.
- Content behind a blocking overlay is `inert`; content behind a non-blocking one is not, and must stay fully usable.
- Lock background scroll only for blocking surfaces, and compensate for the scrollbar width so the page does not jump.
- Unsaved input asks before it is discarded, in every surface that can hold a form.

## Motion

Entrance 200-300ms `ease-out`, exit ~150ms. Modals fade and scale from `0.96`; sheets and
drawers slide from the edge; popovers scale from the trigger's corner so the connection is
obvious. Under `prefers-reduced-motion`, fade only (`motion-design`).

## Stacking

Use a token scale: `dropdown 1000 / sticky 1100 / drawer 1200 / modal 1300 / popover 1400 /
toast 1500`. Never write an ad-hoc `z-index: 9999`; an escalating number is a symptom of a
stacking context upstream, not a fix.

`z-index` applies only to positioned elements (`static` ignores it entirely), and a parent's
`transform`, `filter`, or `opacity` creates a stacking context that traps children no matter
how high their value. Diagnose in the DevTools layers view rather than by incrementing. Use
`isolation: isolate` to deliberately contain a subtree, portal to the body when an overlay
must genuinely escape, and prefer the top layer (native `<dialog>`, the popover API), which
sidesteps the scale entirely.

## Coordination

- One blocking surface at a time. Opening a modal closes open menus and tooltips first.
- A toast must never appear under a scrim where it cannot be read (`toast`); announce results inside the overlay that produced them.
- Keyboard shortcuts scoped to a surface stop working when it closes, and global shortcuts are suppressed while a modal is open.
- Route-backed overlays (a record drawer, a settings modal) belong in the URL so they survive refresh and Back closes them (`navigation-design`).

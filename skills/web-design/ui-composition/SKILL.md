---
name: ui-composition
description: Shape, build, or review a page, screen, or flow as one coherent interface. Use for full-page or multi-component UI work, especially when deciding user intent, information hierarchy, existing-component reuse, component integration, state coverage, or responsive composition. For focused work on one established component, use its component skill directly.
---

# UI Composition

Think through the interface before rendering it. The unit of design is the user's task, not
the database schema and not a collection of individually polished controls.

Always load `design-foundations`. Load `visual-direction` when the visual system is missing,
unclear, new, or supplied through a reference. Select only the surface and component skills
that materially affect this screen; their detailed contracts remain authoritative.

## Discover the system already present

Inspect the repository before proposing UI:

- Identify the framework, routes, styling entry points, theme files, tokens, and responsive
  conventions.
- Find the shared component library and the most reused comparable screen. Record which
  primitives already cover the task, their variants, and their state APIs.
- Treat existing code as the system of record. Extend a real component when the system has
  a genuine gap; do not create a parallel button, input, card, overlay, token scale, or
  interaction convention inside one screen.
- Preserve product behavior and content unless the request authorizes changing them. A
  visual restyle does not silently rewrite flows or information architecture.

When no system exists, define the minimum tokens and primitives this screen needs through
`design-foundations` and `visual-direction`, then reuse them throughout the work.

## Lock the intent

Before choosing layout, establish:

- who uses the screen and the job they came to complete;
- the single outcome that makes the screen successful;
- the most frequent path and the worst costly or irreversible mistake;
- the information needed to decide, and what can wait until later;
- device, density, accessibility, content, and technical constraints.

Use supplied context immediately. Ask only about a missing answer that would materially
change the interface; otherwise state a reasonable assumption and continue. Summarize the
result as a short design brief so implementation decisions can be checked against it.

## Build the hierarchy

- Rank actions as primary, secondary, tertiary, or destructive. One screen has one primary
  action at a time.
- Order information by the user's decision path, not by service boundaries or database
  columns. Put the answer to the screen's main question in the first viewport.
- Group by task and proximity before adding containers. Vary density and space according to
  importance instead of making every region an identical card.
- Use progressive disclosure for uncommon or advanced work, while keeping required
  information and recovery paths visible.

Sketch the regions and focus order before detailed styling. For each region, name the
existing component, the relevant component skill, or the specific gap that earns an
extension. This component map is the integration contract.

## Pick the lightest surface that works

Layering is a composition decision, so make it here rather than per component. The question
is always **does this need to block the user?** Almost always, no.

| Surface | Use for | Weight |
| --- | --- | --- |
| Inline / expand in place | Editing, disclosure, anything with surrounding context | None: the default, and the one people skip |
| Popover / menu, anchored to its trigger | Quick choices, overflow actions, pickers | Dismiss on outside click; no scrim |
| Drawer / side panel | Details, secondary navigation, filters on desktop | Dims only what it covers; app stays alive behind |
| Bottom sheet (mobile) | Contextual actions and pickers within thumb reach | Drag handle, snap points, background partly visible |
| Modal dialog | Blocking, destructive, or irreversible decisions only | Full scrim, full attention |

A modal for a routine action is a punishment; navigation never goes inside a blocking
overlay; a hint is never an overlay you can click. Never stack a modal on a modal - replace
the content or step down to a drawer. Each surface owns its own contract: `modal-dialog`,
`drawer-and-sheet`, `popover-and-menu`, `tooltip`, `command-palette`.

Whatever the surface: Escape closes innermost first and focus returns to the trigger,
nothing auto-dismisses on a timer, unsaved input asks before it is discarded, and only
blocking surfaces make the background `inert` and lock its scroll.

## Specify behavior and states

For each data-bearing region, decide which of the states in `feedback-design` apply. For each
action, decide validation, busy behavior, success feedback, failure recovery, retry, undo,
and focus movement. Do not leave these as a post-build polish pass.

Resolve cross-component behavior explicitly:

- what owns state and what survives refresh, navigation, or Back;
- which feedback is inline, transient, persistent, or blocking;
- how overlays coordinate: one blocking surface at a time, opening a modal closes menus and tooltips first, global shortcuts are suppressed while it is open, a toast never appears under a scrim where it cannot be read, and route-backed overlays live in the URL so refresh and Back behave;
- how selection, filters, pagination, and bulk actions share scope;
- how the composition reflows, truncates, scrolls, and changes input behavior across
  breakpoints and pointer capabilities.

## Implement as one system

Compose existing primitives first. Add a missing variant at the shared component seam when
multiple consumers need it; keep a truly local exception local and explain why it is not a
system rule. Every value traces to the established tokens, and repeated behavior has one
owner.

Integrate incrementally: establish the page structure and real content, connect state and
actions, add responsive behavior, then refine visual craft and motion. Keep the screen usable
at each step rather than polishing disconnected components in isolation.

## Reconcile and verify

Review the assembled screen, not just its parts:

- Does the first glance reveal the intended hierarchy and primary action?
- Does every component look and behave like it belongs to the same product?
- Are all applicable states reachable, distinguishable, and recoverable?
- Does keyboard order follow visual and task order, including overlays and focus return?
- Does the composition work at narrow and wide widths, zoomed text, touch, and reduced
  motion?
- Did the work reuse the existing system, or silently invent competing primitives?

Exercise the highest-risk path and at least one failure path. Compare the result with the
design brief and remove anything that does not serve it.

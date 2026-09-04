---
name: toggle-switch
description: Build or review a toggle switch. Use when adding an on/off switch to settings, a feature flag, a preference row, or a table row, when a switch writes to the network, or when deciding between a switch, a checkbox, and a segmented control.
---

# Toggle Switch

Assumes `design-foundations` for tokens and motion. Submit-time choices are
`checkbox-and-radio`; this control is for **state that takes effect immediately**.

## When it is the right control

- The change applies the moment it is flipped, is reversible, and needs no confirmation.
- **Never put a switch in a form with a Save button.** The user cannot tell whether the switch already applied or is waiting for Save, and both readings are reasonable.
- Never use a switch for a destructive or irreversible action, or for anything that costs money on flip. Those need a button and a confirmation (`button-and-action-design`).
- Two mutually exclusive named modes are a segmented control, not a switch. A switch means on/off of one named thing.

## Anatomy

- The **label names the thing being switched**, not the state: "Email notifications", never "On" or "Enabled". State is what the control shows.
- Label on the left, switch on the right in a settings row; the whole row is the target and toggles the control.
- The thumb travels far enough to read as a position change - a rail roughly twice the thumb's width. A short rail with only a color change is unreadable in grayscale and to a colorblind user.
- Position is the primary signal, color is secondary. Add a check/cross or an inset track shadow if the palette is low-contrast.
- Optional secondary line under the label explains the consequence ("Sends a daily digest at 9am"). Keep it in the same row, not in a tooltip.

## Motion

- Animate rail color, thumb position, and any label change together over ~200-250ms with a standard ease. An instant snap loses the causality; anything slower feels laggy on a control people flip repeatedly.
- No bounce or overshoot. This is a state change, not a celebration.
- Under `prefers-reduced-motion`, the thumb still moves - position is information - but drop the easing flourish (`motion-design`).

## Network-backed switches

- Flip optimistically, then reconcile. Waiting for a round trip before moving the thumb makes the control feel broken (`feedback-design`).
- Show progress **in place** - a small spinner in or beside the switch - never a page-level loader, and keep the control interactive-looking rather than disabled.
- On failure, roll back visibly, keep the row in place, and say why inline. A switch that silently returns to its old position teaches the user the product is unreliable.
- Debounce rapid flips and send the final state; never queue three requests for three flips.
- If the effect is slow to take hold ("Applying to 2,400 devices"), say so under the label with the pending count rather than pretending it is done.

## Groups and dependencies

- A master switch that disables dependent rows must dim them *and* state the dependency ("Turn on notifications to choose channels"), keeping them readable.
- Do not nest switches more than one level. Past that, the group is really a settings section (`form-design`).
- In a table row, the switch is the only interactive element in its cell, with a per-row accessible name that includes the row's subject ("Enable Acme Corp").

## Accessibility

- Use `<input type="checkbox" role="switch">` or a real `<button role="switch">` with `aria-checked`. Space toggles; Enter should too on a button-based switch.
- The accessible name is the visible label. A switch named "On" tells a screen reader user nothing about what is on.
- Focus-visible ring on the track at ≥3:1 against the surrounding surface, in both states.
- The track and thumb need ≥3:1 against the background *and* against each other; a light gray thumb on a white track disappears in the off state.
- Announce the resulting state, not an instruction: "Email notifications, switch, on".

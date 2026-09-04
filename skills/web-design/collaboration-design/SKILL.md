---
name: collaboration-design
description: Build or review real-time collaborative UI. Use when adding presence, avatar stacks, live cursors, selections or edit locks, multiplayer canvases, concurrent editing, follow mode, or conflict feedback.
---

# Collaboration Design

Assumes `design-foundations` for color, motion, focus, and reduced motion. Collaboration
must expose who is present, what they control, and what happens when updates conflict.

## Presence and identity

- Show presence before activity with a stable avatar stack, capped at 3–5 plus `+n`. Derive each user's color from a stable ID, and pair color with a name or avatar.
- Distinguish viewing, active, idle, reconnecting, and offline states. Never imply someone is live from stale presence data.
- Protect privacy: show only identity and activity the participant expects other collaborators to see.

## Cursors and selections

- Send pointer samples at a bounded rate - roughly 10 positions per second is enough - and interpolate between those ticks so cursors render smoothly at display refresh rate. Rendering raw ticks makes every cursor stutter; transmitting every pointer event floods the channel for no visible gain.
- Label live cursors, fade idle ones, and cull off-screen updates. Reduced motion removes cursor trails and smooth following, not ownership information.
- Outline a selected object in its editor's color and name. Use an explicit lock for exclusive edits; explain who owns it and when it can be retried rather than silently dropping input.

## Concurrent work

- Prefer mergeable operations. When last-write-wins would discard meaningful work, merge, version, or surface a conflict before overwrite.
- Optimistically show cheap edits, then reconcile with server order. On rejection, restore the authoritative state, preserve the local draft, and explain what changed.
- Reconnection must replay queued edits in order or ask the user to resolve them; never claim synchronization before acknowledgement.

## Follow mode and accessibility

- Follow mode is explicit, names the person being followed, and has a persistent Stop control. Local input exits follow mode immediately.
- Announce collaborator joins, locks, and conflicts in a polite live region without narrating every cursor movement.
- Every cursor-only action needs a keyboard path; every color identity needs a text equivalent. Keep presence out of the main tab order unless it is actionable.

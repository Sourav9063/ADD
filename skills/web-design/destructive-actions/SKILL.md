---
name: destructive-actions
description: Design deletion and other irreversible actions. Use when adding delete, remove, revoke, cancel, reset, disconnect, or bulk-destroy actions, choosing between undo and a confirmation dialog, writing confirmation copy, building a danger zone, or protecting an action whose consequences cannot be reversed.
---

# Destructive Actions

Assumes `button` for the control and `feedback-design` for undo. The question this skill
answers is not "how scary should the dialog look" but **how much protection this action
actually needs**, which is a function of reversibility and blast radius.

## Choose the protection

| Reversibility | Protection |
| --- | --- |
| Fully reversible (archive, unpublish, remove from list) | **No confirmation.** Do it, show undo |
| Recoverable for a window (soft delete, trash) | Do it, show undo, and keep a permanent recovery path |
| Irreversible, small blast radius (delete one draft) | One confirmation dialog naming the object |
| Irreversible, large blast radius (delete a workspace, revoke everyone's access) | Typed confirmation of the resource name, plus a grace period where the platform allows |

**Prefer undo over confirmation.** A dialog on every delete trains people to dismiss
dialogs, so by the time one matters the habit is already formed. Reserve dialogs for what is
genuinely unrecoverable, and back every undo with a soft delete so the button is not a lie
when the request loses the race (`feedback-design`).

## Confirmation content

- **Name the consequence and the count**: "Delete 12 files?" and, in the body, what else goes with them ("Their 340 comments will also be deleted"). Never "Are you sure?", which adds a click and no information.
- The confirm button repeats the verb and the object: **Delete 12 files**, not OK, not Yes.
- The destructive button is `danger`-colored, is **not** the default focus target, and never sits where the confirm button normally sits in your other dialogs - muscle memory clicks position, not label (`modal-dialog`).
- Say what is *not* affected when that is the real question ("Your invoices stay available for export").
- For typed confirmation, ask for the resource's own name, show it beside the field, and keep the button disabled only in this one case - here the disabled state is the point (`button`).
- Do not use a countdown-then-enable button as the only friction; it delays everyone and stops no one.

## Bulk and scope

- State the exact scope in both the trigger and the confirmation: "Delete all 247 matching" is a different action from "Delete these 40 on this page", and the two must never be reachable by the same wording (`data-table-design`).
- Recompute the count at confirmation time. A count captured before a filter changed is a wrong answer presented confidently.
- Report the result per item when a bulk destroy partially fails: what was deleted, what was not, and why.
- Never let a select-all silently include rows the user cannot see.

## Placement and styling

- Put irreversible controls in a **separated, labelled danger zone** at the bottom of a settings surface, not beside routine actions.
- Keep the danger color for actual danger. Spent on sign-out, badges, and routine alerts it stops meaning anything by the time it matters (`color-systems`).
- A destructive item in a menu goes last, after a separator (`popover-and-menu`).
- Hold-to-confirm is acceptable friction only with a visible fill over ~300ms, release-to-cancel, and a keyboard-reachable alternative; it is a gesture, so it is never the only path.
- Swipe-to-delete on a row reveals the action rather than firing it, and pairs with undo (`card-and-list-design`).

## After the action

- Move focus somewhere sensible: the next item, or the list heading if the list is now empty. Focus left on a removed node strands keyboard and screen-reader users.
- Announce the outcome and the undo affordance together, politely.
- If deletion is queued rather than immediate, say when it becomes permanent ("Deleted items are purged after 30 days").
- Log who did it and expose it where the product has an audit trail; for shared resources, tell the other people affected.

---
name: alert-banner
description: Build or review alerts, banners, and callouts. Use when adding a page or section-level message about a persistent condition - expired payment, degraded service, trial ending, permission needed, maintenance window - an inline info or warning callout, or a system status bar, and when deciding between a banner, a toast, and a dialog.
---

# Alert and Banner

Assumes `feedback-design` for surface choice. A banner states a **persistent condition**:
something true about the account, the page, or the system that stays true until it is
resolved. If it stops being true in four seconds, it is a toast; if the user must decide
before continuing, it is a dialog.

## Placement by scope

| Scope | Placement |
| --- | --- |
| System-wide (outage, maintenance, plan expired) | Top of the app shell, above the header, full width |
| Page-level (this record is archived, read-only mode) | Directly under the page title, inside the content column |
| Section-level (this table's data is stale) | Immediately above the section it describes |
| Field-level | Not a banner - put it inline (`text-input`) |

Put the message where the condition lives. A page-level banner about one widget sends the
user hunting; a global bar about one record trains people to ignore the global bar.

## Anatomy

- Icon, one-line summary in bold or medium weight, optional detail line, and at most one primary action plus one secondary.
- **The action is the point.** "Payment failed" is a statement; "Payment failed - update card" is useful. Link to the exact place the condition is resolved, not to a settings index.
- Keep it to two lines at desktop width. Longer explanations go behind a "Learn more" that opens in place.
- Do not animate a banner in on load; it shifts the content the user is already reading. Reserve its space or insert it before paint.
- Never stack more than two. Beyond that, collapse to one summary with a count and a list behind it.

## Severity

Four levels, and they must be visually distinct **without color**: an icon per level, and
a shape or border treatment that survives grayscale.

- **Info**: neutral or accent. Something changed; nothing is wrong.
- **Success**: a completed condition worth persisting ("Domain verified"). Rare - most success is a toast or inline.
- **Warning**: something will break soon. Trial ending, quota near, deprecated setting.
- **Error/critical**: something is broken now. Reserve the danger color for this, or it stops meaning anything (`color-systems`).

## Dismissal and persistence

- Dismissible only when the condition is informational. A payment failure must not be dismissible; a "new feature" note must be.
- Dismissal persists per user and per condition, not per page load, and it does not suppress the condition's *next* occurrence.
- Re-appearing after dismissal is a promise broken; if the message truly must return, say why ("Still unpaid - 3 days left").
- Auto-hiding a banner defeats its purpose. It clears when the condition clears.

## Writing

Lead with the state, then the consequence, then the action: "Your card was declined. Access
ends in 5 days. Update payment method." No exclamation marks, no "Oops", no blame, and no
technical detail the user cannot act on - that goes behind a details disclosure with a
correlation ID (`microcopy`).

## Accessibility

- `role="status"` (polite) for info and success; `role="alert"` for errors that appear after load. A banner rendered with the page needs no live region at all - it is just content, and announcing it on every load is noise.
- The banner sits in the document order where it visually appears, so it is encountered by a screen reader at the same point.
- Dismiss buttons have a real name ("Dismiss trial reminder"), not a bare ×, and return focus to a sensible neighbor.
- Contrast applies to the tinted background too: text against the banner fill, and the fill distinguishable from the page.
- Never convey severity through background color alone; the icon and the wording carry it.

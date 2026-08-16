---
name: accessibility-audit
description: Verify an existing interface against WCAG rather than design a new one. Use when asked to audit, check, or fix accessibility or a11y, to run a keyboard or screen-reader pass, to resolve contrast, focus, ARIA, or axe/Lighthouse findings, or when a VPAT, WCAG 2.2 AA, or accessibility compliance question comes up.
---

# Accessibility Audit

`design-foundations` and the section skills cover design-time rules. This one is the
**verification pass** on something already built. Target: WCAG 2.2 Level AA.

## Order of work

Automated tools catch roughly a third of issues, and never the ones that matter most.
Run them first because they are cheap, then do the manual passes.

1. **Automated sweep** — axe DevTools or `@axe-core/cli`, plus Lighthouse. Log every violation with selector and rule ID.
2. **Keyboard pass** — the highest-yield 15 minutes in the audit.
3. **Structure pass** — headings, landmarks, names, semantics.
4. **Visual pass** — contrast, zoom, reflow, motion.
5. **Screen reader pass** — confirm the experience, not just the markup.
6. **Report** — issue, WCAG criterion, severity, location, fix.

## Keyboard pass (unplug the mouse)

- Tab through the entire page. Is focus **always visible**? Any invisible stop is a blocker.
- Does the order follow the visual layout? CSS reordering that desyncs from the DOM is a fail.
- Any **trap** you cannot Tab or Escape out of, outside of an intentional modal?
- Every interactive element reachable and operable with Enter/Space, arrows where the pattern requires them.
- Nothing hover-only: menus, row actions, tooltips, card overlays.
- Overlays: focus moves in, is trapped, Escape closes, focus returns to the trigger.
- Skip link is the first focusable element and actually moves focus.
- Custom widgets follow the ARIA APG keyboard contract for their pattern (tabs, menu, combobox, grid).

## Structure pass

- One `<h1>`; headings descend without skipping levels and describe the section, not the styling.
- Landmarks present and unique: `header`, `nav` (labeled when repeated), `main` (exactly one), `footer`.
- Every control has an accessible name: `<label for>`, `aria-label`, or `aria-labelledby`. Icon buttons and icon links are the usual failures.
- Images: meaningful ones have descriptive `alt`; decorative ones have `alt=""`; complex charts have a text or table equivalent.
- Lists are real lists, tables are real tables with `<caption>` and `<th scope>`, and layout tables do not exist.
- Language set on `<html lang>`; the page `<title>` is unique and describes the view.
- ARIA rules: prefer native elements; do not put a role on an element that already has it; never use `aria-hidden` on anything focusable; no `tabindex` above 0.
- Form fields: programmatically associated labels, `aria-describedby` for helper and error text, `aria-invalid` on failures, errors announced via `role="alert"`.

## Visual pass

- Contrast: **4.5:1** body text, **3:1** large text (≥24px, or ≥19px bold), **3:1** for icons, borders, focus rings, and chart strokes. The usual failures hide in muted labels, placeholders, disabled text, and nav links sitting at 1.5–2:1.
- Check both themes, and check text over images or gradients at its worst point.
- **No information by color alone** — links inside body text, required fields, status dots, chart series, validation. Around 1 in 12 people cannot rely on red-vs-green.
- Zoom to 200% and reflow at 320px wide: no horizontal scrolling, no clipped content, nothing overlapping.
- Text spacing override (line-height 1.5, letter 0.12em, word 0.16em, paragraph 2em) does not clip content.
- `prefers-reduced-motion` honored; nothing flashes more than 3 times per second; auto-playing motion over 5s can be paused.
- Touch targets ≥24×24 CSS px (WCAG 2.2 AA), 44×44 recommended, with spacing between adjacent targets.

## WCAG 2.2 additions worth checking explicitly

Focus not obscured by sticky headers or cookie bars; focus indicator area and contrast;
dragging movements have a single-pointer alternative; authentication does not require a
cognitive test (allow paste into password and OTP fields); help and redundant entry
handled consistently.

## Screen reader pass

Test the critical flows — sign in, primary create, checkout — end to end.

- VoiceOver + Safari (macOS/iOS), NVDA + Firefox or Chrome (Windows). Two engines beat one.
- Listen for: correct role and name on every stop, state changes announced (expanded, selected, invalid, busy), dynamic content announced once via the right live region politeness, route changes announced, and nothing read out that should be hidden.
- Common defect: a live region added to the DOM at the same moment as its message, so nothing is announced. The container must already exist.

## Reporting

One row per issue: **what** (with selector or screenshot), **WCAG criterion**, **severity**
(blocker = cannot complete the task, major, minor), **who it affects**, and **the concrete
fix**. Group by fix, not by page — one bad shared component usually explains dozens of
violations. Verify fixes by rerunning the specific pass that found them, not just axe.

## Checklist

- [ ] axe/Lighthouse clean, with every remaining exception justified in writing.
- [ ] Full keyboard traverse: visible focus, logical order, no traps, no hover-only.
- [ ] Headings, landmarks, names, and form associations correct.
- [ ] Contrast passes in both themes; no color-only information.
- [ ] 200% zoom and 320px reflow intact; reduced motion honored.
- [ ] Critical flows completed with a screen reader in two browser/AT pairs.
- [ ] Findings mapped to WCAG criteria with owners and fixes.

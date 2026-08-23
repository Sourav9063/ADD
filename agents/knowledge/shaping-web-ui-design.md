# Shaping Web UI Design

Where the rules in [`skills/web-design/`](../../skills/web-design/) come from. Read before
adding a skill to that group, amending a rule, or defending a claim someone disputes.

Reviewed: 2026-08-23.

## Pattern catalog

<https://www.designmotionhq.com/patterns> is the coverage checklist the group is audited
against. Its categories - interaction, forms, motion, visual, feedback, navigation, content
- map onto the skill files; a pattern with no owner is the signal to extend an existing
skill or add one. It is a catalog, not an authority: it states rules without citations, so
confirm anything load-bearing against the tiers below.

**Re-checking the catalog: skip every pattern listed under "Covered patterns" below and
review only names that are not on that list.** Each covered page was read in full, not
skimmed from its tagline, and its concrete rules were merged into the owning skill. Read
the individual page before concluding a pattern is covered - the taglines and category
names hide the numbers, thresholds, and sub-rules that are the reason to consult it.

Page URLs are `/patterns/<kebab-case-title>`, with two exceptions that 404 on the obvious
slug: Autosave is `/patterns/autosave-ux` and Von Restorff Effect is
`/patterns/von-restorff`.

## Covered patterns

All 73 patterns published as of 2026-08-23, by owning skill. Nothing here needs re-reading
unless the page itself changes.

- **design-foundations** (19): Design Tokens · Design System Kit · Shadow Elevation · Depth Layers · Border Radius · Dark Mode · Color Accessibility · Visual Hierarchy · Proximity Rule · Gestalt Laws · Von Restorff Effect · Serial Position · Grid System · Golden Ratio · Icon Design Rules · Gradient Design · Focus States · Animation Timing · Hover Trap
- **form-design** (16): Form Field States · Form Validation Timing · Settings System · Autosave · Stepper Wizard · Inline Editing · Input Masking · Date Pickers · File Upload UX · Password Field UX · OTP Input · Toggle Anatomy · Range Sliders · Star Rating · Color Picker UX · Zeigarnik Effect
- **feedback-design** (10): Loading States System · Skeleton Loading · Error States · Empty States · Toast Notifications · Notification System · Optimistic UI · Undo UX · Doherty Threshold · Peak-End Rule
- **overlay-design** (7): Modal Hierarchy · Bottom Sheets · Dropdown Design · Context Menu · Tooltip Design · Command Palette · Z-Index Mastery
- **button-and-action-design** (5): Disabled Buttons · Destructive Actions · Bulk Actions · Behind the Button · Swipe Actions
- **card-and-list-design** (3): Perfect Card · Card Hover Anatomy · Drag and Drop
- **motion-design** (3): Easing Curves · Scroll-Driven Animations · Accordion Disclosure
- **navigation-design** (2): Navigation Patterns · Pagination
- **One pattern each**: Search Experience System (`search-design`) · Landing Page Skeleton (`landing-page-design`) · Data Table (`data-table-design`) · Tabs System (`tab-design`) · Filter Chips (`filter-design`) · Charts That Lie (`chart-design`) · Microcopy (`microcopy`) · Live Cursors (`collaboration-design`)

Two of their rules were reviewed and **deliberately not adopted**: the Error States page's
"don't validate on submit" (submit must validate everything, focus the first invalid field,
and announce the count) and the Visual Hierarchy page's prescribed 800/400/300 font weights
(one product's taste, not a rule). Do not re-add either on a later pass.

## Authority order

Resolve conflicts in this order. A practitioner post never overrides a spec.

1. **Specification.** WCAG 2.2, ARIA APG, HTML/MDN. Settles keyboard contracts, roles, contrast ratios, target sizes.
2. **Published research.** NN/g, Baymard, GOV.UK service research. Settles behavioral claims and anything with a number attached.
3. **Practitioner craft.** The blogs and books below. Settles taste, defaults, and failure modes the specs do not cover.

## Sources by domain

| Domain | Source |
| --- | --- |
| Keyboard contracts, roles, widget semantics | W3C ARIA Authoring Practices Guide <https://www.w3.org/WAI/ARIA/apg/patterns/> |
| Conformance criteria, contrast, target size | WCAG 2.2 Quick Reference <https://www.w3.org/WAI/WCAG22/quickref/> |
| Correct markup per surface | W3C WAI Tutorials <https://www.w3.org/WAI/tutorials/> |
| Per-component accessible implementation | Heydon Pickering, *Inclusive Components* <https://inclusive-components.design> |
| Native-element limits and ARIA escape hatches | Scott O'Hara <https://www.scottohara.me>, Adrian Roselli <https://adrianroselli.com> |
| Component "when not to use", research-backed | GOV.UK Design System <https://design-system.service.gov.uk> |
| Forms end to end; the disabled-control argument | Adam Silver, *Form Design Patterns*; "Disabled buttons suck" <https://adamsilver.io> |
| Visual craft: spacing, hierarchy, elevation | Wathan & Schoger, *Refactoring UI*; Anthony Hobday's visual rules <https://anthonyhobday.com> |
| Behavioral principles cited by name | *Laws of UX* <https://lawsofux.com> (Doherty, Zeigarnik, Von Restorff, Peak-End, serial position) |
| Interaction micro-craft | Rauno Freiberg <https://rauno.me/craft> |
| Motion craft and feel | Emil Kowalski <https://emilkowal.ski> |
| Layout and content edge cases | Ahmad Shadeed <https://ishadeed.com>; Defensive CSS <https://defensivecss.dev> |
| Checklists across surfaces | Smashing / Vitaly Friedman, Smart Interface Design Patterns |
| Measured behavioral claims | NN/g <https://www.nngroup.com>, Baymard <https://baymard.com> |
| Cross-system component comparison | Material 3, Apple HIG, Polaris, Atlassian, Carbon, Primer, USWDS |

## Cautions

- **Numbers need a traceable origin.** Engagement, conversion, and abandonment figures circulate through this genre with the citation stripped. Trace to NN/g, Baymard, or GOV.UK before writing one into a skill; drop the number and keep the direction when the origin cannot be found.
- **Design-system docs describe one product's choices.** Read them for rationale, not as rules. Where two systems disagree, neither is authoritative.
- **Borrow the rule, not the prose.** Same constraint as `external-guidance-synthesis.md`: no copied text, no imported catalogs.
- **A pattern's absence from Design Motion HQ is not evidence it is out of scope**, and its presence is not a reason to add a skill. Ownership follows whether an agent would otherwise invent the rule from scratch.

## Skill-group conventions

- `design-foundations` is the shared baseline; section skills assume it and never restate tokens, motion scale, or the accessibility baseline.
- `accessibility-audit` verifies shipped UI; every other skill covers design time. Keep verification steps out of the section skills.
- One authoritative location per rule, cross-linked by skill name - for example range sliders live in `form-design` and `filter-design` points at them.

# Shaping Web UI Design

Where the rules in [`skills/web-design/`](../../skills/web-design/) come from. Read before
adding a skill to that group, amending a rule, or defending a claim someone disputes.

Reviewed: 2026-09-04.

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

Re-checked on 2026-09-04: its sitemap still lists exactly the 73 pattern pages below, so
the catalog has published nothing new since 2026-08-23. Check it the cheap way -
`curl -s https://www.designmotionhq.com/sitemap.xml | grep -o '/patterns/[a-z0-9-]*' | sort -u`
- rather than by reading the index page, whose category counts and rendered lists are both
unreliable.

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
- **One pattern each**: Search Experience System and Filter Chips (`search-and-filter-design`) · Landing Page Skeleton (`landing-page-design`) · Data Table (`data-table-design`) · Tabs System (`tab-design`) · Charts That Lie (`chart-design`) · Microcopy (`microcopy`) · Live Cursors (`collaboration-design`)

Two of their rules were reviewed and **deliberately not adopted**: the Error States page's
"don't validate on submit" (submit must validate everything, focus the first invalid field,
and announce the count) and the Visual Hierarchy page's prescribed 800/400/300 font weights
(one product's taste, not a rule). Do not re-add either on a later pass.

## Coverage beyond the catalog

Design Motion HQ is one catalog with one editor's blind spots, so on 2026-09-04 the group
was audited against two broader indexes: <https://uxpatterns.dev/patterns> (component-level,
by category) and <https://www.aiuxplayground.com/patterns/> (AI surfaces only). Diffing
their categories against the skill list found five surfaces with no owner, each now a skill:

| Skill | Why it earned one |
| --- | --- |
| `ai-interface-design` | The entire AI Intelligence category, plus every chatbot, agent, and cost pattern in the playground. Agents build these constantly and had no rule to consult. |
| `auth-flow-design` | `form-design` owned the fields; nothing owned the flow, the recovery paths, or WCAG 2.2 SC 3.3.8. |
| `onboarding-design` | First run was scattered across `feedback-design`, `microcopy`, and `motion-design`, and none of them carried the finding that tours lose to skipping. |
| `media-design` | Players, captions, galleries, and lightboxes sat between `frontend-performance` and `overlay-design`, owned by neither. |
| `dashboard-design` | `chart-design` had a Dashboards section that was really page-level layout. It was moved out and that skill now points at the new one. |

Both indexes are tier 3: category maps worth diffing against, not authorities. Every rule in
the five skills traces to the tiers below - WCAG 2.2 and NIST SP 800-63B for auth, WAI media
guidance for players, NN/g for chatbots, tours, and dashboards, PAIR for AI failure paths.

**Deliberately not adopted from these two:** per-component pages that restate what a skill
already owns (their Button, Checkbox, Modal, Tooltip, Pagination entries); domain-specific
flows the group has no business prescribing (checkout, shopping cart, product card); social
primitives thin enough to fall out of existing skills (like buttons, share dialogs, comment
threads - `card-and-list-design` plus `form-design`); and the playground's Design Tools and
Voice Cloning categories, which are product ideas rather than interface rules.

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
| Password rules, credential handling | NIST SP 800-63B-4 <https://pages.nist.gov/800-63-4/sp800-63b.html> |
| Password length by factor count, enumeration defenses | OWASP ASVS <https://owasp.org/www-project-application-security-verification-standard/> and the OWASP Authentication Cheat Sheet. NIST sets 8 as the floor and recommends 15; the "15 alone, 8 with MFA" split in `auth-flow-design` is OWASP's, so cite it there rather than to NIST |
| Sign-in markup, autofill and passkey tokens | web.dev sign-in and sign-up form best practices <https://web.dev/articles/sign-in-form-best-practices>; passkeys.dev |
| Captions, description, player requirements | W3C WAI media guidance <https://www.w3.org/WAI/media/av/> |
| AI product failure paths and trust | Google PAIR People + AI Guidebook <https://pair.withgoogle.com/guidebook>; Microsoft HAX Toolkit <https://www.microsoft.com/en-us/haxtoolkit/> |
| Cross-system component comparison | Material 3, Apple HIG, Polaris, Atlassian, Carbon, Primer, USWDS |

## Public skill collections

Seven were read in full on 2026-08-25. They are practitioner craft (tier 3): useful for
failure modes and defaults, never authoritative over a spec. **Do not re-read these unless
the repository itself has changed**; what was worth taking is already in the skills.

| Collection | Taken |
| --- | --- |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | The strongest source of the seven. Frequency gate for whether to animate, `scale(0)` and origin-aware popover rules, transitions-vs-keyframes interruptibility, `@starting-style`, gesture physics (velocity dismissal, boundary damping, pointer capture, multi-touch), blur to mask crossfades, slow-motion debugging. All into `motion-design`. |
| [jakubkrehel/skills](https://github.com/jakubkrehel/skills) | The other strong one. Most of `typography-design` and `color-systems` traces here, plus `responsive-design`'s adaptivity rules and `design-foundations`' surfaces section (shadow-as-border, optical alignment, image outlines). |
| [codeswithroh/tastemaker](https://github.com/codeswithroh/tastemaker) | The framing for `visual-direction`: ground in real pixels, lock the system and reuse it, vary structure not just palette, show rather than tell, variants differ on a named axis. |
| [ConardLi/garden-skills](https://github.com/ConardLi/garden-skills) | Declare the design system before writing code, confirm a rough pass early, the five-dimension critique in `visual-direction`. |
| [elayadesign/ai-design-skills](https://github.com/elayadesign/ai-design-skills) | Content realism rules into `microcopy`; landing-page intake, page-type table, message-source matching, and ship requirements into `landing-page-design`. |
| [Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills) | Broad but thin. Only the localization specifics were usable: expansion figures by language, the what-does-not-mirror list, non-Latin script rules. Into `internationalization-design`. |
| [MengTo/Skills](https://github.com/MengTo/Skills) | Least usable. Sixty style recipes and effect implementations, self-described as drafts. Only the general rules from its Awwwards skill survived, and they duplicated things already covered. |

**Deliberately not adopted**, so a later pass does not re-import them:

- **Named-brand prescriptions.** Mandated typefaces and banned ones, fixed hex lists, required icon libraries, one collection's mandatory "tagline reveal" section. One product's taste stated as a rule, and the same reason the 800/400/300 weight prescription above was declined.
- **Tooling and scripts.** Palette generators, contrast matrices, anti-slop scanners, asset fetchers. Same constraint as `external-guidance-synthesis.md`: no new dependencies, no validation frameworks.
- **Persistent memory files** for taste (`.tastemaker/style-lock.md`, cross-project profiles). The idea that a locked system is reused rather than re-derived is in `visual-direction`; the file format and precedence machinery is not.
- **Fixed animation library choices.** GSAP, Lenis, and Locomotive as defaults. `motion-design` states the constraints a library has to satisfy and leaves the choice to the project.
- **Per-skill reporting boilerplate.** Several collections end every skill with an identical severity, verification, and table format block. `accessibility-audit` and `reviewing-changes` own reporting here; repeating it in every section skill is context cost for one behavior.
- **Native mobile platform conventions.** iOS HIG against Material differences are real, but this group is web UI. Out of scope, not wrong.

## Cautions

- **Numbers need a traceable origin.** Engagement, conversion, and abandonment figures circulate through this genre with the citation stripped. Trace to NN/g, Baymard, or GOV.UK before writing one into a skill; drop the number and keep the direction when the origin cannot be found.
- **Design-system docs describe one product's choices.** Read them for rationale, not as rules. Where two systems disagree, neither is authoritative.
- **Borrow the rule, not the prose.** Same constraint as `external-guidance-synthesis.md`: no copied text, no imported catalogs.
- **A pattern's absence from Design Motion HQ is not evidence it is out of scope**, and its presence is not a reason to add a skill. Ownership follows whether an agent would otherwise invent the rule from scratch.

## Skill-group conventions

- `ui-composition` owns the full-screen workflow: discover existing tokens and components, lock user intent and risk, establish hierarchy, map regions to component owners, specify complete states, then reconcile the assembled screen. Component and surface skills remain focused references selected by that workflow.
- `design-foundations` is the shared baseline; section skills assume it and never restate tokens, motion scale, or the accessibility baseline.
- Five skills are cross-cutting rather than per-surface: `visual-direction` (which runs before the others on new work), `typography-design`, `color-systems`, `responsive-design`, and `internationalization-design`. `design-foundations` owns the token scales; these own what happens to text, color, space, and language downstream of them. Keep the seam there rather than duplicating scale definitions.
- `accessibility-audit` verifies shipped UI; every other skill covers design time. Keep verification steps out of the section skills.
- One authoritative location per rule, cross-linked by skill name. The seam is now **component versus composition**: the component skill owns the control's anatomy, states, and keyboard contract, and the surface skill owns which control to use and what surrounds it. `form-design` picks the control and owns validation timing; `text-input` owns the field. `overlay-design` picks the surface; `modal-dialog` owns the dialog. `feedback-design` picks the response; `toast`, `skeleton`, and `empty-state` own theirs. Never restate a component's rules in the surface that uses it.
- Related seams from the same pass: `chart-design` owns what is inside a chart and `dashboard-design` the page around it; `auth-flow-design` sets password policy and `password-input` renders it; `feedback-design` owns the response and `onboarding-design` treats the empty state as the first-run surface.
- **No trailing checklists.** Removed from the group on 2026-08-25, 221 lines that restated body rules. This group was the only one in the repository that ever had them; the rule now lives in `writing-agent-guidance`. Do not reintroduce them here.
- **One skill per essential component**, decided on 2026-09-04 and deliberately overriding the group's earlier "merge before adding" default. The reasoning that produced `search-and-filter-design` still holds for surfaces that serve one intent; it does not hold for components. A request to build a select should load the select's rules, not the whole of `form-design`, and the surface skills had grown into references nobody reads to the bottom of. Twenty-six components were extracted from `form-design`, `button-and-action-design`, `overlay-design`, `feedback-design`, `card-and-list-design`, and `navigation-design`, and each parent was trimmed to the composition rules it still owns.
- The extraction is only worth it if the parents stay trimmed. When a component rule shows up in a surface skill again, delete it there rather than letting the two drift; the surface's job is to say *which* component and *why*, never *how*.
- Component descriptions state only their positive, focused triggers. `ui-composition` owns the full-page and multi-component trigger in its description, preventing repeated routing prose across the catalog.
- `tab-design` stays separate from `navigation-design`, since merging would force tab work to load sidebar and pagination content it never needs.

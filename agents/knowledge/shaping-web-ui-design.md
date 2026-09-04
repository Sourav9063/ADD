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

All 73 patterns published as of 2026-08-23, by owning skill after the 2026-09-04
restructure. Nothing here needs re-reading unless the page itself changes.

- **design-foundations** (11): Design Tokens · Design System Kit · Shadow Elevation · Depth Layers · Border Radius · Visual Hierarchy · Proximity Rule · Gestalt Laws · Serial Position · Grid System · Focus States
- **form-design and its controls** (16): Form Field States · Form Validation Timing · Settings System · Autosave · Stepper Wizard · Inline Editing · Input Masking (`form-design`) · Date Pickers (`date-picker`) · File Upload UX (`file-upload`) · Password Field UX (`password-input`) · OTP Input (`otp-input`) · Toggle Anatomy (`toggle-switch`) · Range Sliders (`slider`) · Star Rating and Color Picker UX (`form-design`) · Zeigarnik Effect (`onboarding-design`)
- **feedback-design and its surfaces** (10): Loading States System and Skeleton Loading (`loading-indicators`) · Error States · Optimistic UI · Undo UX · Doherty Threshold · Peak-End Rule (`feedback-design`) · Empty States (`empty-state`) · Toast Notifications (`toast`) · Notification System (`alert-banner`)
- **Overlays** (7): Modal Hierarchy (`modal-dialog`) · Bottom Sheets (`drawer-and-sheet`) · Dropdown Design and Context Menu (`popover-and-menu`) · Tooltip Design (`tooltip`) · Command Palette (`command-palette`) · Z-Index Mastery (`design-foundations`)
- **Actions** (5): Disabled Buttons and Behind the Button (`button`) · Destructive Actions (`destructive-actions`) · Bulk Actions (`data-table-design`) · Swipe Actions (`card-and-list-design`)
- **Cards and collections** (3): Perfect Card and Card Hover Anatomy (`card`) · Drag and Drop (`drag-and-drop`)
- **motion-design** (3): Easing Curves · Scroll-Driven Animations · Accordion Disclosure (`accordion`)
- **navigation-design** (2): Navigation Patterns · Pagination
- **color-systems** (3): Dark Mode · Color Accessibility · Gradient Design
- **One pattern each**: Icon Design Rules (`icon-design`) · Golden Ratio and Von Restorff Effect (`visual-direction`) · Hover Trap (`design-foundations`) · Search Experience System and Filter Chips (`search-and-filter-design`) · Landing Page Skeleton (`landing-page-design`) · Data Table (`data-table-design`) · Tabs System (`tab-design`) · Charts That Lie (`chart-design`) · Microcopy (`microcopy`) · Live Cursors (`collaboration-design`)

**Re-verified page by page on 2026-09-04** after the component split, to confirm the
restructure had not dropped rules. All 73 were visited again and their concrete rules
matched an owning skill, except four that were re-added: the in-field success state
(`text-input`), the ~2 second skeleton cap (`loading-indicators`), the shared chevron and
panel timing curve (`accordion`), and sticky hover on touch (`design-foundations`).

Rules confirmed as **deliberate divergences**, not omissions: their radius scale
(4·8·12·16·24) against ours (`sm 6 / md 10 / lg 16`); the 1.618 spacing multiplier
(8→13→21→34→55), which their own page admits fights an 8px grid; the Perfect Card page's
`scale(1.02)` on hover, which contradicts the Card Hover Anatomy page's geometry lock, where
we follow the latter; and Von Restorff's "3× conversions", dropped for want of a traceable
origin. Small taste details left out on purpose: shadow glow tinted per industry, 3D lift
with `rotateX`, parallax layer speeds of 1x/2.5x/5x, the 30ms star-rating stagger, and card
brand detection from the leading digit in masked input.

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
| `media-design` | Players, captions, galleries, and lightboxes sat between `frontend-performance` and the overlay skills, owned by neither. |
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
- `design-foundations` is the shared baseline; section skills assume it and never restate tokens, motion scale, or the accessibility baseline. **It is kept deliberately small because it loads with every other skill in the group.** On 2026-09-04 it shed icons (to `icon-design`), gradients and dark mode (to `color-systems`), and surface and optical craft (to `visual-direction`), dropping from ~3,150 to ~1,850 tokens. Anything that only matters while styling does not belong here; the test is whether a task that never touches visual polish still needs the rule.
- Five skills are cross-cutting rather than per-surface: `visual-direction` (which runs before the others on new work), `typography-design`, `color-systems`, `responsive-design`, and `internationalization-design`. `design-foundations` owns the token scales; these own what happens to text, color, space, and language downstream of them. Keep the seam there rather than duplicating scale definitions.
- `accessibility-audit` verifies shipped UI; every other skill covers design time. Keep verification steps out of the section skills.
- One authoritative location per rule, cross-linked by skill name. The seam is now **component versus composition**: the component skill owns the control's anatomy, states, and keyboard contract, and the surface skill owns which control to use and what surrounds it. `form-design` picks the control and owns validation timing; `text-input` owns the field. `ui-composition` picks the overlay surface; `modal-dialog` owns the dialog. `feedback-design` picks the response; `loading-indicators`, `toast`, and `empty-state` own theirs. Never restate a component's rules in the surface that uses it.
- Related seams from the same pass: `chart-design` owns what is inside a chart and `dashboard-design` the page around it; `auth-flow-design` sets password policy and `password-input` renders it; `feedback-design` owns the response and `onboarding-design` treats the empty state as the first-run surface.
- **No trailing checklists.** Removed from the group on 2026-08-25, 221 lines that restated body rules. This group was the only one in the repository that ever had them; the rule now lives in `writing-agent-guidance`. Do not reintroduce them here.
- **One skill per essential component**, decided on 2026-09-04 and deliberately overriding the group's earlier "merge before adding" default. The reasoning that produced `search-and-filter-design` still holds for surfaces that serve one intent; it does not hold for components. A request to build a select should load the select's rules, not the whole of `form-design`, and the surface skills had grown into references nobody reads to the bottom of. Twenty-six components were extracted from the surface skills, and each parent was trimmed to the composition rules it still owns; two of those parents were dissolved entirely in the follow-up pass below.
- The extraction is only worth it if the parents stay trimmed. When a component rule shows up in a surface skill again, delete it there rather than letting the two drift; the surface's job is to say *which* component and *why*, never *how*.
- Routing between neighbouring skills is checked against [`web-design-trigger-evaluations.md`](web-design-trigger-evaluations.md), which records the expected skill and the near-misses for each seam. Run it after any description change in the group.
- Component descriptions state only their positive, focused triggers. `ui-composition` owns the full-page and multi-component trigger in its description, preventing repeated routing prose across the catalog.
- `tab-design` stays separate from `navigation-design`, since merging would force tab work to load sidebar and pagination content it never needs.
- **Granularity is judged by load cost, not by tidiness**, and the 2026-09-04 pass cut in both directions. Split when one file serves two builds that never co-occur: `drag-and-drop` and `destructive-actions` left `card-and-list-design` and `button-and-action-design`, and `icon-design` left the baseline. Fold when two files answer one question: `skeleton` and `progress-and-spinner` became `loading-indicators`, because choosing between them is a single decision and both restated `feedback-design`'s wait table. `button-and-action-design` and `overlay-design` were dissolved entirely once their components existed - a router that only routes is cheaper as a table inside the skill that already loads.
- `breadcrumb` folded into `navigation-design` on the same reasoning in reverse: nobody builds one without the surrounding information architecture, so it never loaded alone.
- **Repeated baseline rules in component skills are a deliberate cost.** Target size appears in ~19 files, "never color alone" in ~17, reduced-motion in ~17. Removing them would save a few hundred tokens per task and break the property that makes a component skill usable on its own. Do not "optimize" them into pointers.

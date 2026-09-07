# Skill audit and proposed improvements

Reviewed 2026-09-06. Findings describe the pre-change catalog; selected corrections are tracked in [the implementation plan](../agents/plans/skill-correctness-refinements.md).

## Assessment

The catalog fits Agent Driven Development as a whole: 5 core workflow skills, 2 review skills, 53 web-design skills, 5 supporting skills, and 1 deprecated skill. All 66 `SKILL.md` bodies were read. The active catalog's companion metadata, routing examples, distribution instructions, and shared-rule alignment were also inspected.

The core is strongest where it asks agents to inspect evidence, choose a narrow change boundary, preserve contracts, test observable behavior, and report verification honestly. The main weaknesses are contradictory instructions, project-specific templates with broad triggers, and design preferences phrased as universal engineering requirements. These can cause an agent to confidently implement the wrong behavior.

Keep the user's original skills. External standards should validate claims and inform original wording, not become copied replacement skills. A static guidance review does not establish real agent performance or certify software built with these skills.

## Changes to prioritize

### 1. Correct authentication defaults

`auth-flow-design/SKILL.md:44` mandates automatic sign-in after password reset; `password-input/SKILL.md:40` reinforces it. OWASP recommends returning through normal authentication because automatic sign-in adds session-handling risk. Distinguish authenticated password change from recovery, retain required MFA, and report session revocation only after the backend confirms it. [OWASP password recovery guidance](https://cheatsheetseries.owasp.org/cheatsheets/Forgot_Password_Cheat_Sheet.html).

`microcopy/SKILL.md:31` gives a composition-rule password example; line 35 discloses account existence in its example. Both undermine the owning authentication skill. Use neutral non-authentication examples or defer explicitly to the authentication policy.

The password reveal button combines a changing label with `aria-pressed`. Choose a stable label with pressed state, or a changing action label without pressed state. Do not automatically copy generated credentials: make copying a separate user action. Replace “Never send” with a precise rule permitting transmission only to the intended authentication endpoint over secure transport. [APG button pattern](https://www.w3.org/WAI/ARIA/apg/patterns/button/).

### 2. Correct accessibility contracts

- `drag-and-drop` says a keyboard path satisfies the single-pointer alternative. Keyboard operation and click/tap without dragging are separate requirements. Its existing Move menu can provide the latter when pointer-operable. [WCAG dragging movements](https://www.w3.org/WAI/WCAG22/Understanding/dragging-movements.html).
- `tooltip/SKILL.md:23` says to hide immediately on mouse leave, while its accessibility section requires hoverable tooltip content. Keep it open across trigger and tooltip hover, as well as trigger focus, until dismissal or both regions lose the relevant interaction. [WCAG hover/focus content](https://www.w3.org/WAI/WCAG22/Understanding/content-on-hover-or-focus.html).
- `modal-dialog/SKILL.md:52` treats `aria-hidden` as equivalent to `inert`. Hiding something from assistive technology does not prevent pointer or keyboard interaction. Require actual background inertness and focus containment. Also allow logical focus recovery when the original trigger was removed. [APG modal dialog pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/).
- `select-and-combobox/SKILL.md:60` prescribes one Home/End, Tab, and Escape behavior for different combobox variants. Preserve native text editing and document the chosen selection model; APG includes optional behaviors rather than one universal contract. [APG combobox pattern](https://www.w3.org/WAI/ARIA/apg/patterns/combobox/).
- `accessibility-audit` mixes AA requirements with stronger recommendations. Focus Appearance is AAA; inactive controls have contrast exemptions; reflow permits content requiring two-dimensional layout; target size has explicit exceptions. Keep stronger defaults, but label them correctly so audits do not report false compliance failures. [Focus Appearance](https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html), [non-text contrast](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html), [reflow](https://www.w3.org/WAI/WCAG22/Understanding/reflow.html), [target size](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html).
- `ai-interface-design/SKILL.md:74` says the transcript should not be live, then recommends `role="log"`, which is implicitly polite-live. Choose an explicit announcement strategy and verify it with a screen reader. [WAI-ARIA log role](https://www.w3.org/TR/wai-aria-1.2/#log).

### 3. Remove unsafe implementation shortcuts

`frontend-performance/SKILL.md:64` recommends `sideEffects: false` without inspecting modules. This can remove CSS or initialization code from production. Mark only verified modules as side-effect-free and preserve side-effectful imports. Its React boundary explanation should describe the import graph: server-rendered children passed into a client component do not automatically become client modules. [webpack tree shaking](https://webpack.js.org/guides/tree-shaking/), [React client boundaries](https://react.dev/reference/rsc/use-client).

`create-action/SKILL.md:75` uses `Number(rawLimit) || 50`; negative, fractional, infinite, and oversized values survive. Require finite bounded integers and distinguish missing input from invalid input. Role gates alone do not demonstrate permission to modify the particular record. Explicitly require resource and tenant authorization at the shared trusted boundary. [OWASP authorization guidance](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html).

`feedback-design` recommends automatic retries of transient network failures without restricting replay safety. A timed-out write might have committed. Refer to `engineering` for idempotency, bounded retries, and reconciliation before retrying a mutation. Debouncing a button or switch is not a server-side duplicate or ordering guarantee.

### 4. Resolve rules that disagree

| Conflict | Proposed owner and resolution |
| --- | --- |
| `communication` treats question-shaped language as read-only, even when it expresses a request | `communication` owns request intent and the read-only default for analysis, proposals, and genuine ambiguity; phrase cues are evidence, not the rule. `engineering` owns scope once action is authorized. |
| SDD says commit at task boundaries; engineering says commit when authorized | SDD should say “when committing is authorized.” Checkpoints need not be commits. |
| `visual-direction` bans initials avatars; `avatar` makes initials the normal fallback | `avatar` owns identity fallbacks. Visual direction should prohibit fabricated customer identity only. |
| `ui-composition` bans navigation in blocking overlays; command palettes and mobile navigation use modal behavior | Choose modality by interaction requirements. Permit navigation in accessible modal navigation surfaces. |
| UI composition forbids nested modals; modal skill permits an unsaved-work alert dialog | Define one scoped exception or one replacement-state pattern in the owning modal skill. |
| `motion-design` forbids keyboard animations; tabs mandate animated transitions | Motion owns performance and reduced-motion policy. Component timing is an optional default and must not delay interaction. |
| Motion forbids layout animation but prescribes accordion grid-row animation | Prefer compositor-friendly animation; allow measured layout animation where the interaction needs it. |
| Foundations snaps all values to a scale; typography uses 13px and visual direction permits optical adjustments | Reuse existing tokens; permit justified optical and content-driven values. Distinguish spacing from type scales. |
| Foundations defines component tokens but says components consume semantic tokens only | Components may consume component tokens that reference semantic tokens. |
| Icon skill bans crossfades; motion skill prescribes them for icon swaps | Let motion own the transition choice and icon design own glyph consistency. |
| Form, text input, and microcopy repeat label/error anatomy | `text-input` owns individual field anatomy; form owns group behavior; microcopy owns wording. |

### 5. Make ADD the catalog's organizing purpose

Associate every active skill with an ADD task without moving everything into the always-loaded core folder:

| ADD work | Existing skills |
| --- | --- |
| Understand and specify | `spec-driven-development`, `engineering`, `ui-composition` |
| Implement | `coding`, scoped component/action templates, web-design specialists |
| Verify and diagnose | `diagnosing-bugs`, `reviewing-changes`, `accessibility-audit`, `frontend-performance` |
| Retain lessons | `project-memory`, `writing-agent-guidance` |
| Explain and hand off | `communication`, `unslop`, `microcopy` for product strings |

Document this mapping once in the human catalog. Give each skill precise triggers, prerequisites, a decision procedure, and a proportionate verification action. Do not repeat the whole ADD workflow in 65 active skills.

Keep project-specific templates available as opt-in profiles. `create-component` explicitly assumes mapsense; `create-action` assumes custom helpers absent from a generic project. Rename or scope them accordingly. Rename `create-component-agnostic` to reflect that it still targets Next.js and clarify App Router versus other rendering models.

### 6. Add the missing lifecycle coverage selectively

Existing skills cover implementation more fully than release and production feedback. Extend `engineering` with a short conditional rule: for production-affecting work, identify rollout, recovery, observability, and post-release success checks; for dependencies, consider ongoing vulnerability response as well as admission checks. NIST SSDF covers preparation, protection, secure production, and vulnerability response across the lifecycle. This is a useful gap check, not a reason to impose a compliance process on every edit. [NIST SSDF](https://csrc.nist.gov/projects/ssdf).

Add an ownership pointer for AI application security: untrusted model output, rendered HTML/Markdown and links, tool permissions, and approval scope. `engineering` owns trust boundaries, `coding` owns safe handling, and `ai-interface-design` owns what the user sees. Avoid treating a model's decision or a frontend confirmation as authorization enforcement.

Do not add more broad skills yet. Testing, security, architecture, and reliability already have owners; strengthen them before creating competing instructions.

## Per-skill review

“Refine” means the role fits ADD but wording, applicability, or verification needs improvement. These are proposals, not claims that every existing rule is wrong. Priority corrections above explain the highest-impact evidence.

### Core workflow: 5

| Skill | Verdict and proposed change |
| --- | --- |
| [coding](../skills/agent-driven-development/coding/SKILL.md) | Refine. Retain behavior tests, boundary parsing, cleanup, cancellation, and YAGNI. Soften boolean-parameter, three-parameter, third-duplication, and mocking rules into context-dependent heuristics. Distinguish test types: controlled integration tests can use real services. Avoid requiring a wrapper solely to mock it. |
| [communication](../skills/agent-driven-development/communication/SKILL.md) | Refine. Make terse grammar an explicit preference instead of a universal session mode. Keep request intent and the read-only default here; distinguish “can you fix” from analysis and proposal cues, and defer scope after authorization to `engineering`. |
| [engineering](../skills/agent-driven-development/engineering/SKILL.md) | Retain and extend narrowly. Add conditional rollout and production verification; clarify safe replay. Make untrusted-source handling cover all embedded instructions, not only directives leading to destructive or external actions. |
| [project-memory](../skills/agent-driven-development/project-memory/SKILL.md) | Refine. Scope each stored rule and retain its evidence when rediscovery is costly. Do not merge by “strictest” if that changes the original applicability. Compress without silently broadening policy. |
| [spec-driven-development](../skills/agent-driven-development/spec-driven-development/SKILL.md) | Refine. Tie acceptance criteria to checks, qualify commit authority, and distinguish intended behavior from current buggy executable behavior. Add meaningful-boundary wording to the trigger so file count alone does not cause planning overhead. |

### Review: 2

| Skill | Verdict and proposed change |
| --- | --- |
| [diagnosing-bugs](../skills/agent-driven-review/diagnosing-bugs/SKILL.md) | Retain. Make minimization conditional: flaky, production, and destructive symptoms may require preserved evidence or a sandbox instead of repeated reproduction. Keep investigation separate from authorization to change behavior. |
| [reviewing-changes](../skills/agent-driven-review/reviewing-changes/SKILL.md) | Refine. Keep separate specification and repository-standard findings. For PR reviews, explain when merge-base comparison reflects the proposed contribution. Base severity on impact and evidence, not “any security issue is blocking.” Reference engineering/coding instead of duplicating their full checklists. |

### Supporting and deprecated: 6

| Skill | Verdict and proposed change |
| --- | --- |
| [create-action](../skills/misc/create-action/SKILL.md) | Scope and correct. Verify framework/helpers before using the template; fix pagination parsing; require resource authorization. Keep business errors independent of HTTP where services have non-HTTP consumers. Do not force all local types into one shared file or every feature into three layers. |
| [create-component](../skills/misc/create-component/SKILL.md) | Scope to mapsense. Its aliases, hook factories, paths, and internal ID convention are project rules. Verify them before generating imports. Prefer existing primitives and add the same focused verification requirement as the generic version. |
| [create-component-agnostic](../skills/misc/create-component-agnostic/SKILL.md) | Retain as a Next.js profile with an accurate name. Check the router and rendering model before defaulting to Server Components. Reference UI composition for whole-screen work. |
| [writing-agent-guidance](../skills/misc/writing-agent-guidance/SKILL.md) | Retain. Add a distinction between normative standards, platform constraints, project decisions, and design heuristics. Source empirical claims rather than asserting universal effects on agent success. Make fresh-agent evaluation proportionate to behavioral risk. |
| [unslop](../skills/misc/unslop/SKILL.md) | Narrow to ADD documentation and handoff by default; allow broader editing explicitly. Preserve exact terminology, uncertainty, and quoted material. Remove instructions to manufacture opinions or imperfection; punctuation is not evidence of AI authorship. |
| [deprecated/caveman-short](../skills/deprecated/caveman-short/SKILL.md) | Keep outside active installation and discovery. Provide a migration pointer to `communication`; no second maintained style policy is needed. |

### Web-design foundations and composition: 10

| Skill | Verdict and proposed change |
| --- | --- |
| [ui-composition](../skills/web-design/ui-composition/SKILL.md) | Retain. Best entry point for whole-screen ADD work. Correct modality/navigation conflicts, keep intent and reuse discovery, and tie the short design brief to observed behavior checks. |
| [design-foundations](../skills/web-design/design-foundations/SKILL.md) | Refine substantially. Existing design-system values take precedence over the prescribed grid, spacing, shadows, and radii. Correct token-tier wording and accessibility distinctions. Verify CSS claims such as z-index applicability rather than teaching “positioned elements only.” |
| [visual-direction](../skills/web-design/visual-direction/SKILL.md) | Refine. Keep grounding and honest proof. Permit initials and legitimate illustration workflows. Use judgment on reference-free work instead of mandatory confirmation twice. Treat golden-ratio layouts and photo requirements as taste, not correctness. |
| [color-systems](../skills/web-design/color-systems/SKILL.md) | Refine. Keep semantic roles and measured contrast. Remove universal hue-distance, 20% desaturation, and mandatory theme-variant rules; preserve product conventions and assess actual rendered contrast. A red brand does not automatically require abandoning red danger semantics. |
| [typography-design](../skills/web-design/typography-design/SKILL.md) | Refine. Keep semantic headings, loaded font styles, and real-content checks. Do not rely on `title` to reveal essential truncated text. Prefer readable mobile sizes over transform tricks; font smoothing and pairing are optional visual choices. |
| [responsive-design](../skills/web-design/responsive-design/SKILL.md) | Retain with corrections. Keep content-driven breakpoints and capability checks. Distinguish 200% text resizing from reflow testing, include two-dimensional content exceptions, and avoid absolute bans on bounded text containers. |
| [internationalization-design](../skills/web-design/internationalization-design/SKILL.md) | Correct and refine. Separate instants, date-only values, and recurring local schedules; “store UTC” is insufficient for all three. Correct the blanket Arabic/Hebrew joining claim, review RTL leading/trailing wording, and treat expansion percentages as test examples. |
| [motion-design](../skills/web-design/motion-design/SKILL.md) | Refine substantially. Remove contradictory animation mandates and bans. Preserve immediate operability, cancellation, reduced motion, and measured rendering cost. Prefer motion recipes behind conditional references over loading every recipe for a hover fix. |
| [accessibility-audit](../skills/web-design/accessibility-audit/SKILL.md) | Correct. Separate normative failures from stronger recommendations; trap focus only in modal surfaces. Do not claim automation never finds the important issues. Record browser/assistive-tech coverage and test limitations. |
| [frontend-performance](../skills/web-design/frontend-performance/SKILL.md) | Correct. Fix side-effect and React-boundary claims. Profile before virtualization or preload changes. Treat JS budget and throttling profile as project choices; assess Core Web Vitals at p75 with mobile/desktop segmentation. [Web Vitals guidance](https://web.dev/articles/vitals). |

### Web-design controls: 11

| Skill | Verdict and proposed change |
| --- | --- |
| [button](../skills/web-design/button/SKILL.md) | Refine. Native disabled controls are valid in more than one case. If using `aria-disabled`, require actual activation guards. Loading UI needs in-flight protection; consequential writes also need backend replay safety. Preserve action/link semantics. |
| [link](../skills/web-design/link/SKILL.md) | Retain with minor refinement. Keep native navigation and focus behavior. Distinguish descriptive link-text practice from a universal requirement that every link be understandable with zero context. |
| [text-input](../skills/web-design/text-input/SKILL.md) | Refine. Normalize only where the domain allows it: blanket trimming can change meaningful text. Keep IME composition, pasted input, long errors, and large text usable. Do not block every input merely because it is fetching suggestions. |
| [password-input](../skills/web-design/password-input/SKILL.md) | Correct. Apply reset, reveal-button, credential transmission, and explicit-copy corrections above. Call strength estimates estimates, not measured “actual entropy.” Keep authentication policy in its owning flow skill. |
| [otp-input](../skills/web-design/otp-input/SKILL.md) | Refine. Keep one logical string and a visible submit path. Make numeric keyboard, case folding, separators, expiry, and resend behavior match the backend code contract. Deduplicate automatic verification and avoid clearing a code on transport failure. |
| [checkbox-and-radio](../skills/web-design/checkbox-and-radio/SKILL.md) | Retain. Reconcile the consent inline-link example with the restriction on interactive content inside labels. Avoid preselected consequential choices; preserve clear select-all scope and native semantics. |
| [toggle-switch](../skills/web-design/toggle-switch/SKILL.md) | Refine. Optimistic updates need sequencing/versioning and stale-response handling, not only debounce. Make timing an optional recipe. Risky settings may need a separate confirmation or explicit save model. |
| [select-and-combobox](../skills/web-design/select-and-combobox/SKILL.md) | Correct. Choose the APG variant explicitly and preserve text editing. Treat option counts as heuristics. Add stale-response handling and verify that virtualized active options remain represented accessibly. |
| [slider](../skills/web-design/slider/SKILL.md) | Refine. Resolve “always editable value” versus a readout-only volume example. Preserve thumb identity and tab order in dual-thumb controls. Define keyboard commit behavior independently of pointer release. |
| [date-picker](../skills/web-design/date-picker/SKILL.md) | Correct and refine. Store date-only values without inventing an instant; retain a zone ID for future local schedules. Mark today independently of focus. Reject or clarify ambiguous typed dates; natural-language parsing is optional. |
| [file-upload](../skills/web-design/file-upload/SKILL.md) | Refine. Require picker accessibility, but make drag/drop and cropping conditional. Link server validation, authorization, safe storage, resource limits, and partial-upload cleanup to engineering. Cancellation and queue isolation must be verified, not only illustrated. |

### Web-design overlays: 5

| Skill | Verdict and proposed change |
| --- | --- |
| [modal-dialog](../skills/web-design/modal-dialog/SKILL.md) | Correct. Fix inertness, allow established accessible dialog libraries, define nested-dialog policy, and choose initial focus by content and risk. Keep destructive action placement consistent rather than moving it to surprise muscle memory. |
| [drawer-and-sheet](../skills/web-design/drawer-and-sheet/SKILL.md) | Refine. State at the beginning that drawers may be modal or non-modal. Make snap points and drag behavior optional. Test non-drag pointer controls, keyboard containment, and software-keyboard overlap. |
| [popover-and-menu](../skills/web-design/popover-and-menu/SKILL.md) | Refine. Match `aria-haspopup` to the actual popup semantics. Do not close on every descendant blur. A search field inside a command menu changes its interaction model and should not be added solely because it has eleven items. |
| [tooltip](../skills/web-design/tooltip/SKILL.md) | Correct. Reconcile hover persistence, add explicit `role="tooltip"`, and keep required information available without hovering. Label the stronger no-obscuring preference separately from the exact WCAG criterion. |
| [command-palette](../skills/web-design/command-palette/SKILL.md) | Refine. Preserve editable-input keys and IME entry, discard stale results, and enforce permissions when executing commands. Reconcile selected previous query with “preserve nothing” and define handling of failed asynchronous commands. |

### Web-design feedback: 6

| Skill | Verdict and proposed change |
| --- | --- |
| [feedback-design](../skills/web-design/feedback-design/SKILL.md) | Correct and refine. Restrict automatic retries to safe replay. Let backend recovery capability determine undo. Keep the canonical state list; treat latency thresholds as defaults, not deadlines every backend can meet. |
| [toast](../skills/web-design/toast/SKILL.md) | Refine. Resolve “one at a time” against a stack of three. Distinguish timed action requirements from dismissal alone; a close control does not extend an opportunity to act. Keep important results recoverable elsewhere. |
| [alert-banner](../skills/web-design/alert-banner/SKILL.md) | Retain with refinement. Dismissibility should depend on consequence and available persistent access, not an absolute ban for every payment warning. Do not prescribe one width/line count for translated copy. |
| [loading-indicators](../skills/web-design/loading-indicators/SKILL.md) | Refine. Allow concurrent regions to use different truthful indicators. Do not invent nonzero progress or delay ready content solely to satisfy a minimum spinner duration. Keep reduced-motion feedback readable without compulsory shimmer. |
| [empty-state](../skills/web-design/empty-state/SKILL.md) | Retain with cleanup. Classify empty, failed, unauthorized, and cleared explicitly rather than calling every case one of four empty states. Gate create/import actions by actual capabilities and permissions. Update the metadata prompt's fixed count. |
| [destructive-actions](../skills/web-design/destructive-actions/SKILL.md) | Refine. Preserve consistent action placement; confirm scope against the backend, not just a displayed count. Recheck authorization and concurrent changes at execution. Undo need not always be soft delete if another real inverse exists. |

### Web-design navigation, collections, and identity: 12

| Skill | Verdict and proposed change |
| --- | --- |
| [navigation-design](../skills/web-design/navigation-design/SKILL.md) | Refine. Keep URLs, native links, and restoration. Source or remove engagement percentages; menu depth and hamburger bans are product heuristics. Add a stable unique ordering tie-breaker to pagination guidance. |
| [tab-design](../skills/web-design/tab-design/SKILL.md) | Refine. Separate tabs, radio-like segmented values, and route navigation. Remove mandatory delayed crossfades. Preserve drafts and use automatic activation only when it is effectively immediate. |
| [accordion](../skills/web-design/accordion/SKILL.md) | Retain with refinement. Scope find-in-page claims to the hiding mechanism; native details and custom hidden panels differ. Expand invalid sections before focusing their errors. Animation is optional. |
| [card](../skills/web-design/card/SKILL.md) | Refine. Keep semantic primary/secondary actions. Make lift, shadows, ordering, and truncation optional. Do not use bare `role="option"` without the required listbox context. Preserve text selection when needed. |
| [card-and-list-design](../skills/web-design/card-and-list-design/SKILL.md) | Retain with refinement. Virtualize measured expensive lists, not every list over 100 rows. Keep noninteractive content out of the tab order and test focus/findability when virtualization is used. |
| [data-table-design](../skills/web-design/data-table-design/SKILL.md) | Refine. Resolve whole-row selection versus whole-row navigation. Define selection after filter changes, concurrent deletion, and select-all across pages. Keep backend sorting stable and avoid requiring expensive exact totals when unknown. |
| [chart-design](../skills/web-design/chart-design/SKILL.md) | Retain with refinement. Preserve truthful scales and data alternatives. Treat chart counts and aspect ratio as heuristics. Distinguish ordinary magnitude bars from interval/range displays and avoid implying causality from a temporal annotation. |
| [dashboard-design](../skills/web-design/dashboard-design/SKILL.md) | Retain. Add explicit metric definition, aggregation, zone, and freshness ownership. Keep private data out of URL state and enforce export permissions. Make customization and refresh dependent on the user's job. |
| [search-and-filter-design](../skills/web-design/search-and-filter-design/SKILL.md) | Refine. Keep stale-response protection and URL restoration. Gate query logging, recents, and URL persistence for sensitive data; scope caches by user/tenant. Choose exact or fuzzy matching by domain, not a universal ranking recipe. |
| [badge-and-tag](../skills/web-design/badge-and-tag/SKILL.md) | Retain with refinement. Hash into a tested palette, not arbitrary colors. State counts and labels truthfully; do not limit a domain to six states merely to fit the design. |
| [avatar](../skills/web-design/avatar/SKILL.md) | Retain. Make it authoritative for initials and missing-image fallbacks. Correct its introductory upload ownership pointer from media to file-upload. Preserve privacy and verify generated color contrast. |
| [icon-design](../skills/web-design/icon-design/SKILL.md) | Retain with refinement. Preserve meaningful SVG fills/strokes while adapting an icon; do not strip them indiscriminately. Let motion own swaps and make optical adjustments conditional on rendered results. |

### Web-design specialist work: 9

| Skill | Verdict and proposed change |
| --- | --- |
| [drag-and-drop](../skills/web-design/drag-and-drop/SKILL.md) | Correct. Provide keyboard and non-drag pointer paths separately. Make lift/tilt a style option. Stable order values still require conflict handling and a tie-breaker; they do not solve concurrent moves alone. |
| [form-design](../skills/web-design/form-design/SKILL.md) | Refine. Keep draft preservation and server-confirmed save. Do not mandate offline storage/replay for all forms, especially credentials or sensitive data. Match validation timing to field type and make background autosave preserve focus. |
| [auth-flow-design](../skills/web-design/auth-flow-design/SKILL.md) | Correct. Fix recovery/session defaults above. Keep anti-enumeration and length-based password policy. Session lifetime and fallback methods require a threat/assurance decision rather than universal long-lived sessions. |
| [ai-interface-design](../skills/web-design/ai-interface-design/SKILL.md) | Correct and refine. Fix implicit live-region behavior. Add IME-safe sending, safe rendering, and separation of trusted tool controls from generated content. Honor scoped prior approvals rather than requesting confirmation for every write. |
| [collaboration-design](../skills/web-design/collaboration-design/SKILL.md) | Retain and extend narrowly. Cover expiring locks, permission revocation, duplicate replay, and base-version checks on reconnect. Distinguish transport reconnection from acknowledged synchronization. |
| [media-design](../skills/web-design/media-design/SKILL.md) | Retain with refinement. Prefer real buttons instead of describing how to imitate them with divs. Distinguish autoplay audio requirements from moving-content requirements. Caption/description availability needs an honest release decision, not just a warning. |
| [microcopy](../skills/web-design/microcopy/SKILL.md) | Correct. Replace conflicting authentication examples, keep stack traces out of ordinary user disclosures, and label sample data. Irregular fabricated numbers are not more truthful than round ones. Preserve meaningful zero values. |
| [onboarding-design](../skills/web-design/onboarding-design/SKILL.md) | Retain with refinement. Source or soften universal tutorial-outcome claims. Distinguish modal tours from non-modal hints and preserve interaction with the taught control where the tutorial requires it. |
| [landing-page-design](../skills/web-design/landing-page-design/SKILL.md) | Refine. Treat the section skeleton as an option; do not add pricing, testimonials, or new routes without scope. Identify the measured LCP element. Define an experiment stopping rule instead of repeatedly testing until significance. |

## Distribution and evaluation findings

- The five core skill bodies occur byte-for-byte in `AGENTS_STANDALONE.md` after frontmatter removal. The README generated block matches the bundle.
- Recursive comparisons found stale `writing-agent-guidance/SKILL.md` in both `.agents/skills/` and `.claude/skills/`. Installed copies lack the newer merge guidance and trailing-checklist rule. Other installed ADD subset comparisons matched.
- The active skills have the expected name/description fields and matching skill references in metadata default prompts. This was a structural text check, not a full YAML-schema validation or harness load test.
- `frontend-performance/agents/openai.yaml` contains a commented-out invocation policy. Remove the ambiguous dead setting or state the intended policy explicitly.
- README says each folder works alone, but many skills assume other skills. Declare required/optional companions in distribution documentation and distinguish “assumes knowledge” from “load this skill.” Do not imply standalone installation supplies missing dependencies.
- Trigger evaluations contradict some descriptions: a code rename expects no skill despite `coding` covering changed code; an input-size edit expects no design skill despite foundations claiming spacing; component tests sometimes forbid skills their bodies assume. Separate direct routing from permitted dependency loading and add diagnosis-only/proposal-only negative cases.
- The catalog contains approximately 54,118 whitespace-delimited words including the deprecated skill. This is inventory size, not per-task context use. Measure actual loaded content and tool work before setting budgets.
- The repository has an embed workflow, but the inspected materials do not establish an automated end-to-end skill evaluation harness. Existing manual prompt tables are a useful starting point, not evidence that routing already passes.

## Suggested implementation order and acceptance

1. Correct authentication, accessibility, unsafe side-effect flags, and mutation replay guidance. Verify each correction against its primary source and a concrete failure example.
2. Resolve cross-skill ownership and authorization contradictions. Keep canonical bodies and required distribution artifacts aligned using the repository's established sync process.
3. Scope project templates and document the ADD lifecycle mapping and companion skills. Avoid broad folder moves or adding more general skills.
4. Convert universal design recipes into defaults and conditional references. Preserve concise rules that prevent demonstrated failures.
5. Add lightweight automated structural validation: unique names, valid metadata, existing references, mirror equality, and bundle equality. Keep generated README updates workflow-owned.
6. Exercise representative tasks in fresh sessions: unrelated-repo component generation, diagnosis without implementation, authorized fix, local mechanical edit, password reset, keyboard/pointer drag alternatives, and an async search race. Record task success, unwanted edits, repeated approval requests, verification completion, and loaded context. Compare against the prior guidance before adopting changes.

Verification during this audit: all 66 skill bodies reviewed; recursive installed-copy checks run; core/bundle/README equality checked; `git diff --check` passed before creating this report. Browser behavior, agent routing, and executable examples were not exercised. Those remain the validation work for implementation, not claimed results of this proposal.

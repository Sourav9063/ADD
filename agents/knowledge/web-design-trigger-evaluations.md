# Web Design Trigger Evaluations

Manual checks that the right skill in [`skills/web-design/`](../../skills/web-design/) fires
for a request, and that its neighbours stay quiet. Run after changing any description in the
group, splitting a skill, or folding one away.

Companion to [`trigger-evaluations.md`](trigger-evaluations.md), which covers the ADD-wide
skills. This group is large (53 skills) and its seams are close together, so most routing
failures here are a near-miss rather than nothing firing at all.

No harness exists. Read the agent's opening moves on a fresh session and confirm which
skills it loaded before writing code. Created 2026-09-04, after the component split.

## Composition against component

The most common failure: a multi-component screen that loads one component skill and invents
the rest, or a one-control request that pays for the whole workflow.

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Build the settings page for notifications and billing" | `ui-composition`, then `form-design`, `toggle-switch` | a component skill alone |
| "Add a toggle to the email row in settings" | `toggle-switch` | `ui-composition` |
| "Design the whole checkout flow" | `ui-composition`, then `form-design`, `auth-flow-design` | `form-design` alone |
| "Make this input 8px taller" | none | any design skill |

## Form seams

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Add a contact form with name, email, message" | `form-design` and `text-input` | `ui-composition` alone |
| "Validation fires on every keystroke and it is annoying" | `form-design` | `text-input` |
| "The email field needs a better error style" | `text-input` | `form-design` |
| "Let users pick a country" | `select-and-combobox` | `popover-and-menu` |
| "Add a password field to signup" | `password-input`, `auth-flow-design` | `text-input` alone |
| "Users cannot paste the SMS code" | `otp-input` | `text-input`, `form-design` |
| "Add a date range to the report filters" | `date-picker` | `form-design` alone |

## Action seams

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Add a delete button to each row" | `destructive-actions` and `button` | `button` alone |
| "Should this button be disabled until the form is valid?" | `button` | `form-design` alone |
| "Add bulk delete to the table" | `data-table-design` and `destructive-actions` | `button` |
| "Let users drag cards between columns" | `drag-and-drop` | `card-and-list-design` alone |
| "Swipe to archive on the notification list" | `card-and-list-design` | `drag-and-drop` |

## Overlay seams

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Should this be a modal or a drawer?" | `ui-composition` | `modal-dialog`, `drawer-and-sheet` |
| "The confirm dialog does not return focus" | `modal-dialog` | `ui-composition` |
| "The dropdown is clipped inside the sidebar" | `popover-and-menu` | `select-and-combobox` |
| "Add a hint to this icon button" | `tooltip` and `button` | `popover-and-menu` |
| "Add ⌘K search" | `command-palette` | `search-and-filter-design` alone |
| "Filters should slide up from the bottom on mobile" | `drawer-and-sheet` and `search-and-filter-design` | `modal-dialog` |

## Feedback seams

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Show a loading state while the table fetches" | `loading-indicators` | `feedback-design` alone |
| "Should this be a toast or a banner?" | `feedback-design` | `toast`, `alert-banner` |
| "The undo toast disappears too fast" | `toast` | `feedback-design` |
| "The list is blank for new accounts" | `empty-state` | `feedback-design` |
| "Warn people their card expired" | `alert-banner` | `toast` |

## Cross-cutting seams

| Prompt | Expected | Must not fire |
| --- | --- | --- |
| "Make it look less generic" | `visual-direction` | `design-foundations` alone |
| "Our icons look inconsistent" | `icon-design` | `design-foundations` |
| "Build a dark theme" | `color-systems` | `design-foundations` |
| "Add breadcrumbs to the project pages" | `navigation-design` | a search for a breadcrumb skill |
| "These tabs overflow on mobile" | `tab-design` | `navigation-design` |
| "Is this screen accessible?" | `accessibility-audit` | `design-foundations` |
| "The dashboard is slow to paint" | `frontend-performance` | `dashboard-design` |
| "Add a KPI row above the charts" | `dashboard-design` | `chart-design` alone |
| "This bar chart starts at 40" | `chart-design` | `dashboard-design` |
| "Stream the assistant's reply" | `ai-interface-design` | `feedback-design` |

## Skills that no longer exist

Stale names from before 2026-09-04. An agent reaching for one of these, or a project with an
older install, should land here instead:

| Old name | Now |
| --- | --- |
| `button-and-action-design` | `button`, `destructive-actions`, `data-table-design` (bulk bars) |
| `overlay-design` | `ui-composition` (surface choice), plus the individual overlay skills |
| `breadcrumb` | `navigation-design` |
| `skeleton`, `progress-and-spinner` | `loading-indicators` |

## Failure signals worth acting on

- A skill that never fires on its own row: its description lacks the phrasing people actually use.
- A skill that fires on a "must not" cell: two descriptions claim the same trigger, so tighten the narrower one rather than widening the other.
- `ui-composition` firing for single-control work, or failing to fire for a whole screen: the composition trigger is the one most likely to drift, because every request mentions components.
- The agent loading a component skill and then inventing rules the skill states: a content problem, not a routing one. Check the body before editing the description.

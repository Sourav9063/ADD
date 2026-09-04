---
name: empty-state
description: Build or review empty states. Use when a list, table, search result, dashboard, inbox, or feed has nothing to show, when designing the first-run state of a new account or workspace, or when a filtered view, permission restriction, or failed load leaves a blank screen.
---

# Empty State

Assumes `feedback-design` for the surrounding states and `microcopy` for wording. A blank
region is indistinguishable from a crash. Every collection in the product needs this state
designed, and **there is no single shared "No data" that works** - four different situations
need four different answers.

## The four kinds

| Situation | What it needs |
| --- | --- |
| **First run** - nothing exists yet | What this screen will hold, one primary action to create the first item, and a ghost preview of the filled state |
| **No results** - a search returned nothing | The query echoed back, spelling or broader-term suggestions, and a way to clear the search |
| **Filtered out** - data exists but not here | The active filters named, and Clear all (`search-and-filter-design`) |
| **Error** - the load failed | What failed, whether it is retrying, and a Retry control |

Two more worth designing when they apply: **permission** ("You do not have access to this
project" plus who to ask) and **cleared** ("You are all caught up"), which is a success
state and should read like one.

## First run is the most valuable screen in the product

- It is the best onboarding surface you have; treat it as a designed screen, not a fallback (`onboarding-design`).
- One line saying what will live here, in the user's terms, plus one primary action. Not three competing buttons.
- A **ghost preview** - dimmed sample rows or cards behind the message - teaches the shape of the filled state better than any description.
- Offer the fast path as well as the slow one: import, template, or sample data alongside "Create your first project".
- Never show a first-run state to an account whose data merely failed to load. Distinguish "none" from "unknown".

## Writing and visuals

- Write like a product, not a log file: never "ERROR 404: result set empty", never "No data available".
- Lead with what the user can do, then explain. Keep it to a sentence or two; a paragraph in an empty state goes unread.
- The action must be contextual and real. "Try refreshing" is not a next step; "Create your first invoice" is.
- Keep illustrations small and optional. A large decorative graphic with no action is worse than plain text, and `visual-direction` forbids hand-authoring illustrations for it.
- Center the block in the region it belongs to, at a comfortable measure, without stretching to fill a huge viewport.

## In context

- **In a table**: keep the header row and the toolbar rendered; only the body is empty, so the user still sees the columns and can clear filters (`data-table-design`).
- **In a dashboard widget**: distinguish "no data yet" from "not enough data to plot" from "the query failed" (`dashboard-design`).
- **In a search or filter view**: echo the query, keep the input filled so it can be edited, and suggest the nearest broader query (`search-and-filter-design`).
- **In a card grid**: keep the grid's shape so the layout does not collapse to a thin strip.
- Never replace the whole page for one empty region.

## Accessibility

- Announce the empty result politely when it follows an action - "No results for «invoice 42»" - so a screen-reader user learns the search completed (`feedback-design`).
- The empty state is real content with a heading at the right level, not an image with the message baked into it.
- Its primary action is a real button in the tab order, and focus is not stolen when the state appears.
- Do not rely on a muted gray for the whole block; the text still meets contrast.

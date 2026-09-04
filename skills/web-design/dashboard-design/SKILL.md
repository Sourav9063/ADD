---
name: dashboard-design
description: Build or review a dashboard or analytics home. Use when laying out KPI tiles and widgets, choosing what belongs on an overview screen, adding global time ranges and filters, real-time refresh, drill-down into detail, per-widget loading and empty states, threshold alerts, or customizable and saved layouts.
---

# Dashboard Design

Assumes `design-foundations` for tokens and density, and `chart-design` for everything
inside a chart: type choice, axes, series color, tooltips, and chart accessibility. This
skill owns the page around them.

A dashboard is a single-screen view meant to be absorbed at a glance and acted on - the car
metaphor is the whole brief. It is not an exploration tool. If the user's job is to slice and
compare, they need a query surface and a table (`data-table-design`), not more tiles.

## Decide the type first

| Type | Question it answers | Consequences |
| --- | --- | --- |
| **Operational** | Is anything wrong right now? | Live or frequently refreshed, thresholds and alerts, current values over trends, designed to be watched at distance |
| **Analytical** | What changed, and is it worth investigating? | Comparison periods, trends and breakdowns, drill-down into detail, refreshed on load rather than continuously |

Mixing them produces the common failure: a wall of tiles that neither monitors anything nor
answers anything. Name the top question the screen exists to answer, and put its answer in
the first viewport.

## Layout

- Order by importance, not by data availability. The primary metrics lead; supporting breakdowns follow; diagnostics and configuration live below or behind a link.
- Group related widgets and separate the groups with space rather than with borders on everything (`design-foundations`). Proximity does the grouping work that a grid of identical boxed cards destroys.
- Size widgets by information, not by symmetry. A sparkline does not need the same tile as a stacked area chart, and a screen padded to a neat grid buries the signal.
- Cap what is on screen. Anything the user must scroll past three screens of is not a dashboard; split it by audience or role.
- Strip chrome that does not encode data: no decorative icon on every tile, no gradient behind numbers, no chartjunk. Salience is a budget, and superfluous graphics spend it.
- Widget headers state a finding or a plain metric name plus its unit; a "?" affordance carries the definition ("Active = signed in within 30 days"). Undefined metrics are the reason dashboards get argued with instead of used.

## Metric tiles

- The value is the largest thing in the tile, in tabular numbers, abbreviated consistently (`1.2M`, not `1234567` in one tile and `1.2M` in the next). See `typography-design`.
- A change needs its comparison spelled out - "+12% vs. previous 30 days" - with direction shown by arrow and text, never by color alone, and with the polarity right: for churn, down is good.
- Say when the number is provisional, partial, or stale. A tile that silently shows yesterday's total during an outage is worse than an empty one.
- Pair a value with a sparkline only when the trend changes the reading. Zero on a tile is a real answer and must not render as an empty state.

## Time range, filters, and state

- One global time range, controlled once at the top, applied to everything unless a widget explicitly overrides it and says so. Two competing ranges make every comparison suspect.
- Offer relative presets ("Last 7 days") plus a custom range, and keep the resolution honest - hourly buckets over a year is a stall waiting to happen.
- Filters follow `search-and-filter-design`: applied filters visible, individually removable, with Clear all.
- Put the full state in the URL - range, filters, tab, selected segment - so a dashboard can be linked, bookmarked, and pasted into a conversation. This is the single most valuable feature of an internal dashboard and the most commonly missing.
- Show the data's own timestamp: "Updated 2 minutes ago", with the refresh control next to it.

## Refresh and live data

- Refresh per widget, never by reloading the page. Keep layout stable while values update, and update the number in place rather than animating a count-up every tick.
- Pause auto-refresh while the user is interacting - hovering a series, reading a tooltip, selecting a range - and resume after.
- Real-time is a cost, not a feature. Choose an interval that matches the decision being made; a metric no one acts on hourly does not need a websocket.
- Reduced motion removes transitions on updating values, not the updates.

## Per-widget states

Every widget owns its own loading, empty, and error state, and one failing widget must never
take the page with it (`feedback-design`).

- Skeletons in the widget's real shape while data loads; the page frame, headers, and filters stay rendered.
- Distinguish "no data yet" (new account, nothing has happened) from "no data matching these filters" from "the query failed". Each has a different next action.
- Errors stay inside the widget with a Retry, and say which widget failed. Partial data is labeled as partial.

## Drill-down

- Every summary points at its detail: the tile or series opens the filtered table or list behind it, carrying the current range and filters with it, and Back restores the dashboard state.
- Offer the underlying rows and an export. Serious users always want the numbers, and refusing them pushes the work into someone's spreadsheet anyway.
- Where a threshold is breached, the alert links to the thing that breached it, not to a generic incident page.

## Customization

- Ship a default layout that works for the common role. Most people never customize; the default is the product.
- Where layouts are editable, editing is explicit (an Edit mode), reorder works by keyboard as well as by drag (`card-and-list-design`), and Reset to default is always available.
- Saved views beat per-user chaos: named, shareable, with the owner visible.

## Density, responsive, and accessibility

- Density is a deliberate choice per audience; a monitoring wall and a laptop review are not the same screen. Offer a comfortable/compact toggle rather than shipping one cramped default (`responsive-design`).
- Reflow to a single column in importance order below the breakpoint, and never rely on hover for anything required to read a widget - that information does not exist on touch.
- Headings give the dashboard a real structure so a screen reader can navigate widget by widget; each widget is a labeled region.
- Numbers, deltas, and statuses are readable as text without the chart: state the finding in the header or a visually hidden summary, and expose the table (`chart-design`).
- Status colors carry an icon and a word. A red tile is meaningless to a colorblind user and to anyone glancing from across the room.

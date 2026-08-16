---
name: data-table-design
description: Build or review data tables and list views. Use when creating a table, grid, or list of records, or when handling column alignment, sorting, row selection, bulk actions, sticky headers, row density, inline editing, pagination, or responsive table behavior.
---

# Data Table Design

Assumes `design-foundations` for tokens and `filter-design` for the controls above the
table. A table is a system — headers, body, selection, sorting, density, and pagination
must agree with each other.

## Columns

- Lead with the identifying column (name, ID) and pin it; put actions last.
- **Right-align numbers, left-align text, and use tabular figures** (`font-variant-numeric: tabular-nums`) so digits stack on one baseline. Proportional digits jitter and defeat scanning.
- Align decimals and use consistent precision within a column. Units in the header, not repeated in every cell.
- Dates: one format per table, absolute for records, relative only for recent activity — and then with the absolute value on hover/title.
- Truncate long text with an ellipsis and expose the full value in a tooltip or expanded row; never wrap one column into three lines while its neighbors sit on one.
- Show 5–8 columns by default and put the rest behind a column-picker.

## Header and scrolling

- Header sticks on vertical scroll; the first column freezes on horizontal scroll. Both get a subtle shadow once content slides under them, so they read as elevated rather than overlapping.
- Header text is a distinct treatment (smaller, uppercase or medium weight, muted) — never the same as body text.

## Sorting

- **Sort is tri-state: ascending → descending → back to the original order.** A two-state toggle destroys the default ordering permanently, and the default ordering is often the meaningful one.
- Only the sorted column shows a solid arrow; sortable columns show a muted hint on hover/focus. The whole header cell is the target.
- Sort server-side across the full set, not just the current page — page-local sorting is a bug users report as data loss.
- Persist sort in the URL alongside filters and page.

## Density

Row height is a token with presets — compact 36 / default 48 / comfortable 60 — exposed
as one control, not arbitrary spacing per table. Zebra striping at comfortable spacing;
collapse to hairline row borders when compact. Keep cell padding proportional so the grid
does not look starved when compact.

## Selection and bulk actions

- Make the whole row a selection target (row tint + accent left bar + checkbox), not a 16px checkbox.
- Header checkbox is tri-state: empty → **indeterminate** (dash) → checked.
- "Select all" selects the current page. If more exist, offer the explicit escalation: *"All 25 on this page selected. Select all 1,248?"*
- Selection state persists across pagination, and the count is always visible.
- Bulk actions live in a bar that appears on first selection, showing the count, the actions, and a Clear. Destructive bulk actions confirm with the count spelled out and support Undo (see `feedback-design`).
- Shift-click selects a range.

## Row interaction

- Pick one primary row action (usually open) and make the row clickable, but keep interactive cells from swallowing the click.
- Row actions: 1–2 inline, the rest in an overflow menu. **Do not reveal actions on hover only** — they must be reachable by keyboard and on touch; keep them present at low emphasis instead.
- Inline editing must not change row height or column width when the cell becomes an input. Save on blur or Enter, cancel on Escape, and show the per-cell save state.

## Loading, empty, and error

- First load: skeleton rows in the real column layout, 5–10 rows, not a centered spinner.
- Refetch after sort/filter: keep the old rows, dim them, keep the header live.
- Empty needs the distinction from `feedback-design`: nothing yet vs. nothing matching the current filters.
- Row-level failures show inline in that row; do not blow away the table for one bad record.

## Responsive

Do not shrink a 10-column table to 375px. Below ~768px, switch to stacked cards with a
label-value pair per field, or keep a two-column summary table with an expandable detail
row. Horizontal scroll is acceptable only with a frozen first column and a visible scroll
affordance.

## Pagination

- Server-side pagination with page size options (25/50/100) and a total count. Show `1–25 of 1,248`.
- Keep page, size, sort, and filters in the URL.
- Infinite scroll only for feeds, never for records users must audit or reference — and never above a footer.

## Accessibility

- Real `<table>` with `<caption>`, `<thead>`, `<th scope="col">` and `<th scope="row">`. Only use `role="grid"` when you implement full grid keyboard navigation.
- Sortable headers are `<button>`s inside `<th aria-sort="ascending|descending|none">`.
- Each row checkbox has a label naming the row ("Select Ada Lovelace"), not "Select row".
- Announce result-count changes in a polite live region.
- Scrollable table containers need `tabindex="0"` and an accessible name so keyboard users can scroll them.

## Checklist

- [ ] Numbers right-aligned with tabular figures; one date format.
- [ ] Tri-state sort restoring the original order; sorting spans the full dataset.
- [ ] Sticky header and frozen first column with shadows.
- [ ] Full-row selection, indeterminate select-all, persistent count, bulk bar with Undo.
- [ ] No hover-only actions; inline edit does not resize the grid.
- [ ] Skeletons in column shape; distinct empty vs. filtered-empty states.
- [ ] Mobile layout is a rethink, not a squeeze.

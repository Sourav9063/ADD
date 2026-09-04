---
name: date-picker
description: Build or review date and time selection. Use when adding a date field, calendar popover, date range picker, time picker, or scheduling UI, handling presets, disabled and available dates, month and year navigation, or time zones and locale date formats.
---

# Date Picker

Assumes `text-input` for the field and `popover-and-menu` for the surface it opens in. The
calendar is an assist; **typing is the fast path** and must always work.

## Let people type

- Accept a typed date in the obvious formats for the locale, plus loose input (`3/7`, `Mar 7`, `today`, `+3d` where the product suits it). Parse on blur, reformat to the canonical display, and never fight the caret mid-entry.
- Show the expected format as helper text (`DD/MM/YYYY`), not as a placeholder that disappears.
- The calendar button is a separate control beside the field with its own accessible name ("Choose date"), so the field stays typeable.
- Native `<input type="date">` is a reasonable default when the format and range are simple: it gets the platform picker on mobile and full keyboard support free. Rebuild only for ranges, presets, availability, or multi-month views.

## Presets first

Lead with what people actually pick: `Today`, `Tomorrow`, `Last 7 days`, `Last 30 days`,
`This month`. In analytics and filtering these cover the large majority of selections, and
the calendar is the exception path (`dashboard-design`).

- Presets sit above or beside the calendar, are keyboard reachable, and show which one is active.
- A chosen preset stays named ("Last 7 days") rather than collapsing to two dates, so the user knows it will roll forward.

## The calendar

- Default the view to the likely date: today for bookings, the current value when editing, the year list for a birthdate. Opening a birthdate picker on this month costs the user a dozen clicks.
- Mark **today**, **selected**, **in range**, **disabled**, and **outside the current month** distinctly, and never with color alone - today gets an outline or dot, selected gets a filled shape.
- State *why* dates are disabled ("Fully booked", "Past dates unavailable") near the calendar; a grid of dead cells with no explanation is the most frustrating version of this control.
- Month and year navigation are both direct: arrows for adjacent months and a clickable month/year label that opens a picker. Nine clicks to reach last March is a bug.
- Week starts on the locale's first day, weekday headers are abbreviated with the full name available to assistive tech, and the grid is a real `<table>` with column headers.

## Ranges

- First click sets the start, second sets the end, and hovering between them previews the span. If the second click is before the first, treat it as a new start rather than erroring.
- Both edges stay draggable and separately editable after the range exists, with two text inputs bound to them.
- Show two months side by side on desktop; one month with clear next/previous on mobile.
- Enforce and explain limits ("Maximum 90 days") at selection time, not on submit.

## Time and time zones

- Separate the time control from the date; a combined free-text field is unparseable. Offer a stepped list (15- or 30-minute increments) plus typing for exact values.
- Respect 12- or 24-hour convention by locale, and never show a bare time without its date in scheduling contexts spanning midnight.
- **Always state the time zone** when the value crosses users or systems: the abbreviation next to the field, and the resolved local time in a confirmation ("3:00 PM CET - 9:00 AM your time"). Silent UTC-vs-local mismatches are the most common data bug in scheduling UI.
- Store and transmit the unambiguous value (ISO 8601 with offset); display the localized one (`internationalization-design`).

## Keyboard and accessibility

- Arrows move by day, Page Up/Down by month, Shift+Page Up/Down by year, Home/End to week bounds, Enter selects, Escape closes and returns focus to the field.
- The grid is one tab stop with a roving focused day; do not make the user Tab through 31 cells.
- Announce the month and year when the view changes, and mark the focused day with `aria-current="date"` for today plus `aria-selected` for the chosen value.
- Each day cell's accessible name is the full date ("Tuesday, 7 March 2026"), not the number alone, with disabled days conveying their state.
- On mobile use a full-height sheet with a confirm control in thumb reach rather than a shrunken desktop popover (`drawer-and-sheet`).

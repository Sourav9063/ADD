---
name: chart-design
description: Build or review data visualization. Use when creating a chart, graph, dashboard, sparkline, KPI or metric tile, when choosing a chart type, handling axes, legends, tooltips, or series color, or when a chart is hard to read, misleading, or inaccessible.
---

# Chart Design

Assumes `design-foundations` for tokens and `data-table-design` for tabular alternatives.

Start with the question, not the chart. "Which region grew fastest?" and "What share came
from each region?" are different charts of the same data. If you cannot state the question
in one sentence, the chart has no job.

## Pick the form

| Question | Chart |
| --- | --- |
| Compare distinct values | Bar (horizontal when labels are long) |
| Change over time | Line; area only when the volume under it means something |
| Part of a whole, ≤5 categories | Pie or donut; otherwise a stacked bar or a plain table |
| Relationship between two measures | Scatter |
| Distribution | Histogram or box plot |
| One number | A big number, not a chart |
| Trend beside a number | Sparkline |

Beyond 5–7 series, no chart works: filter, group into "Other", or use small multiples.
Never a dual y-axis: two arbitrary scales manufacture whatever correlation you point at.
Never 3D or donut-with-a-gradient; the extra dimension encodes nothing and distorts area.

## Honesty rules

- **Bar charts start at zero. No exceptions.** Truncating the baseline turns +4% into a visual +400%, and it is the most common way charts mislead.
- Line charts may use a non-zero axis (they show change, not magnitude), but label it clearly so nobody reads the gap as the value.
- **Aspect ratio is an argument.** Compressed, a trend looks flat; stretched, it looks explosive. Aim for the average slope near 45°.
- Consistent intervals on the x-axis; irregular time gaps drawn evenly is a lie by spacing.
- Show the denominator. Percentages without an `n` hide "2 of 3 users".
- Label averages and totals honestly, and note when a period is incomplete ("May, partial").

## Make it readable

- Delete anything that encodes no data: gridlines beyond a few horizontal ones, borders, shadows, background fills, redundant legends.
- **Label the data directly** at the end of each line instead of forcing a legend round-trip. A legend is the fallback, not the default.
- Axis labels horizontal; rotated text is a reading tax. Truncate or wrap long categories, or switch to horizontal bars.
- Abbreviate large numbers (`1.2M`), keep precision consistent, and put units in the axis title, not in every tick.
- Sort bars by value unless the category has a natural order (time, size buckets). Alphabetical order almost always hides the finding.
- Annotate the point of the chart with a marker on the launch date or a band for the target, so the reader does not have to find it.
- Sparklines: no axes, no ticks, just the shape plus the current value.

## Color

- One accent for the series that matters, muted gray for the rest. Color is emphasis, not decoration.
- Categorical palettes stay under 7 and must be distinguishable in grayscale and with deuteranopia; check, do not assume. Never encode a category by red-vs-green alone.
- Sequential data gets a single-hue ramp; diverging data gets a two-hue ramp with a meaningful midpoint.
- Keep semantic colors consistent everywhere: if green is revenue in one chart, it is not "good" in the next.
- Reserve the danger color for actual problems, and match series colors across every chart on the dashboard.

## Interaction

- Tooltip on hover **and focus**, showing the exact value, the category, and the comparison the chart implies (change vs. previous period).
- Crosshair or nearest-point snapping on dense lines; hit areas must be forgiving on touch.
- Legend items toggle series, with the state visible and reversible.
- Zoom and brush only when the data density justifies it, and always with a reset.
- Never rely on hover for information required to understand the chart; that data does not exist on a phone.

## Dashboards

- Answer the top question in the first screen; the KPI row leads with a value, its change, and the comparison period spelled out ("vs. last 30 days").
- One idea per chart, with a title stating the finding ("Signups fell 12% after the pricing change") rather than the axis ("Signups over time").
- Consistent time range across the dashboard, controlled once at the top.
- Every chart needs its loading skeleton, its empty state, and its "not enough data yet" state; see `feedback-design`.
- Offer the underlying table and a CSV export. Serious users always want the numbers.

## Accessibility

- The chart element gets a role and an accessible name plus a summary describing the trend: `role="img"` with `aria-label` for static charts.
- Provide the data as a real table (visually hidden or behind a toggle). This is the only reliable screen-reader path and it doubles as the export.
- Never encode by color alone: add direct labels, patterns, markers, or line styles.
- Text and marks meet contrast (3:1 for lines, marks, and axes; 4.5:1 for labels), including in dark mode.
- Keyboard: series and points reachable, tooltips triggered by focus, legend toggles as real buttons.
- Respect `prefers-reduced-motion`: draw-in animations are decorative, so drop them rather than delaying the data.

## Checklist

- [ ] The question is stated, and the chart type answers it.
- [ ] Bars start at zero; aspect ratio and intervals do not exaggerate.
- [ ] Non-data ink removed; series labeled directly.
- [ ] One accent, muted rest; palette survives grayscale and color-vision deficiency.
- [ ] Tooltips on focus as well as hover; nothing important is hover-only.
- [ ] Titles state findings; denominators and partial periods disclosed.
- [ ] Accessible name, summary, and an underlying data table.

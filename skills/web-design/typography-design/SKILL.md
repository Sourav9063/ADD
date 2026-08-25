---
name: typography-design
description: Set and render type in a web interface. Use when choosing or pairing typefaces, building a type scale, setting line height, letter spacing, or measure, fixing wrapping, widows, orphans, or truncation, aligning text optically inside buttons and badges, styling underlines or selection, handling tabular numbers, or when text looks cramped, wrong-weight, or shifts as values update.
---

# Typography Design

`design-foundations` owns the token scale that sizes live in. This skill owns everything
after that: which faces load, how text wraps, where it truncates, and why it sits two
pixels low in a badge.

Read type on the rendered page, not in the stylesheet. Widows, bad breaks, and truncation
only appear at real content lengths.

## Roles, not sizes

A size alone tells you nothing about where to use it. Pair each step with its line height
and weight so a role is one decision instead of three:

| Role | Size | Line height | Weight |
| --- | --- | --- | --- |
| Display | 36px | 1.1 | 600 |
| Title | 24px | 1.2 | 600 |
| Heading | 18px | 1.3 | 600 |
| Body | 16px | 1.5 | 400 |
| Caption | 13px | 1.4 | 400 |

Emphasis inside a role is one weight step up (400 to 500), never a size change. On a team,
name steps by use (`text-body-sm`) rather than by size (`text-sm`); the name is what
carries the usage rule to the next person.

Heading levels map to descending steps of that scale, so a child heading never outweighs
its parent. Adjacent levels may share a size at the small end as long as weight or spacing
keeps them apart. Pick the heading element from the document structure, then set its size
here. Never pick `<h3>` because its default size looked right.

## Faces and weights

- Serve `.woff2`. `.ttf` and `.otf` are desktop formats with no web compression.
- Rarely more than two families, three at the absolute limit. Pair for contrast, not similarity: a serif headline over a sans body reads as deliberate, two near-identical sans-serifs read as an accident.
- **Load the weights and styles the design uses.** A browser will synthesize a missing bold or italic by shearing and smearing the regular face. `font-synthesis: none` turns that off, but it erases the emphasis rather than reporting it, so set it only after confirming every required bold, italic, and small-cap form survives the whole fallback stack.
- Below 18px, stay at weight 400 or heavier. Weights under 300 are display-only at 28px and up; at text sizes they disappear.

**Prefer the property to the raw feature tag.** `font-weight: 650` over
`font-variation-settings: "wght" 650`, `font-optical-sizing: auto` over `"opsz"`,
`font-variant-numeric: tabular-nums` over `font-feature-settings: "tnum"`. Properties keep
working when a non-variable fallback renders. Reserve raw tags for custom axes and
stylistic sets that have no property of their own.

## Spacing within text

- **Line height by role.** Headings around 1.1, body 1.5 to 1.6, always unitless so it scales with the font size. Tight leading is for short text: anything that wraps to three or more lines needs at least 1.4, including a card description in a height-constrained row.
- **Letter spacing by size.** Large headings usually want slightly negative tracking (around -0.02em). Small uppercase labels need slightly positive (around 0.05em), or the caps crowd. Body copy at reading sizes needs neither.
- **Cap the measure at 60 to 75 characters.** Past that the eye loses the start of the next line. Any unit works as long as a cap exists.
- **Trim the font's built-in leading** where text must sit optically centered in a button or badge: `text-box: trim-both cap alphabetic`. Treat it as progressive enhancement; unsupported browsers keep the default and look the way they do today.

## Wrapping and breaking

Four declarations, four jobs:

- `text-wrap: balance` evens the lines of a heading. Headings only.
- `text-wrap: pretty` stops one short word landing alone on the last line. Descriptions and short body copy.
- `overflow-wrap: break-word` anywhere a long URL, token, or ID could escape its container.
- `white-space: nowrap` on labels and badges where a break looks broken.

Skip `balance` and `pretty` in long-form article text; they cost layout work for lines
nobody is scanning.

## Numbers and truncation

Digits have different widths by default, so a timer, counter, or price shifts the layout on
every update. Apply `font-variant-numeric: tabular-nums` to any value that changes, and to
any column of figures. In tables, numbers align to the trailing edge and text to the
leading edge.

Truncate with `text-overflow: ellipsis` on one line, `line-clamp` on several. Truncation
hides content, so when the hidden text matters, keep the full value reachable through a
tooltip, a title attribute, or an expanded view. A clamp with no way to expand is data
loss.

## Underlines, selection, and rendering

- **Pull underlines from the font**: `text-underline-position: from-font` and `text-decoration-thickness: from-font`, with `text-decoration-skip-ink: auto` so the line does not cut through descenders. A dotted underline is the conventional cue for an abbreviation or defined term.
- **Only the underline's color animates reliably.** If anything other than color needs to move, build the underline as a separate element rather than fighting `text-decoration`.
- **Keep text selectable.** `user-select: none` belongs on a draggable or gesture-driven surface where accidental selection interferes, never across application chrome and never because a button label can be highlighted.
- **Font smoothing goes on the root, once.** `-webkit-font-smoothing: antialiased` with `-moz-osx-font-smoothing: grayscale`, never per component.
- **Write copy in natural case** and control presentation with `text-transform`, so a redesign never means rewriting strings.
- Use real punctuation in rendered text: curly quotes in prose, an en dash for ranges, the single ellipsis character, `&nbsp;` to hold `16 px` together, `&shy;` to say where a long word may break.

## Inputs at 16px on mobile

iOS Safari zooms the entire page when a focused input renders below 16px. Two fixes hold
the size, and they look different, so pick deliberately:

- **Size up on small screens** (`text-base sm:text-sm`). Nothing to compensate, but the mobile input no longer matches the desktop one.
- **Keep `font-size: 16px` and scale the text down** with a transform, dividing line height and multiplying width by the same factor. Identical at every viewport, more code to maintain. The transform shrinks the whole box, so let a wrapper draw the field's background and border and keep the input itself transparent.

## Size floors

Long-form body text starts at 16px, the browser default. Move off it only for a reason you
can name: the typeface runs small, the measure is narrow, or the product is a dense
professional tool. UI text can go smaller: 14px for inputs and menus, 13px for captions,
rarely below 12px. Verify at 200% zoom and with an enlarged browser font size, because type
has to survive the reader changing it.

## Checklist

- [ ] Every size lands on the scale, paired with its role's line height and weight.
- [ ] Headings descend by level; no heading element chosen for its default size.
- [ ] Real faces loaded for every weight and style used; no synthesized bold or italic.
- [ ] Measure capped at 60 to 75 characters; anything wrapping to 3+ lines is at 1.4 or looser.
- [ ] `balance` on headings, `pretty` on descriptions, `break-word` where strings can overflow.
- [ ] Tabular numbers on every changing value.
- [ ] Truncated text stays reachable in full.
- [ ] Inputs render at 16px on mobile; layout holds at 200% zoom.

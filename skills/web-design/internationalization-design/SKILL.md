---
name: internationalization-design
description: Design UI that survives translation, mirroring, and locale differences. Use when a product ships in more than one language, when adding RTL support for Arabic, Hebrew, Persian, or Urdu, when text overflows or truncates after translation, when setting dates, currency, numbers, names, or addresses, when choosing type for CJK or Indic scripts, or when a color or icon carries meaning that may not travel.
---

# Internationalization Design

Retrofitting this is expensive: a layout built around English string lengths and a
left-to-right reading order has to be rebuilt, not patched. Design for it from the first
component.

`typography-design` owns how text renders. `responsive-design` owns how the layout adapts.
This skill owns what changes when the language does.

## Text expansion

The most common localization failure, and it happens before any translator is hired.

| Language | Typical growth against English |
| --- | --- |
| German | +20 to 35% |
| French | +15 to 25% |
| Finnish | +30 to 40% |
| Japanese, Chinese | Usually shorter, with different wrapping rules entirely |

**Short strings grow proportionally more than long ones**, which makes a one-word button
label the riskiest string on the screen. Never budget a flat percentage.

- No fixed width or height on anything holding text. `max-width` and wrapping instead.
- Buttons size from their label with `padding-inline`, never a hardcoded width.
- Test the whole navigation together, not one item at a time; menus break as a set.
- Truncation with a tooltip or expand is an acceptable last resort, never the plan.

**Pseudo-localize before translations exist.** Substituting extended lookalike characters
and padding each string exposes overflow, clipping, and hardcoded strings in one pass, with
no translator involved.

## Right-to-left

The layout mirrors. Express direction-dependent position logically and most of it happens
for free:

| Physical | Logical |
| --- | --- |
| `margin-left` | `margin-inline-start` |
| `padding-right` | `padding-inline-end` |
| `left: 0` | `inset-inline-start: 0` |
| `text-align: left` | `text-align: start` |
| `border-right` | `border-inline-end` |

Think in leading and trailing rather than left and right. Reserve physical properties for
genuinely physical geometry: positioning against a device notch, or matching a fixed
gesture direction.

**What mirrors:** reading order, navigation and sidebar placement, directional icons
(arrows, chevrons, back), and anything where arrangement encodes progression, so steppers,
progress bars, and star ratings fill from the trailing side. Flexbox and grid mirror
automatically with logical properties; hand-positioned elements do not.

**What does not mirror:** logos and brand marks, clocks, mathematical notation,
non-directional icons like a camera or gear, media transport controls, and digits inside a
number. Numerals stay left-to-right even inside RTL text.

Set `lang` so the browser picks the right hyphenation, quotes, and pronunciation, set `dir`
at the document or at the boundary where direction changes, and wrap a mixed-direction
value in `<bdi>` so it does not reorder the sentence around it.

## Non-Latin scripts

- **The two-family Latin pairing model does not transfer.** For CJK and most non-Latin scripts, use one family across a weight scale rather than pairing a display face with a body face.
- **CJK** needs looser line height and different measure rules than Latin; characters are square and there are no word spaces to break on.
- **Arabic and Hebrew** are cursive with letter-joining rules, and need a larger minimum size than Latin to stay legible, 16px and up.
- **Indic scripts** rely on complex ligatures; verify the whole fallback stack renders them rather than dropping to boxes.
- **Never fake bold or italic on a non-Latin face.** Synthesis distorts letterforms that carry meaning. Load real weights or drop the emphasis; see `typography-design`.

## Locale formats

Format with the platform's locale APIs (`Intl.DateTimeFormat`, `Intl.NumberFormat`,
`Intl.RelativeTimeFormat`), never with a hand-written template.

- **Dates.** `MM/DD/YYYY`, `DD/MM/YYYY`, and `YYYY-MM-DD` all exist, so `03/04` is ambiguous everywhere. Spell the month in UI text.
- **Numbers and currency.** Symbol position, decimal separator, thousands separator, and digit grouping all vary. Store amounts with their currency, never as a bare number.
- **Names.** Given-name-first is not universal, and neither is a two-field split. One flexible full-name field beats first and last for most products.
- **Addresses.** Field order, required fields, and postcode format vary enough that a locale-aware address form is the only correct answer.
- **Sorting and search** follow locale collation, not code-point order.
- **Time zones and week start.** Store UTC, render local, and do not assume the week starts on Monday or Sunday.

## Meaning that does not travel

- **Color.** Red reads as danger in most Western contexts and as luck and prosperity in China, where financial interfaces invert the whole convention and show gains in red. White reads as clean in some markets and as mourning in others. Where gain and loss or status is load-bearing, make it a per-locale token rather than a hardcoded value. Never carry meaning in color alone, which is also an accessibility requirement.
- **Icons.** Hand gestures are offensive in some markets. Postal boxes, houses, and telephones look nothing alike across regions. Prefer abstract or genuinely universal forms, and audit the icon set before entering a new market.
- **Idiom.** Sports metaphors, puns, and cultural references do not survive translation. See `microcopy`.

## Strings that can be translated

- **One sentence, one string.** Never concatenate fragments in code; word order is not universal, and a translator seeing half a sentence cannot translate it.
- **Pass plural and gender to the formatting layer.** Languages have up to six plural forms; a `count === 1` branch is wrong outside English.
- **No text baked into images.** It cannot be translated, read aloud, or restyled.
- **Give translators context.** A key named `submit` with no note becomes the wrong verb in half the target languages.

## Checklist

- [ ] No fixed sizes on text containers; buttons sized from their labels.
- [ ] Pseudo-localization run, and at least one long-expansion locale checked.
- [ ] Logical properties throughout; the RTL mirror inspected, not assumed.
- [ ] Directional icons mirror; logos, clocks, numerals, and media controls do not.
- [ ] `lang` and `dir` set; mixed-direction values isolated with `<bdi>`.
- [ ] Non-Latin type uses real weights and script-appropriate line height.
- [ ] Dates, numbers, currency, names, and addresses formatted by locale API.
- [ ] Color and icon meanings verified for every market shipped to.
- [ ] Full-sentence strings, plural rules delegated, no text inside images.

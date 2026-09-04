---
name: select-and-combobox
description: Build or review a select, dropdown, combobox, or autocomplete field. Use when choosing between radios, a native select, and a searchable menu, adding typeahead or async options, multi-select with chips, option grouping, empty and loading option states, or when a picker has too many options to scroll.
---

# Select and Combobox

Assumes `design-foundations` for tokens and focus, and `text-input` for the field itself.
A menu that only navigates or acts is `popover-and-menu`, not this; a select produces a
**value**.

## Pick the control by option count

| Options | Control |
| --- | --- |
| 2 | Radio pair, or a toggle if it is on/off (`checkbox-and-radio`, `toggle-switch`) |
| 3-7 | Radios, or a segmented control when the options are short and comparable |
| 7-15 | Native `<select>` |
| 15+ | Combobox with typeahead |
| Unbounded or remote | Async combobox with search, paging, and a no-results state |

Native `<select>` is the right default in the middle band: it gets the platform's picker on
mobile, works with hardware keyboards, and cannot be broken. Rebuild it only when you need
search, multi-select, option descriptions, or custom rendering - and then you owe the full
keyboard contract below.

## The field

- The trigger shows the current value, not the placeholder, once something is selected, and keeps a visible caret affordance.
- Width is stable: size to the longest realistic option or truncate with a tooltip. A picker that resizes as the value changes shifts the whole form.
- Default to a real value only when one is genuinely the common case; otherwise leave it unselected with a "Select a country" prompt rather than a defaulted first option nobody chose.
- Show a clear affordance when the field is optional and clearable.

## The menu

- Anchor to the trigger, match its width, and flip above when there is no room below. Never let the menu escape the viewport or clip inside an overflow container (`popover-and-menu`).
- Cap the height and scroll the list, with about 7-10 options visible. Keep the search input pinned above the scroll area.
- Group with headings when the set has real categories (`<optgroup>` natively), and keep the selected item marked with a check, not only a highlight - highlight is where the cursor is, check is what is chosen.
- Option rows carry the label first; descriptions and metadata are secondary text, not a second column that pushes the label out.

## Search and async

- Filter on substring, not prefix only, and fold case and accents. Highlight the matched span in the results.
- Debounce remote queries ~200-300ms, keep the previous results visible while fetching, and show a loading row rather than emptying the list.
- Three distinct empty states: nothing typed yet (show recents or the full list), no matches for this query (echo the query, offer to clear), and the request failed (retry). A single blank menu covers none of them.
- Offer "Create «query»" when the field accepts new values, as the last row, clearly separated.

## Multi-select

- Selected values render as removable chips in or below the field, each with its own remove control and an accessible name ("Remove Norway").
- The menu stays open while selecting, and the input clears after each pick so the next search starts clean.
- Show the count and a Clear all once past a handful. Cap the visible chips with a `+n` overflow rather than letting the field grow without limit.
- Backspace on an empty input removes the last chip - expected by anyone who has used a tag field, and easy to omit.

## Keyboard

Follow the APG combobox pattern; users have this contract memorized:

- Down or Alt+Down opens the menu with the current value focused; typing opens it and filters.
- Up and Down move the active option, Home and End jump to first and last, and the active option scrolls into view.
- Enter selects the active option and closes; Tab selects and moves on; Escape closes and restores the previous value, and a second Escape clears the input.
- Typeahead on a non-searchable select jumps to the first option starting with the typed characters.
- Focus stays on the input while `aria-activedescendant` marks the active option; do not move DOM focus into the list.

## Accessibility

- `role="combobox"` on the input with `aria-expanded`, `aria-controls`, and `aria-autocomplete`; the list is `role="listbox"` with `role="option"` children and `aria-selected`.
- Announce the result count when the list updates ("12 results"), politely, so a screen-reader user knows filtering happened.
- The trigger and every option meet the 24px target minimum; option rows are not 20px tall on touch.
- Disabled options state why, or are omitted. An unexplained dead row is worse than a shorter list.
- On mobile, prefer the native picker or a full-height sheet with a large confirm target over a shrunken desktop menu (`drawer-and-sheet`).

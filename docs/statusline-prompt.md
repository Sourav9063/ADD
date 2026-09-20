# Statusline Setup Prompt

A reusable prompt that builds the Claude Code statusline below from scratch. Paste it into a fresh session; it is self-contained.

```
Opus • Medium • CTX 18% • 51%(+19) 1h36m • 64%(+29) 2d10h
```

## Prompt

````markdown
Set up my Claude Code statusline.

## Target output

Opus • Medium • CTX 18% • 51%(+19) 1h36m • 64%(+29) 2d10h

Fields, left to right, joined by " • ":
1. Model family, capitalized — from `.model.id`: strip the leading `claude-`,
   take the segment before the next `-`, then Title Case it (`claude-opus-5` →
   `Opus`, `claude-haiku-4-5-20251001` → `Haiku`).
2. Effort level, capitalized — from `.effort.level` (`medium` → `Medium`).
3. `CTX <n>%` — from `.context_window.used_percentage`, rounded.
4. The 5-hour rate-limit window.
5. The 7-day rate-limit window.

## Rate-limit windows

Each window renders as `<remaining>%(<surplus>) <time-to-reset>`, e.g.
`51%(+19) 1h36m`.

- remaining = `100 - round(used_percentage)`.
- Even-burn pace = the share of the window still on the clock:
  `round(seconds_left * 100 / window_length)`. That is the quota you'd have
  left if you burned evenly.
- surplus = remaining - pace, always signed (`+19`, `-12`). Positive means
  ahead of budget.
- `seconds_left` = `resets_at - now` (`resets_at` is Unix epoch seconds).
  Clamp it into `[0, window_length]` so a past-due or stale reset can't make
  the pace negative or over 100.
- Window lengths: 18000s (5h) and 604800s (7d).
- Reset time formatting:
  - 5h window: `1h36m`, or `36m` under an hour.
  - 7d window: `2d10h`, falling back to the `h`/`m` form under a day.
  - Truncate, don't round, each unit.
- No `5h` / `7d` labels — the reset durations already distinguish them.

## Styling (ANSI)

Skip all escapes when `NO_COLOR` is set to a non-empty value.

- `•` separators: bright/bold (`\e[1m`).
- Surplus, including its parentheses: dim plus a color by margin — green
  `\e[2;32m` above +5, yellow `\e[2;33m` across the near-pace band +5 to -5
  inclusive, red `\e[2;31m` below -5. Always show the sign and the value,
  negatives included (`(-2)`, `(-27)`).
- Everything else — model, effort, `CTX`, the percentages, the reset
  durations — unstyled default terminal text.

Only the separators and the surplus carry styling; the plain numbers should be
what the eye reads first.

## Implementation

- A single `bash` script at `~/.claude/statusline-command.sh` that `exec`s one
  `jq -r` program reading the statusline JSON on stdin. One process per redraw,
  no subshells, no temp files, no network or state.
- Register it in `~/.claude/settings.json` as
  `"statusLine": {"type": "command", "command": "bash ~/.claude/statusline-command.sh"}`.
- Output exactly one line, no trailing newline noise.
- Comment the non-obvious parts only: the even-burn/surplus math, and the
  styling rationale.

## Robustness

Any absent or non-numeric field drops just its own segment, with the
separators collapsing cleanly — never print `null`, `NaN`, or a stray `•`.
Verify with these inputs before reporting done, all of which must exit 0:

- a full payload;
- `used_percentage: 95` with `resets_at` already in the past;
- `{"model":{"id":"claude-haiku-4-5-20251001"}}` (should print just `Haiku`);
- `{}` (should print an empty line);
- a full payload with `NO_COLOR=1` (identical text, zero escapes).

Show me the rendered output piped through `cat -v` so I can check the escapes.
````

## Notes

- The `{}` and missing-field cases are the ones that actually bite: `jq`'s `ascii_upcase` throws on `null`, so the model lookup needs an explicit `// ""` fallback after the `split`. Listing those inputs in the prompt is what forces the failure to surface during setup rather than in the live statusline.
- The prompt asks for a direct edit because `Agent` (and therefore the `statusline-setup` subagent) is denied in `~/.claude/settings.json`. Drop that assumption if the subagent is available.

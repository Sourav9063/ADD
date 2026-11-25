#!/usr/bin/env bash
# Claude Code statusline: Opus • Medium • CTX 20% • 51%(+19) 1h36m • 64%(+29) 2d10h
# Model, effort, context use, and both rate-limit windows shown as
# "remaining(surplus vs even-burn pace) time-to-reset".
# One jq process per redraw; missing or wrongly typed fields are skipped.

settings="$HOME/.claude/settings.json"
[ -r "$settings" ] || settings=/dev/null

# Settings load as raw text so malformed JSON falls back to raw context use
# instead of blanking the line.
exec jq -r --rawfile st "$settings" --arg nc "${NO_COLOR:-}" '
  def esc($c): if $nc == "" then "\u001b[\($c)m" else "" end;
  def cap: (.[0:1] | ascii_upcase) + (.[1:] | ascii_downcase);
  def dur: (. / 86400 | floor) as $d | (. % 86400 / 3600 | floor) as $h | (. % 3600 / 60 | floor) as $m
    | if $d > 0 then "\($d)d\($h)h" elif $h > 0 then "\($h)h\($m)m" else "\($m)m" end;

  # Context use against the effective window. Claude Code reports
  # used_percentage relative to context_window_size (e.g. 1M), but
  # autoCompactWindow caps the usable window (e.g. 500k), so rescale against
  # the smaller of the two.
  def ctx:
    (.used_percentage? | numbers) as $used
    | ((.context_window_size? | numbers) // null) as $size
    | (($st | fromjson? | .autoCompactWindow? | numbers) // null) as $ac
    | if $size != null and $ac != null and $size > 0 and $ac > 0
        then $used * $size / ([$size, $ac] | min)
      else $used end
    | round;

  # remaining% is what is left of the quota. $left * 100 / $len is the share
  # of the window still on the clock: what you would have left burning evenly.
  # Surplus is the difference; positive means ahead of budget. $left is clamped
  # to [0, $len] so a stale reset cannot push the pace outside 0-100.
  # Only the surplus is coloured, so the plain numbers are read first.
  def win($len):
    (.used_percentage? | numbers) as $u | (.resets_at? | numbers) as $r
    | ([0, ([$r - now, $len] | min)] | max | floor) as $left
    | (100 - ($u | round)) as $rem
    | ($rem - ($left * 100 / $len | round)) as $s
    | (if $s > 5 then "2;32" elif $s >= -5 then "2;33" else "2;31" end) as $c
    | "\($rem)%" + esc($c) + "(" + (if $s >= 0 then "+" else "" end) + "\($s))" + esc("0") + " " + ($left | dur);

  [ (.model?.id? | strings | ltrimstr("claude-") | split("-")[0] // "" | select(length > 0) | cap),
    (.effort?.level? | strings | select(length > 0) | cap),
    (.context_window? | objects | ctx | "CTX \(.)%"),
    (.rate_limits?.five_hour? | objects | win(18000)),
    (.rate_limits?.seven_day? | objects | win(604800))
  ] | join(" " + esc("1") + "•" + esc("0") + " ")
'

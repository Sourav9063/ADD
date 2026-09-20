#!/usr/bin/env bash
# Claude Code statusline: model, effort, context use, and both rate-limit
# windows shown as "remaining (surplus vs even-burn pace) time-to-reset".
# Everything happens in one jq pass so each redraw costs a single process.

exec jq -r '
  def cap: if . == "" then "" else (.[0:1] | ascii_upcase) + (.[1:] | ascii_downcase) end;

  # Colour unless NO_COLOR is set. Only the separators and the surplus carry
  # styling, so the plain numbers are what you actually read.
  def c($code): if ($ENV.NO_COLOR // "") == "" then "\u001b[\($code)m\(.)\u001b[0m" else . end;

  def hm: (. / 3600 | floor) as $h | (. % 3600 / 60 | floor) as $m
          | if $h > 0 then "\($h)h\($m)m" else "\($m)m" end;
  def dh: (. / 86400 | floor) as $d
          | if $d > 0 then "\($d)d\(. % 86400 / 3600 | floor)h" else hm end;

  def pct(v): if (v | type) == "number" then (v | round) else null end;
  def secs(v): if (v | type) == "number" then ((v - now) | floor) else null end;

  # $total is the window length in seconds: the share of it still on the clock
  # is the quota you would have left burning evenly, so remaining minus that
  # is the surplus. Positive means ahead of budget.
  def window(used; resets; $total; $days):
    pct(used) as $used | secs(resets) as $left
    | if $used == null or $left == null then empty
      else (if $left < 0 then 0 elif $left > $total then $total else $left end) as $left
      | (100 - $used) as $rem
      | ($rem - (($left * 100 / $total) | round)) as $surplus
      | (if $surplus >= 0 then "(+\($surplus))" else "(\($surplus))" end
         | c("2;\(if $surplus >= 0 then 32 elif $surplus >= -10 then 33 else 31 end)")) as $delta
      | "\($rem)%\($delta) \($left | if $days then dh else hm end)"
      end;

  [
    (.model.id // "" | ltrimstr("claude-") | split("-")[0] // "" | cap),
    (.effort.level // "" | cap),
    (pct(.context_window.used_percentage) | if . == null then empty else "CTX \(.)%" end),
    window(.rate_limits.five_hour.used_percentage;
           .rate_limits.five_hour.resets_at; 18000; false),
    window(.rate_limits.seven_day.used_percentage;
           .rate_limits.seven_day.resets_at; 604800; true)
  ]
  | map(select(. != "")) | join(" • " | c(1))
'
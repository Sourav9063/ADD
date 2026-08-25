#!/usr/bin/env bash

IFS=$'\x1f' read -r model effort ctx_used five_pct five_left seven_pct seven_left < <(
  jq -r '
    def num(v): if (v | type) == "number" then (v | round | tostring) else "" end;
    def left(v): if (v | type) == "number" then ((v - now) | floor | tostring) else "" end;
    def cap: if . == "" then "" else (.[0:1] | ascii_upcase) + (.[1:] | ascii_downcase) end;
    [
      (.model.id // "" | ltrimstr("claude-") | split("-")[0] // "" | cap),
      (.effort.level // "" | cap),
      num(.context_window.used_percentage),
      num(.rate_limits.five_hour.used_percentage),
      left(.rate_limits.five_hour.resets_at),
      num(.rate_limits.seven_day.used_percentage),
      left(.rate_limits.seven_day.resets_at)
    ] | join("")'
)

parts=()

[ -n "$model" ] && parts+=("$model")
[ -n "$effort" ] && parts+=("$effort")
[ -n "$ctx_used" ] && parts+=("CTX:${ctx_used}%")

if [ -n "$five_pct" ] && [ -n "$five_left" ]; then
  if [ "$five_left" -le 0 ]; then
    time_str="0m"
  else
    h=$(( five_left / 3600 ))
    m=$(( five_left % 3600 / 60 ))
    [ "$h" -gt 0 ] && time_str="${h}h${m}m" || time_str="${m}m"
  fi
  parts+=("$(( 100 - five_pct ))%:${time_str}")
fi

if [ -n "$seven_pct" ] && [ -n "$seven_left" ]; then
  if [ "$seven_left" -le 0 ]; then
    time_str="0d"
  else
    time_str="$(( seven_left / 86400 ))d$(( seven_left % 86400 / 3600 ))h"
  fi
  parts+=("$(( 100 - seven_pct ))%:${time_str}")
fi

printf '%s\n' "$(IFS='|'; s="${parts[*]}"; echo "${s//|/ • }")"

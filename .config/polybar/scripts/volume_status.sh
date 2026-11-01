#!/usr/bin/env bash
# Volume module for polybar on Termux

info=$(termux-volume 2>/dev/null) || exit 0

if command -v jq >/dev/null 2>&1; then
    vol=$(jq -r '.[] | select(.stream == "music") | .volume' <<<"$info" | head -n1)
else
    vol=$(sed -n '/"music"/,/}/s/.*"volume": *\([0-9]*\).*/\1/p' <<<"$info" | head -n1)
fi

[[ $vol =~ ^[0-9]+$ ]] || vol=0

if (( vol == 0 )); then
    icon=$'\uf026'                      # muted
elif (( vol <= 30 )); then
    icon=$'\uf027'                      # low
else
    icon=$'\uf028'                      # high
fi

printf '%s %s%%\n' "$icon" "$vol"

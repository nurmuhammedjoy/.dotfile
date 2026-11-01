#!/usr/bin/env bash
# battery module for polybar on Termux

status=$(termux-battery-status 2>/dev/null) || exit 0

if command -v jq >/dev/null 2>&1; then
    capacity=$(jq -r '.percentage // empty' <<<"$status")
    charging=$(jq -r '.charging // false' <<<"$status")
else
    capacity=$(sed -n 's/.*"percentage": *\([0-9]*\).*/\1/p' <<<"$status")
    charging=$(sed -n 's/.*"charging": *\([a-z]*\).*/\1/p' <<<"$status")
fi

[[ $capacity =~ ^[0-9]+$ ]] || capacity=0

if [[ $charging == true ]]; then
    icon=$'\uf1e6'                      # charging
elif (( capacity >= 90 )); then
    icon=$'\uf240'                      # full
elif (( capacity >= 70 )); then
    icon=$'\uf241'                      # 75%
elif (( capacity >= 50 )); then
    icon=$'\uf242'                      # 50%
elif (( capacity >= 20 )); then
    icon=$'\uf243'                      # 25%
else
    icon=$'\uf244'                      # empty
fi

printf '%s %s%%\n' "$icon" "$capacity"

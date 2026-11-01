#!/usr/bin/env bash
# Wi-Fi signal module for polybar on Termux

info=$(termux-wifi-connectioninfo 2>/dev/null) || exit 0

if command -v jq >/dev/null 2>&1; then
    rssi=$(jq -r '.rssi // empty' <<<"$info")
else
    rssi=$(sed -n 's/.*"rssi": *\(-\{0,1\}[0-9]*\).*/\1/p' <<<"$info")
fi

[[ $rssi =~ ^-?[0-9]+$ ]] || rssi=-100

# Map RSSI (-100..0 dBm) to 0..100%
quality=$(( (rssi + 100) * 2 ))
(( quality < 0 )) && quality=0
(( quality > 100 )) && quality=100

if (( quality >= 75 )); then
    icon=$'\U000f0928'                  # strong
elif (( quality >= 50 )); then
    icon=$'\U000f0925'                  # medium
elif (( quality >= 25 )); then
    icon=$'\U000f091f'                  # weak
else
    icon=$'\U000f092e'                  # very weak
fi

# Always display a generic label
printf '%s %s\n' "$icon" "${NETWORK_LABEL:-Joy}"

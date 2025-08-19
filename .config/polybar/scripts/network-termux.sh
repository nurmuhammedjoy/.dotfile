#!/data/data/com.termux/files/usr/bin/bash

info=$(termux-wifi-connectioninfo)
rssi=$(echo "$info" | jq '.rssi')

# Convert RSSI to 0–100% (approximation)
quality=$(( (rssi + 100) * 2 ))
quality=$(( quality < 0 ? 0 : (quality > 100 ? 100 : quality) ))

# Pick icon based on signal quality
if [ "$quality" -ge 75 ]; then
    icon="󰤨"   # strong
elif [ "$quality" -ge 50 ]; then
    icon="󰤥"   # medium
elif [ "$quality" -ge 25 ]; then
    icon="󰤟"   # weak
else
    icon="󰤮"   # very weak
fi

# Always display generic label
ssid=" Joy"

echo "$icon $ssid"

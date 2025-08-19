#!/data/data/com.termux/files/usr/bin/bash

vol=$(termux-volume | grep '"music"' -A2 | grep '"volume"' | awk -F ': ' '{print $2}' | tr -d ', ')

# If empty, default to 0
[ -z "$vol" ] && vol=0

# Pick icon by volume
if [ "$vol" -eq 0 ]; then
    icon=" "   # muted
elif [ "$vol" -le 30 ]; then
    icon=" "   # low
else
    icon=" "   # high
fi

echo "$icon $vol%"

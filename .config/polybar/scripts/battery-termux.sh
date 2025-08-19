#!/data/data/com.termux/files/usr/bin/bash

capacity=$(termux-battery-status | grep 'percentage' | awk -F ': ' '{print $2}' | tr -d ', ')
charging=$(termux-battery-status | grep 'charging' | awk -F ': ' '{print $2}' | tr -d ', ')

if [ "$charging" = "true" ]; then
    icon=""   # charging
else
    if   [ "$capacity" -ge 90 ]; then icon=""  # full
    elif [ "$capacity" -ge 70 ]; then icon=""  # 75%
    elif [ "$capacity" -ge 50 ]; then icon=""  # 50%
    elif [ "$capacity" -ge 20 ]; then icon=""  # 25%
    else icon=""  # empty
    fi
fi

# Output
echo "$icon $capacity%"

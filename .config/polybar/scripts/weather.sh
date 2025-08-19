#!/usr/bin/env bash
# ~/.config/polybar/weather-nerd.sh
# Usage:
#   weather-nerd.sh [City] [--short]
# Examples:
#   weather-nerd.sh Dhaka
#   weather-nerd.sh "New York" --short

# Take all arguments until the last one as city (to support spaces)
if [[ "$#" -gt 0 && "$*" != *"--short"* ]]; then
  CITY="$*"
else
  CITY="Dhaka"
fi

# Detect if short flag is passed
SHORT=false
[[ "$*" == *"--short"* ]] && SHORT=true

# Fetch weather
RAW=$(curl -s "wttr.in/${CITY}?format=%C|%t" || echo "N/A|N/A")

COND=$(echo "$RAW" | cut -d'|' -f1 | tr '[:upper:]' '[:lower:]' | xargs)
TEMP=$(echo "$RAW" | cut -d'|' -f2 | sed 's/+//' | xargs)

# Default icon
ICON=""

case "$COND" in
*clear* | *sunny*) ICON="󰖐" ;;             # sun
*partly* | *few* | *overcast*) ICON="" ;; # partly cloudy
*cloud* | *clouds*) ICON="󰅣" ;;            # clouds
*rain* | *drizzle* | *shower*) ICON="" ;; # rain
*thunder* | *storm*) ICON="" ;;           # thunderstorm
*snow* | *sleet*) ICON="" ;;              # snow
*mist* | *fog* | *haze*) ICON="" ;;       # fog
*night* | *moon*) ICON="" ;;              # moon
*) ICON="" ;;
esac

# Fallbacks
[[ "$TEMP" == "N/A" ]] && TEMP="--°C"
[[ "$RAW" == "N/A|N/A" ]] && CITY="Unknown"

# Output
if $SHORT; then
  printf '%s %s\n' "$ICON" "$TEMP"
else
  printf '%s %s %s\n' "$ICON" " $CITY" "$TEMP"
fi

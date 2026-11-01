#!/usr/bin/env bash
# Weather module for polybar (data from wttr.in)

set -uo pipefail

CITY="Dhaka"
SHORT=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --short|-s) SHORT=true ;;
        *) ARGS+=("$arg") ;;
    esac
done

if (( ${#ARGS[@]} )); then
    CITY="${ARGS[*]}"
fi

RAW=$(curl -fsS --max-time 5 "https://wttr.in/${CITY// /+}?format=%C|%t" 2>/dev/null) || true
[[ -n $RAW ]] || RAW="N/A|N/A"

COND=${RAW%%|*}
TEMP=${RAW#*|}
COND=$(printf '%s' "$COND" | tr '[:upper:]' '[:lower:]' | xargs)
TEMP=$(printf '%s' "$TEMP" | sed 's/+//' | xargs)

ICON=$'\uf059'

case "$COND" in
    *clear*|*sunny*)                 ICON=$'\U000f0590' ;;   # sun
    *partly*|*few*|*overcast*)       ICON=$'\ue301'     ;;   # partly cloudy
    *cloud*|*clouds*)                ICON=$'\U000f0163' ;;   # clouds
    *rain*|*drizzle*|*shower*)       ICON=$'\ue308'     ;;   # rain
    *thunder*|*storm*)               ICON=$'\ue30f'     ;;   # thunderstorm
    *snow*|*sleet*)                  ICON=$'\ue30a'     ;;   # snow
    *mist*|*fog*|*haze*)             ICON=$'\ue313'     ;;   # fog
    *night*|*moon*)                  ICON=$'\uf186'     ;;   # moon
esac

[[ $TEMP == "N/A" || -z $TEMP ]] && TEMP="--°C"
[[ $RAW == "N/A|N/A" ]] && CITY="Unknown"

if [[ $SHORT == true ]]; then
    printf '%s %s\n' "$ICON" "$TEMP"
else
    printf '%s %s %s\n' "$ICON" "$CITY" "$TEMP"
fi

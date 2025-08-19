#!/data/data/com.termux/files/usr/bin/bash

PLAYER="$HOME/.config/mpv/player"

# Build control menu
MENU=" Play\n Pause\n Stop\n Previous\n Next"

# Show Rofi menu for controls
CHOICE=$(echo -e "$MENU" | rofi -dmenu -i -p "Controls" -theme ~/.config/rofi/music-control.rasi)

# Map choice to action
case "$CHOICE" in
" Play") $PLAYER play ;;
" Pause") $PLAYER pause ;;
" Stop") $PLAYER stop ;;
" Previous") $PLAYER prev ;;
" Next") $PLAYER next ;;
esac

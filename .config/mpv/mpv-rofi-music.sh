#!/data/data/com.termux/files/usr/bin/bash

PLAYER="$HOME/.config/mpv/player"
PLAYLIST="$HOME/.config/mpv/playlist.txt"
NOW_PLAYING="$HOME/.config/mpv/now_playing.txt"
MUSIC_DIR="$HOME/music"

# Auto-populate playlist if missing or empty
[[ -s "$PLAYLIST" ]] || ls "$MUSIC_DIR"/*.mp3 > "$PLAYLIST"

# Build menu from playlist using array
MENU=()
while read -r track; do
    FILE="$(basename "$track")"
    NAME="${FILE%.*}"   # remove extension
    MENU+=("$NAME")
done < "$PLAYLIST"

# Show Rofi menu for track selection
CHOICE=$(printf '%s\n' "${MENU[@]}" | rofi -dmenu -i -p "Select" -theme ~/.config/rofi/music-select.rasi)

# Find the selected track in playlist
TRACK=$(grep -F -i -m1 "$CHOICE" "$PLAYLIST")

# Play selected track
if [[ -n "$TRACK" ]]; then
    echo "$TRACK" > "$NOW_PLAYING"
    "$PLAYER" play
fi

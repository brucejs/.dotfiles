#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# Screenshot the focused window to clipboard
# https://git.sr.ht/~emersion/grim
grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | tee "$HOME/Pictures/screenshots/$(date +%s).png" | wl-copy

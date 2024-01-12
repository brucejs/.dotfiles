#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# Screenshot the focused display to clipboard
# https://git.sr.ht/~emersion/grim
grim -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" - | tee "$HOME/Pictures/screenshots/$(date +%s).png" | wl-copy

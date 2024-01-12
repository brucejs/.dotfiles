#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# Select a region and screenshot it to clipboard
# https://git.sr.ht/~emersion/grim
grim -g "$(slurp -d)" - | tee "$HOME/Pictures/screenshots/$(date +%s).png" | wl-copy

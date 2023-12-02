#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# Select a region and screenshot it to clipboard
# https://git.sr.ht/~emersion/grim
grim -g "$(slurp -d)" - | wl-copy

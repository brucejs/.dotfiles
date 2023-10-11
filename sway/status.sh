#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# icons: ☀️💡🔇🔈🔉🔊🔋🔌🕯️🪫
BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
BRIGHTNESS_LEVEL=$(brightnessctl get)
BRIGHTNESS_MAX=$(brightnessctl max)
BRIGHTNESS_PERCENTAGE=$(awk "BEGIN { print ($BRIGHTNESS_LEVEL/$BRIGHTNESS_MAX) * 100 }")

function set_battery_icon {
    if [[ $BATTERY_STATUS != "Discharging" ]]; then
        battery_icon='🔌'
    elif [[ $BATTERY_PERCENTAGE -gt 20 ]]; then
        battery_icon='🔋'
    else
        battery_icon='🪫'
    fi
}

function set_brightness_icon {
    if [[ $BRIGHTNESS_PERCENTAGE -ge 80 ]]; then
        brightness_icon='☀️'
    elif [[ $BRIGHTNESS_PERCENTAGE -ge 25 ]]; then
        brightness_icon='💡'
    else
        brightness_icon='🕯️'
    fi
}

set_battery_icon

set_brightness_icon

echo "${BRIGHTNESS_PERCENTAGE}%${brightness_icon} | ${BATTERY_PERCENTAGE}%${battery_icon}"

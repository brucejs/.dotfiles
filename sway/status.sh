#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# icons: ☀️💡🔇🔈🔉🔊🔋🔌🕯️🪫
BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

function set_battery_icon {
    if [[ $BATTERY_STATUS != "Discharging" ]]; then
        battery_icon='🔌'
    elif [[ $BATTERY_PERCENTAGE -gt 20 ]]; then
        battery_icon='🔋'
    else
        battery_icon='🪫'
    fi
}

set_battery_icon

echo "${BATTERY_PERCENTAGE}%${battery_icon}"

#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# icons: ☀️💡🔇🔈🔉🔊🔋🔌🕯️🪫
BACKLIGHT_LEVEL=$(cat /sys/class/backlight/intel_backlight/brightness)
BACKLIGHT_PERCENTAGE=$(brightnessctl -m | awk -F',' '{ print $4 }')
BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
DATE_FORMATTED=$(date +'%a %Y-%m-%d %H:%M')
#VOLUME_LEVEL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

function set_backlight_icon {
    if (($BACKLIGHT_LEVEL >= 15360)); then
        backlight_icon='☀️'
    elif (($BACKLIGHT_LEVEL >= 3840 && $BACKLIGHT_LEVEL < 15360)); then
        backlight_icon='💡'
    else
        backlight_icon='🕯️'
    fi
}

function set_battery_icon {
    if [[ $BATTERY_STATUS != "Discharging" ]]; then
        battery_icon='🔌'
    elif [[ $BATTERY_PERCENTAGE -gt 20 ]]; then
        battery_icon='🔋'
    else
        battery_icon='🪫'
    fi
}

set_backlight_icon

set_battery_icon

echo "${BACKLIGHT_PERCENTAGE}${backlight_icon} | ${BATTERY_PERCENTAGE}%${battery_icon} | $DATE_FORMATTED"

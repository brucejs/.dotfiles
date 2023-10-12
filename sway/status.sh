#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# icons: ☀️ 💡 📣 🔇 🔈 🔉 🔊 🔋 🔌 🕯️ 🪫
BATTERY_PERCENTAGE=$(</sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(</sys/class/power_supply/BAT0/status)
BRIGHTNESS_LEVEL=$(brightnessctl get)
BRIGHTNESS_MAX=$(brightnessctl max)
BRIGHTNESS_PERCENTAGE=$(awk "BEGIN { print ($BRIGHTNESS_LEVEL/$BRIGHTNESS_MAX) * 100 }")
DATE_FORMATTED=$(date '+%a %b %d %l:%M %p')
WPCTL_OUTPUT=$(wpctl get-volume '@DEFAULT_AUDIO_SINK@')
VOLUME_PERCENTAGE=$(echo "$WPCTL_OUTPUT" | awk '{ print $2 * 100 }')

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

function set_volume_icon {
    if [[ $WPCTL_OUTPUT =~ MUTED\]$ ]]; then
        volume_icon='🔇'
    elif [[ $VOLUME_PERCENTAGE -ge 100 ]]; then
        volume_icon='📣'
    elif [[ $VOLUME_PERCENTAGE -ge 80 ]]; then
        volume_icon='🔊'
    elif [[ $VOLUME_PERCENTAGE -ge 25 ]]; then
        volume_icon='🔉'
    else
        volume_icon='🔈'
    fi
}

set_battery_icon

set_brightness_icon

set_volume_icon

echo "${DATE_FORMATTED}🗓️ | ${VOLUME_PERCENTAGE}%${volume_icon} | ${BRIGHTNESS_PERCENTAGE}%${brightness_icon} | ${BATTERY_PERCENTAGE}%${battery_icon}"

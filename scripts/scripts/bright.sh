#!/bin/sh

brightness_as_percent=$(brightnessctl get --percentage --machine-readable)
notify-send \
    --transient \
    --app-name 'brightnessctl' \
    --hint "int:value:$brightness_as_percent" \
    "Brightness: ${brightness_as_percent}%"

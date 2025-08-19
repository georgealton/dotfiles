#!/usr/bin/env bash

case "$1" in
select-copy)
    region=$(slurp)
    echo "$region" | grim -g "-" - | wl-copy &&
        notify-send "Screenshot" "Region: $region\nSent To Clipboard"
    ;;
select-file)
    filename="${HOME}/Pictures/$(date '+%s').png"
    region=$(slurp)
    echo "$region" | grim -g "-" "$filename" &&
        notify-send "Screenshot" "Region: $region\nSent To $filename"
    ;;
*)
    echo invalid option
    ;;
esac

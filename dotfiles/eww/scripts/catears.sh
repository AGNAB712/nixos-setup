#!/usr/bin/env bash

# subscribe to hyprland window geometry events
hyprctl -j activewindow | jq '.id' | while read winid; do
    # spawn eww widget for this window id
    eww open catears --toggle
done

hyprctl events -j | jq -c 'select(.type=="window")' | while read event; do
    winid=$(echo "$event" | jq '.id')
    x=$(echo "$event" | jq '.x')
    y=$(echo "$event" | jq '.y')
    w=$(echo "$event" | jq '.width')
    h=$(echo "$event" | jq '.height')

    # move the ears to the top corners
    eww update catears "{\"x\":$x,\"y\":$y}" # left ear
    eww update catears "{\"x\":$(($x+$w-32)),\"y\":$y}" # right ear
done

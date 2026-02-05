#!/usr/bin/env bash

# get the first running mpris player
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -n "$PLAYER" ]]; then
    playerctl -p "$PLAYER" next 2>/dev/null
    echo "Skipped to next track on $PLAYER."
else
    echo "No media player running."
fi

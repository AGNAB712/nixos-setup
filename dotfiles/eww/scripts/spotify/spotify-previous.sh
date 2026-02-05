#!/usr/bin/env bash

# get the first running mpris player
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -n "$PLAYER" ]]; then
    playerctl -p "$PLAYER" previous 2>/dev/null
    echo "Went to previous track on $PLAYER."
else
    echo "No media player running."
fi

#!/usr/bin/env bash

# exit if playerctl is missing
if ! command -v playerctl &> /dev/null; then
    echo "playerctl not installed"
    exit 1
fi

# get currently playing player (any mpris player)
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -z "$PLAYER" ]]; then
    echo "Offline."
    exit 0
fi

# get the artist from the player
ARTIST=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)

if [[ -z "$ARTIST" ]]; then
    echo "Paused."
else
    # truncate long names
    if [[ ${#ARTIST} -gt 30 ]]; then
        ARTIST="${ARTIST:0:30}..."
    fi
    echo "$ARTIST"
fi

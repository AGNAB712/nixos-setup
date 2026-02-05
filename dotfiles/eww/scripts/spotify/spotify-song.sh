#!/usr/bin/env bash

# check for playerctl
if ! command -v playerctl &> /dev/null; then
    echo "playerctl not installed"
    exit 1
fi

# get the first running mpris player
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -z "$PLAYER" ]]; then
    echo "Not running."
    exit 0
fi

# get the song title
SONG=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)

if [[ -z "$SONG" ]]; then
    echo "Paused."
else
    # truncate long titles
    if [[ ${#SONG} -gt 18 ]]; then
        SONG="${SONG:0:20}.."
    fi
    echo "$SONG"
fi

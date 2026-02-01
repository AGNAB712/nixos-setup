#!/usr/bin/env bash

# get the first running mpris player
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -z "$PLAYER" ]]; then
    # no player running
    echo ""
    exit 0
fi

# get current playback status
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)

if [[ "$STATUS" == "Playing" ]]; then
    # pause the player
    playerctl -p "$PLAYER" pause 2>/dev/null
    echo "󰐊"
else
    # play the player
    playerctl -p "$PLAYER" play 2>/dev/null
    echo "󰏤"
fi

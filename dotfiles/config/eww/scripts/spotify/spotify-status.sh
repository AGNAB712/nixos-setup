#!/usr/bin/env bash

# get the first running mpris player
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

if [[ -z "$PLAYER" ]]; then
    # no player running
    echo ""
    exit 0
fi

# get the playback status
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)

case "$STATUS" in
    "Playing")
        echo "󰏥"
        ;;
    "Paused")
        echo "󰐌"
        ;;
    *)
        echo ""
        ;;
esac

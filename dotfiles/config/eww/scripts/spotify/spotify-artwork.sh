#!/usr/bin/env bash
export PATH=/run/current-system/sw/bin

base_dir="$HOME/.config/eww/images"
mkdir -p "$base_dir"

image_path="$base_dir/image.jpg"
track_cache="$base_dir/track_id.txt"

# get active player (prefer playing)
player=$(playerctl -l 2>/dev/null | while read -r p; do
  status=$(playerctl -p "$p" status 2>/dev/null)
  [[ "$status" == "Playing" ]] && echo "$p" && break
done)

# fallback to first player
if [[ -z "$player" ]]; then
  player=$(playerctl -l 2>/dev/null | head -n1)
fi

# nothing running
if [[ -z "$player" ]]; then
  echo "$image_path"
  exit 0
fi

# fetch metadata
art_url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)
title=$(playerctl -p "$player" metadata title 2>/dev/null)
artist=$(playerctl -p "$player" metadata artist 2>/dev/null)

# validate
if [[ -z "$art_url" || -z "$title" ]]; then
  echo "$image_path"
  exit 0
fi

track_id="$artist - $title"
prev_id=$(cat "$track_cache" 2>/dev/null)

# download art only on change
if [[ "$track_id" != "$prev_id" ]]; then
  rm -f "$image_path"
  curl -sL "$art_url" -o "$image_path"
  echo "$track_id" > "$track_cache"
fi

echo "$image_path"

#!/usr/bin/env bash

INPUT="$HOME/hyprdecor/assets/cat/cat_base.png"
FRAME="$HOME/hyprdecor/assets/cat/frame.png"
OUTPUT="$HOME/hyprdecor/assets/cat/cat.png"
COLOR_JSON="$HOME/hyprdecor/assets/cat/colors.json"

# read color from json
COLOR_HEX=$(jq -r '.colors.color13' "$COLOR_JSON")

# make sure it has #
[[ "$COLOR_HEX" != \#* ]] && COLOR_HEX="#$COLOR_HEX"

# append FF for full opacity
COLOR_RGBA="${COLOR_HEX}FF"

# recolor template, including semi-transparent pixels
convert "$INPUT" -channel RGBA -fill "$COLOR_RGBA" -colorize 100% recolored.png

# overlay frame on top
convert recolored.png "$FRAME" -compose over -composite "$OUTPUT"

# clean up intermediate file
rm recolored.png

echo "saved final image to $OUTPUT with color $COLOR_RGBA and frame applied"
hyprctl reload

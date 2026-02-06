#!/usr/bin/env bash

INPUT="$HOME/nixos/dotfiles/hyprdecor/assets/cat/cat_base.png"
FRAME="$HOME/nixos/dotfiles/hyprdecor/assets/cat/frame.png"
BASE_OUTPUT="$HOME/nixos/dotfiles/hyprdecor/assets/cat/cat_base_colored.png"
FINAL_OUTPUT="$HOME/nixos/dotfiles/hyprdecor/assets/cat/cat.png"
COLOR_JSON="$HOME/nixos/dotfiles/hyprdecor/assets/cat/colors.json"

# read color from json
COLOR_HEX=$(jq -r '.colors.color13' "$COLOR_JSON")

# make sure it has #
[[ "$COLOR_HEX" != \#* ]] && COLOR_HEX="#$COLOR_HEX"

# append FF for full opacity
COLOR_RGBA="${COLOR_HEX}FF"

# --- Step 1: recolor template ---
convert "$INPUT" -channel RGBA -fill "$COLOR_RGBA" -colorize 100% "$BASE_OUTPUT"
echo "saved recolored base image to $BASE_OUTPUT with color $COLOR_RGBA"

# --- Step 2: overlay frame ---
convert "$BASE_OUTPUT" "$FRAME" -compose over -composite "$FINAL_OUTPUT"
echo "saved final image to $FINAL_OUTPUT with frame applied"

# reload Hyprland
hyprctl reload

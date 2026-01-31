#!/usr/bin/env bash
set -e

DOTFILES="$HOME/nixos/dotfiles"

mkdir -p "$DOTFILES/config"
mkdir -p "$DOTFILES/home"

CONFIG_FOLDERS=(alacritty fastfetch hypr matugen rofi waybar eww)

for folder in "${CONFIG_FOLDERS[@]}"; do
    src="$HOME/.config/$folder"
    dest="$DOTFILES/config/$folder"

    if [ -d "$src" ]; then
        cp -a "$src" "$dest"
        echo "copied $folder"
    else
        echo "source $src does not exist"
    fi
done

HOME_FOLDERS=(rofi sddm-theme-corners wallpapers hyprdecor)

for folder in "${HOME_FOLDERS[@]}"; do
    src="$HOME/$folder"
    dest="$DOTFILES/home/$folder"


    if [ -d "$src" ]; then
        cp -a "$src" "$dest"
        echo "copied $folder"
    else
        echo "source $src does not exist"
    fi
done

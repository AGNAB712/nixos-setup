#!/usr/bin/env bash
set -e

DOTFILES=~/nixos/dotfiles

mkdir -p "$DOTFILES/config"
mkdir -p "$DOTFILES/home"

CONFIG_FOLDERS=(alacritty fastfetch hypr matugen rofi waybar eww)

for folder in "${CONFIG_FOLDERS[@]}"; do
    src="$HOME/.config/$folder"
    dest="$DOTFILES/config/$folder"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Skipping $folder, already exists"
    else
        ln -s "$src" "$dest"
        echo "Linked $folder"
    fi
done

HOME_FOLDERS=(bin rofi sddm-theme-corners wallpapers esp-keyboard-detector)

for folder in "${HOME_FOLDERS[@]}"; do
    src="$HOME/$folder"
    dest="$DOTFILES/home/$folder"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Skipping $folder, already exists"
    else
        ln -s "$src" "$dest"
        echo "Linked $folder"
    fi
done

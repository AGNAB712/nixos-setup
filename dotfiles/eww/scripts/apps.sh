#!/usr/bin/env bash

if [[ "$1" == "--alacritty" ]]; then
	alacritty &

elif [[ "$1" == "--librewolf" ]]; then
	librewolf &

elif [[ "$1" == "--dolphin" ]]; then
	dolphin ~ &

elif [[ "$1" == "--mullvad" ]]; then
	mullvad-vpn &


elif [[ "$1" == "--github" ]]; then
	github-desktop &


elif [[ "$1" == "--jellyfin" ]]; then
	jellyfin-desktop &
	
elif [[ "$1" == "--codium" ]]; then
	codium &
	
elif [[ "$1" == "--manual" ]]; then
	nixos-help &
elif [[ "$1" == "--android" ]]; then
	android-studio &
fi

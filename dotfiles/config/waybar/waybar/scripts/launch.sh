pkill waybar >/dev/null 2>&1
waybar -c ~/.config/waybar/config.jsonc >/dev/null 2>&1 & disown
waybar -c ~/.config/waybar/config-top.jsonc >/dev/null 2>&1 & disown

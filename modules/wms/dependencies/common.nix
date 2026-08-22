{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    quickshell
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtquickcontrols
    libnotify
    nwg-look
    awww
    adwaita-icon-theme
    gtk-engine-murrine
    playerctl
    eww
    cava
    imagemagick 
    jq
    networkmanager_dmenu
    mission-center
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-extras
    hypridle
    wl-clipboard
   (pkgs.writeShellScriptBin "cliphisty" ''
      #!/usr/bin/env bash

      selection=$(
        cliphist list |
          ${pkgs.rofi}/bin/rofi \
            -dmenu \
            -i \
            -p "Clipboard" \
            -theme "$HOME/nixos/dotfiles/rofi/launchers/copy.rasi"
      )

      [ -n "$selection" ] && cliphist decode <<< "$selection" | wl-copy
    '')
    (pkgs.writeShellScriptBin "sscpy" ''
      #!/usr/bin/env bash

      grim -t png - | wl-copy --type image/png
    '')
  ];  

  #adding this here so that i can bypass the wrapped rofi so that i can add a custom theme for displaying wifi through dmenu
  home-manager.users.agnab = {
    xdg.configFile."networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = ${pkgs.rofi}/bin/rofi -theme ~/nixos/dotfiles/rofi/launchers/wifi.rasi
      active_chars = ==
      highlight = False
      highlight_fg =
      highlight_bg =
      highlight_bold = True
      compact = False
      pinentry =
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:<{max_len_name}s}  {sec:<{max_len_sec}s} {icon:>4}
      list_saved = False
      prompt = Networks

      [dmenu_passphrase]
      obscure = False
      obscure_color = #222222

      [pinentry]
      description = Get network password
      prompt = Password:

      [editor]
      terminal = alacritty
      gui_if_available = True
      gui = nm-connection-editor

      [nmdm]
      rescan_delay = 5
    '';
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}

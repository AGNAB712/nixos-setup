{ config, pkgs, inputs, ... }:


let
  tailscaleMenu = pkgs.writeShellApplication {
    name = "tailscale-menu";

    runtimeInputs = with pkgs; [
      tailscale
      rofi
      gnused
    ];

    text = ''
      accounts="$(
        tailscale switch --list |
          tail -n +2 |
          awk '{
            printf "%s\t%s (%s)\n", $1, $2, $3
          }'
      )"

      choice="$(
        printf '%s\n' "$accounts" |
          rofi -dmenu \
            -p "Tailscale" \
            -theme "$HOME/nixos/dotfiles/rofi/launchers/wifi.rasi"
      )" || exit 0

      [ -z "$choice" ] && exit 0

      id="$(printf '%s\n' "$choice" | awk '{print $1}')"

      tailscale switch "$id"
    '';
  };
in
{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";
  home.stateVersion = "25.05";
  
  programs.zsh.enable = true;

  #for tailscale
  home.packages = [
    tailscaleMenu
  ];

  services.cliphist = {
    enable = true;
    systemdTargets = ["config.wayland.systemd.target"];
    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
    allowImages = true;
  };

  services.gammastep = {
    enable = true;
    provider = "manual";

    latitude = 44.9778;
    longitude = -93.2650; #minneapolis

    temperature = {
      day = 6500;
      night = 4000;
    };

    settings.general = {
      adjustment-method = "wayland";
      fade = 1;
    };
  };

  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  
}

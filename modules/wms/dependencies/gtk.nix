{ config, pkgs, lib, inputs, wrappers, ... }:

let
  installPringle = pkgs.writeShellScriptBin "install-pringle" ''
    ICON_SRC="$HOME/nixos/dotfiles/hidden/gtktheme/pringle"
    ICON_DST="$HOME/.local/share/icons/pringle/"
    mkdir -p "$ICON_DST"
    cp -r "$ICON_SRC"/* "$ICON_DST"
  '';
in
{
  environment.systemPackages = [
    installPringle
  ];

  systemd.user.services.installPringle = {
    description = "install icon theme i made with kelly pringle's art";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${installPringle}/bin/install-pringle";
      Type = "oneshot";
    };
  };


  programs.mango.enable = true; 

}

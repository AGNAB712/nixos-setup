{ config, pkgs, lib, ... }:

let
  sddmCorners = pkgs.callPackage ./../../packages/sddm-corners/sddm-corners.nix {};
  mangowcSession = pkgs.runCommand "mangowc-session" {
    passthru.providedSessions = [ "mangowc" ];
  } ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/mangowc.desktop <<EOF
  [Desktop Entry]
  Name=MangoWC
  Comment=Wayland session for MangoWC
  Exec=mango
  Type=Application
  Keywords=wayland
  EOF
  '';
in
{
  environment.systemPackages = with pkgs; [
    sddmCorners
    pkgs.qt6.qt5compat
  ];  

  services.displayManager.sddm = {
    enable = true;
    theme = "corners";
    extraPackages = [ sddmCorners pkgs.qt6.qt5compat ];
    wayland.enable = true;
  };
  services.xserver.enable = true;
  services.displayManager.sessionPackages = [ mangowcSession ];
  services.displayManager.defaultSession = "mangowc";
}

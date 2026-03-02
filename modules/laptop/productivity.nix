{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    librewolf
    pywalfox-native
    pywal
    git
    gh
    github-desktop
    nodejs
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-extras
    openssh
    jellyfin-desktop
    moonlight-qt
    mission-center
    vesktop
    gtk3
    python3
    gobject-introspection
  ];


  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
  ];

  environment.etc."profile.d/librewolf/sh".text = ''
    export MOZ_ENABLE_WAYLAND=1
    export LIBGL_DRI3_DISABLE=1
  '';

  
}

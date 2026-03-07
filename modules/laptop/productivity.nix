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
    openssh
    jellyfin-desktop
    moonlight-qt
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

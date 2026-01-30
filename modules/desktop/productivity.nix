{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    librewolf
    pywalfox-native
    pywal
    vscodium
    git
    github-desktop
    discord
    arduino-ide
    python3
    nodejs
    rembg
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-extras
    openssh
    blender
    android-studio
    jellyfin-desktop
    cmake
    gcc
    gnumake
    clang

  ];

  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
  ];

  environment.etc."profile.d/librewolf/sh".text = ''
    export MOZ_ENABLE_WAYLAND=1
    export LIBGL_DRI3_DISABLE=1
  '';
}

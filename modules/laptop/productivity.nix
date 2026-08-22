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
    python313Packages.pip
    appimage-run
    tauon
  ];

  programs.dconf.profiles.user.databases = [{
  settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}];
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  services.openssh.enable = true;

  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
    "com.discordapp.Discord"
  ];
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  environment.etc."profile.d/librewolf/sh".text = ''
    export MOZ_ENABLE_WAYLAND=1
    export LIBGL_DRI3_DISABLE=1
  '';

  
}

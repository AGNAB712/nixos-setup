{ pkgs, inputs, ... }:


{
  nixpkgs.overlays = [
    (final: prev: {
      tauon = prev.tauon.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace src/tauon/t_modules/t_main.py \
            --replace-fail 'from pypresence import ActivityType, StatusDisplayType, Presence' 'from lynxpresence import ActivityType, StatusDisplayType, Presence' \
            --replace-fail 'is_module_loaded("pypresence", "ActivityType")' 'is_module_loaded("lynxpresence", "ActivityType")' \
            --replace-fail 'Missing dependency python-pypresence' 'Missing dependency lynxpresence'
        '';
      });
    })
  ];

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
    eclipses.eclipse-java
    jdk
    flutter
  ];

  programs.nix-ld.enable = true;

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

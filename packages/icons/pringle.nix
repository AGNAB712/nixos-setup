{ pkgs }:

pkgs.stdenv.mkDerivation {
      pname = "pringle-icons";
      version = "1.0";

      src = ../../dotfiles/hidden/gtktheme/pringle;

      installPhase = ''
        mkdir -p ~/.local/share/icons/pringle
        cp -r * ~/.local/share/icons/pringle
      '';
    }
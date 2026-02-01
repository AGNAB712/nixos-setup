{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "sddm-theme-corners";
  version = "unstable";

  src = ./.;

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r corners/ $out/share/sddm/themes/corners
  '';
}

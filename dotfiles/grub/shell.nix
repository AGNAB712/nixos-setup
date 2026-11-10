let
  pkgs = import <nixpkgs> {};

  python = pkgs.python3.override {
    self = python;

    packageOverrides = pyfinal: pyprev: {
      grub2-theme-preview =
        pyfinal.callPackage ./grub2-theme-preview.nix {};
    };
  };
in
pkgs.mkShell {
  packages = [
    (python.withPackages (python-pkgs: [
      python-pkgs.grub2-theme-preview
    ]))

    pkgs.grub2_efi
    pkgs.xorriso
    pkgs.OVMF.fd
  ];

shellHook = ''
  export G2TP_GRUB_LIB="${pkgs.grub2_efi}/lib/grub"
  export G2TP_OVMF_IMAGE="${pkgs.OVMF.fd}/FV/OVMF_CODE.fd"
'';
}

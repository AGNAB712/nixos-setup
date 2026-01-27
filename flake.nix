{
  description = "nixos system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    quickshell.url = "github:quickshell-mirror/quickshell";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, nix-flatpak, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              quickshell.overlays.default
            ];
          })
          nix-flatpak.nixosModules.nix-flatpak

          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.agnab = import ./home/agnab.nix;
          }

        ];
      };



    };
  };
}

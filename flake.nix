{
  description = "nixos system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    quickshell.url = "github:quickshell-mirror/quickshell";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, ... }:
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

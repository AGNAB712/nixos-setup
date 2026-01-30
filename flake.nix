{
  description = "nixos system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell.url = "github:quickshell-mirror/quickshell";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, nix-flatpak, hyprland, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [

          # overlay for quickshell
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              quickshell.overlays.default
            ];
          })

          # nix-flatpak module
          nix-flatpak.nixosModules.nix-flatpak

          # your system configuration
          ./hosts/desktop/configuration.nix

          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.agnab = import ./home/agnab.nix;
          }

          # hyprland config pointing to pinned flake package
          ({ pkgs, ... }: {
            programs.hyprland.enable = true;
            programs.hyprland.package = hyprland.packages.${system}.hyprland;
            # optional: portal package
            programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
          })

        ];
      };
    };
  };
}

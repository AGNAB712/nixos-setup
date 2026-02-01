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
    nixcord.url = "github:FlameFlag/nixcord";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agnabot.url = "github:AGNAB712/agnabot";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, quickshell, nix-flatpak, hyprland, nixcord, ... }:
  let
    system = "x86_64-linux";
  in
  {
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
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.agnab = import ./home/agnab.nix;
          }

          ({ pkgs, ... }: {
            programs.hyprland.enable = true;
            programs.hyprland.package = hyprland.packages.${system}.hyprland;
            programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
          })
        ];
      };

      homeserver = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/home-server/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.agnab = import ./home/agnab.nix;
          }
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.agnab = import ./home/agnab.nix;
          }

          ({ pkgs, ... }: {
            programs.hyprland.enable = true;
            programs.hyprland.package = hyprland.packages.${system}.hyprland;
            programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
          })
        ];
      };
    };
  };
}

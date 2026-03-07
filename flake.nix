{
  description = "nixos system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    nixcord.url = "github:FlameFlag/nixcord";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:lassulus/wrappers";
    openclaw.url = "github:openclaw/nix-openclaw"; 

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, hyprland, nixcord, wrappers, openclaw, mango, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; }; 
        modules = [          

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

          #homeless dotfiles via wrappers
          ({ pkgs, ... }: {
            programs.hyprland.package = 
            wrappers.lib.wrapPackage {
                inherit pkgs;
                package = hyprland.packages.${system}.hyprland;
                flags = {
                  "--config" = "$HOME/nixos/dotfiles/hypr/desktop/hyprland.conf";
                };
              }; 
            programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
            _module.args.wrappers = wrappers.lib;

            programs.mango.package = 
            wrappers.lib.wrapPackage {
                inherit pkgs;
                package = mango.packages.${system}.mango;
                flags = {
                  "-c" = "$HOME/nixos/dotfiles/mango/config.conf";
                };
              }; 
          })

          mango.nixosModules.mango

          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
            ];
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
        system = "x86_64-linux";
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

          #speed i need this my dotfiles are kinda homeless
          ({ pkgs, ... }: {
            programs.hyprland.enable = true;
            programs.hyprland.package = 
            wrappers.lib.wrapPackage {
                inherit pkgs;
                package = hyprland.packages.${system}.hyprland;
                flags = {
                  "--config" = "$HOME/nixos/dotfiles/hypr/laptop/hyprland.conf";
                };
              }; 
            programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
            _module.args.wrappers = wrappers.lib;

            programs.mango.package = 
            wrappers.lib.wrapPackage {
                inherit pkgs;
                package = mango.packages.${system}.mango;
                flags = {
                  "-c" = "$HOME/nixos/dotfiles/mango/config.conf";
                };
              }; 
          })

          mango.nixosModules.mango

        ];
      };
    };

  };
}

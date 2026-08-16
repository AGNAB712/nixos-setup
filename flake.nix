{
  description = "nixos system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    nixcord.url = "github:FlameFlag/nixcord";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:lassulus/wrappers";

    openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:mangowm/mango/wl-only";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-plymouth.url = "github:BeatLink/nixos-plymouth";

  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-flatpak
    , nixcord
    , wrappers
    , openclaw
    , mango
    , nixos-plymouth
    , ...
    }@inputs:

    let
      system = "x86_64-linux";

      openclawOverlayModule = {
        nixpkgs.overlays = [
          inputs.openclaw.overlays.default
        ];
      };

      homeManagerForAgnab = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };

        home-manager.users.agnab = { ... }: {
          imports = [
            ./home/agnab.nix
            inputs.openclaw.homeManagerModules.openclaw
          ];
        };
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
          };

          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hosts/desktop/configuration.nix

            openclawOverlayModule

            home-manager.nixosModules.home-manager
            homeManagerForAgnab

            ({ pkgs, ... }: {
              _module.args.wrappers = wrappers.lib;

              programs.mango.package =
                wrappers.lib.wrapPackage {
                  inherit pkgs;

                  package = mango.packages.${system}.mango.overrideAttrs (old: {
                    buildInputs = old.buildInputs ++ [
                      pkgs.wlroots_0_20
                    ];
                  });

                  flags = {
                    "-c" = "$HOME/nixos/dotfiles/mango/config.conf";
                  };
                };
            })

            mango.nixosModules.mango
            nixos-plymouth.nixosModules.default
          ];
        };

        homeserver = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
          };

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

          specialArgs = {
            inherit inputs;
          };

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
              _module.args.wrappers = wrappers.lib;

              programs.mango.package =
                wrappers.lib.wrapPackage {
                  inherit pkgs;

                  package = mango.packages.${system}.mango.overrideAttrs (old: {
                    buildInputs = old.buildInputs ++ [
                      pkgs.wlroots_0_20
                    ];
                  });

                  flags = {
                    "-c" = "$HOME/nixos/dotfiles/mango/config.conf";
                  };
                };
            })

            mango.nixosModules.mango
            nixos-plymouth.nixosModules.default
          ];
        };

        stoutbook = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
          };

          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hosts/stoutbook/configuration.nix

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
              _module.args.wrappers = wrappers.lib;

              programs.mango.package =
                wrappers.lib.wrapPackage {
                  inherit pkgs;

                  package = mango.packages.${system}.mango.overrideAttrs (old: {
                    buildInputs = old.buildInputs ++ [
                      pkgs.wlroots_0_20
                    ];
                  });

                  flags = {
                    "-c" = "$HOME/nixos/dotfiles/mango/laptop-config.conf";
                  };
                };
            })

            mango.nixosModules.mango
            nixos-plymouth.nixosModules.default
          ];
        };
      };
    };
}

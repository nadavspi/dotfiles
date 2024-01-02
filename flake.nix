{
  description = "nadavspi/dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    overlays = [inputs.neovim-nightly-overlay.overlay];
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit overlays system;
            config.allowUnfree = true;
          };
        });
  in {
    homeConfigurations = {
      "nadavspi@stuttgart.nadav.is" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          ./home-manager/gui.nix
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "nadavspi@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "nadavspi@nixos-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          ./home-manager/gui.nix
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "nadavspi@strasbourg" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-stable.legacyPackages.aarch64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };
      "nadavspi@shanghai" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          ./home-manager/gui.nix
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "nadavspi@fedora" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/home/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          ./home-manager/gui.nix
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "nadavspi@mac-mini-m2.local" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/Users/nadavspi/src/dotfiles";
        };
        modules = [
          ./home-manager
          ./home-manager/mac.nix
          {
            home = rec {
              username = "nadavspi";
              homeDirectory = "/Users/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };

      "spiegeln@C02DP0G0MD6V" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        extraSpecialArgs = {
          inherit inputs;
          dotfiles = "/Users/spiegeln/src/dotfiles";
        };
        modules = [
          ./home-manager
          {
            home = rec {
              username = "spiegeln";
              homeDirectory = "/Users/${username}";
            };
          }
          {nixpkgs.overlays = overlays;}
        ];
      };
    };

    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      prague = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./nixos/hosts/prague];
      };

      strasbourg = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./nixos/hosts/strasbourg];
      };

      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./nixos/hosts/nixos-desktop];
      };

      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ];
      };
    };

    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nixos-rebuild
          sops
        ];
      };
    });
  };
}

{
  description = "nadavspi/dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    overlays = [inputs.neovim-nightly-overlay.overlay];
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
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
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
      "nadavspi@shanghai.nadav.is" = home-manager.lib.homeManagerConfiguration {
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
        specialArgs = {inherit inputs outputs overlays;};
        modules = [./nixos/hosts/prague];
      };

      strasbourg = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs overlays;};
        modules = [./nixos/hosts/strasbourg];
      };

      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs overlays;};
        modules = [./nixos/hosts/nixos-desktop];
      };

      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs overlays;};
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./nixos/hosts/stuttgart
        ];
      };
    };
  };
}

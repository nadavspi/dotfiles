{
  description = "nadavspi/dotfiles";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.tar.gz";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    home-manager,
    nixos-hardware,
    nixpkgs,
    self,
    sops-nix,
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
        modules = [./nixos/hosts/prague sops-nix.nixosModules.sops];
      };

      strasbourg = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs overlays;};
        modules = [./nixos/hosts/strasbourg sops-nix.nixosModules.sops];
      };

      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs overlays;};
        modules = [./nixos/hosts/nixos-desktop sops-nix.nixosModules.sops];
      };
    };
  };
}

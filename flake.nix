{
  description = "nadavspi/dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
    
      "nadavspi@stuttgart" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };

      "nadavspi@shanghai" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
      "nadavspi@fedora" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          ./home-manager/gui.nix 
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
      "nadavspi@mac-mini-m2.local" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          ./home-manager/mac.nix
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/Users/${username}";
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };

      "spiegeln@C02DP0G0MD6V" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "spiegeln";
              homeDirectory = "/Users/${username}";
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
    };
  };
}
